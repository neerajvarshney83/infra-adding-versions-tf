resource "aws_s3_bucket_object" "milliFnboLogoWhite_int" {
  bucket       = module.int.bucket_id
  key          = "milliFnboLogoWhite.png"
  source       = "./cdn/assets/milliFnboLogoWhite.png"
  content_type = "image/png"
  acl          = "private"
  etag         = filemd5("./cdn/assets/milliFnboLogoWhite.png")
}

resource "aws_s3_bucket_object" "milliFnboLogoWhite_qa" {
  bucket       = module.qa.bucket_id
  key          = "milliFnboLogoWhite.png"
  source       = "./cdn/assets/milliFnboLogoWhite.png"
  content_type = "image/png"
  acl          = "private"
  etag         = filemd5("./cdn/assets/milliFnboLogoWhite.png")
}

resource "aws_s3_bucket_object" "milli_Auth0_emailHeader_qa" {
  bucket       = module.qa.bucket_id
  key          = "milli_Auth0_emailHeader.png"
  source       = "./cdn/assets/milli_Auth0_emailHeader.png"
  content_type = "image/png"
  acl          = "private"
  etag         = filemd5("./cdn/assets/milli_Auth0_emailHeader.png")
}

resource "aws_s3_bucket_object" "milli_Auth0_emailHeader_int" {
  bucket       = module.int.bucket_id
  key          = "milli_Auth0_emailHeader.png"
  source       = "./cdn/assets/milli_Auth0_emailHeader.png"
  content_type = "image/png"
  acl          = "private"
  etag         = filemd5("./cdn/assets/milli_Auth0_emailHeader.png")
}

resource "aws_s3_bucket_object" "jwks_qa" {
  bucket       = module.qa.bucket_id 
  key          = "jwks.json"
  source       = "./cdn/assets/qa-jwks.json"
  content_type = "application/json"
  acl          = "private"
  etag         = filemd5("./cdn/assets/qa-jwks.json")
}

resource "aws_s3_bucket_object" "jwks_int" {
  bucket       = module.int.bucket_id
  key          = "jwks.json"
  source       = "./cdn/assets/int-jwks.json"
  content_type = "application/json"
  acl          = "private"
  etag         = filemd5("./cdn/assets/int-jwks.json")
}

resource "aws_s3_bucket_object" "apple_app_site_association_qa" {
  bucket       = module.links_qa.bucket_id
  key          = ".well-known/apple-app-site-association"
  source       = "./cdn/assets/qa-apple-app-site-association"
  content_type = "application/json"
  acl          = "private"
  etag         = filemd5("./cdn/assets/qa-apple-app-site-association")
}

resource "aws_s3_bucket_object" "links_html_qa" {
  bucket       = module.links_qa.bucket_id
  key          = "index.html"
  source       = "./cdn/assets/links.html"
  content_type = "text/html"
  acl          = "private"
  etag         = filemd5("./cdn/assets/links.html")
}

resource "aws_s3_bucket_object" "fav_icon_qa" {
  bucket       = module.links_qa.bucket_id
  key          = "favicon.ico"
  source       = "./cdn/assets/favicon.ico"
  content_type = "image/x-icon"
  acl          = "private"
  etag         = filemd5("./cdn/assets/favicon.ico")
}

resource "aws_s3_bucket_object" "apple_app_site_association_int" {
  bucket       = module.links_int.bucket_id
  key          = ".well-known/apple-app-site-association"
  source       = "./cdn/assets/int-apple-app-site-association"
  content_type = "application/json"
  acl          = "private"
  etag         = filemd5("./cdn/assets/int-apple-app-site-association")
}

resource "aws_s3_bucket_object" "links_html_int" {
  bucket       = module.links_int.bucket_id
  key          = "index.html"
  source       = "./cdn/assets/links.html"
  content_type = "text/html"
  acl          = "private"
  etag         = filemd5("./cdn/assets/links.html")
}

resource "aws_s3_bucket_object" "fav_icon_int" {
  bucket       = module.links_int.bucket_id
  key          = "favicon.ico"
  source       = "./cdn/assets/favicon.ico"
  content_type = "image/x-icon"
  acl          = "private"
  etag         = filemd5("./cdn/assets/favicon.ico")
}

resource "aws_s3_bucket_object" "copy_svg_int" {
  bucket       = module.int.bucket_id
  key          = "Copy.svg"
  source       = "./cdn/assets/Copy.svg"
  content_type = "image/svg+xml"
  acl          = "private"
  etag         = filemd5("./cdn/assets/Copy.svg")
}

resource "aws_s3_bucket_object" "copy_svg_qa" {
  bucket       = module.qa.bucket_id
  key          = "Copy.svg"
  source       = "./cdn/assets/Copy.svg"
  content_type = "image/svg+xml"
  acl          = "private"
  etag         = filemd5("./cdn/assets/Copy.svg")
}
