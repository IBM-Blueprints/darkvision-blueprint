// ####################
// ## Object Storage ##
// ####################
resource "bluemix_object_storage_bucket" "input_bucket" {
  bucket = "${var.composite_name}-input"
  acl = "private"
  tags {
    Name = "Darkvision Video Stills Input"
  }
  versioning {
    enabled = false
  }
  lifecycle_rule {
    enabled = true
    prefix = ""
    noncurrent_version_expiration {
      days = "5"
    }
  }
}

resource "bluemix_object_storage_bucket" "content_bucket" {
  bucket = "${var.composite_name}-content"
  acl = "private"
  tags {
    Name = "Darkvision Video Stills Content"
  }
  versioning {
    enabled = false
  }
  lifecycle_rule {
    enabled = true
    prefix = ""
    noncurrent_version_expiration {
      days = "5"
    }
  }
}


resource "bluemix_object_storage_bucket" "thumbnail_bucket" {
  bucket = "${var.composite_name}-thumbnails"
  acl = "private"
  tags {
    Name = "Darkvision Video Stills Thumbnails"
  }
  versioning {
    enabled = false
  }
  lifecycle_rule {
    enabled = true
    prefix = ""
    noncurrent_version_expiration {
      days = "5"
    }
  }
}


// #######################################
// ## Watson Visual Recognition Service ##
// #######################################
resource "bluemix_watson_visual_recognition" "watson_vr" {
  input_bucket = "${bluemix_object_storage.input_bucket.bucket}"
  name         = "${var.composite_name}"

  content_config = {
    bucket        = "${bluemix_object_storage.content_bucket.bucket}"
    storage_class = "Standard"
  }

  thumbnail_config = {
    bucket        = "${bluemix_object_storage.thumbnail_bucket.bucket}"
    storage_class = "Standard"
  }
}

resource "bluemix_watson_visual_recognition_preset" "watson_vr_preset" {
  container   = "mp4"
  description = "Darkvision Watson Visual Recognition"
  name        = "${var.composite_name}"

  audio = {
    audio_packing_mode = "SingleTrack"
    bit_rate           = 96
    channels           = 2
    codec              = "AAC"
    sample_rate        = 44100
  }

  audio_codec_options = {
    profile = "AAC-LC"
  }

  video = {
    bit_rate             = "1600"
    codec                = "H.264"
    display_aspect_ratio = "16:9"
    fixed_gop            = "false"
    frame_rate           = "auto"
    max_frame_rate       = "60"
    keyframes_max_dist   = 240
    max_height           = "auto"
    max_width            = "auto"
    padding_policy       = "Pad"
    sizing_policy        = "Fit"
  }

  video_codec_options = {
    Profile                  = "main"
    Level                    = "2.2"
    MaxReferenceFrames       = 3
    InterlaceMode            = "Progressive"
    ColorSpaceConversionMode = "None"
  }

  video_watermarks = {
    id                = "Darkvision-Watson-Viz"
    max_width         = "20%"
    max_height        = "20%"
    sizing_policy     = "ShrinkToFit"
    horizontal_align  = "Right"
    horizontal_offset = "10px"
    vertical_align    = "Bottom"
    vertical_offset   = "10px"
    opacity           = "55.5"
    target            = "Content"
  }

  thumbnails = {
    format         = "png"
    interval       = 120
    max_width      = "auto"
    max_height     = "auto"
    padding_policy = "Pad"
    sizing_policy  = "Fit"
  }
}

// ###############
// ## OpenWhisk ##
// ###############

resource "bluemix_iam_role" "openwhisk" {
  name = "${var.composite_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "openwhisk.bluemix.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "bluemix_iam_policy_document" "create_video_stills" {
  statement {
    sid = "1"
    actions = [
      "bluemix:object_store:*"
    ]
    resources = ["*"]
  }
}

data "archive_file" "openwhisk_function" {
  type        = "zip"
  source_file = "https://github.com/IBM-Bluemix/openwhisk-darkvisionapp/blob/master/processing/extractor/client/extract.js"
  output_path = "./function-archive.zip"
}

resource "bluemix_iam_role_policy" "openwhisk" {
  name = "${var.composite_name}"
  role = "${bluemix_iam_role.openwhisk.name}"

  policy = "${data.bluemix_iam_policy_document.create_video_stills}"
}

resource "bluemix_openwhisk_function" "video_stills_function" {
  runtime          = "nodejs4.3"
  filename         = "./function-archive.zip"
  function_name    = "${var.composite_name}_stills-func"
  role             = "${bluemix_iam_role.openwhisk.crn}"
  handler          = "createDocument"
  source_code_hash = "${data.archive_file.openwhisk_function.output_base64sha256}"
}
