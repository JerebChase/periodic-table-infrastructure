resource "aws_cloudfront_origin_access_control" "access_control" {
  name                              = "periodic-table-access-control-${var.env}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name              = var.periodic_table_bucket_domain
    origin_access_control_id = aws_cloudfront_origin_access_control.access_control.id
    origin_id                = "periodic-table-origin-${var.env}"
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "periodic-table-origin-${var.env}"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]

    cached_methods = ["GET", "HEAD"]

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    min_ttl        = 0
    default_ttl    = 3600  # 1 hour
    max_ttl        = 86400  # 1 day
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  price_class = "PriceClass_100"  # Cheapest price class (US, Canada, Europe)

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method = "sni-only"
  }

  tags = {
    env = "${var.tag}"
  }
}