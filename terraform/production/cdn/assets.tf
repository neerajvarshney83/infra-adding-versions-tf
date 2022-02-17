resource "aws_s3_bucket_object" "milliFnboLogoWhite_prod" {
  bucket       = module.prod.bucket_id
  key          = "milliFnboLogoWhite.png"
  source       = "./cdn/assets/milliFnboLogoWhite.png"
  content_type = "image/png"
  acl          = "private"
  etag         = filemd5("./cdn/assets/milliFnboLogoWhite.png")
}
