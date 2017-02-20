output "openwhisk_crn" {
  value = "${bluemix_openwhisk_function.video_stills_function.crn}"
}

output "input_bucket_crn" {
  value = "${bluemix_object_storage_bucket.input_bucket.crn}"
}

output "content_bucket_crn" {
  value = "${bluemix_object_storage_bucket.content_bucket.crn}"
}

output "thumbnail_bucket_crn" {
  value = "${bluemix_object_storage_bucket.thumbnail_bucket.crn}"
}
