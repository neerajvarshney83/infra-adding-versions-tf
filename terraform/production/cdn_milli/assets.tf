resource "aws_s3_bucket_object" "milliFnboLogoWhite_prod" {
  bucket       = module.prod.bucket_id
  key          = "milliFnboLogoWhite.png"
  source       = "./cdn_milli/assets/milliFnboLogoWhite.png"
  content_type = "image/png"
  acl          = "private"
  etag         = filemd5("./cdn_milli/assets/milliFnboLogoWhite.png")
}

resource "aws_s3_bucket_object" "apple_app_site_association" {
  bucket       = module.links.bucket_id
  key          = ".well-known/apple-app-site-association"
  source       = "./cdn_milli/assets/apple-app-site-association"
  content_type = "application/json"
  acl          = "private"
  etag         = filemd5("./cdn_milli/assets/apple-app-site-association")
}

resource "aws_s3_bucket_object" "google_assetlinks" {
  bucket       = module.links.bucket_id
  key          = ".well-known/assetlinks.json"
  source       = "./cdn_milli/assets/assetlinks.json"
  content_type = "application/json"
  acl          = "private"
  etag         = filemd5("./cdn_milli/assets/assetlinks.json")
}

resource "aws_s3_bucket_object" "links_html" {
  bucket       = module.links.bucket_id
  key          = "index.html"
  source       = "./cdn_milli/assets/links.html"
  content_type = "text/html"
  acl          = "private"
  etag         = filemd5("./cdn_milli/assets/links.html")
}

resource "aws_s3_bucket_object" "fav_icon" {
  bucket       = module.links.bucket_id
  key          = "favicon.ico"
  source       = "./cdn_milli/assets/favicon.ico"
  content_type = "image/x-icon"
  acl          = "private"
  etag         = filemd5("./cdn_milli/assets/favicon.ico")
}

resource "aws_s3_bucket_object" "copy_svg_prod" {
  bucket       = module.prod.bucket_id
  key          = "Copy.svg"
  source       = "./cdn_milli/assets/Copy.svg"
  content_type = "image/svg+xml"
  acl          = "private"
  etag         = filemd5("./cdn_milli/assets/Copy.svg")
}
