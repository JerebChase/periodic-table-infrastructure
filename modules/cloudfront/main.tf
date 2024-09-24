resource "aws_cloudfront_distribution" "cloudfront_api" {
  origin {
    domain_name = "${var.periodic_table_api}.execute-api.us-east-1.amazonaws.com"
    origin_id   = "api-gateway-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = ""

  default_cache_behavior {
    target_origin_id       = "api-gateway-origin"
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
    cloudfront_default_certificate = true
  }

  tags = {
    env: "${var.tag}"
  }
}