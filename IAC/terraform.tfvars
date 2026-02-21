namespace       = "example-namespace"

complex_image    = "your-dockerhub-username/complex:1.0"
complex_replicas = 1
complex_host     = "complex.example.com"

dashboard_image    = "your-dockerhub-username/dashboard:1.0"
dashboard_replicas = 1
dashboard_host     = "dashboard.example.com"

landing_image    = "your-dockerhub-username/landing:1.0"
landing_replicas = 1
landing_host     = "landing.example.com"

userwebsite_image    = "your-dockerhub-username/userwebsite:1.0"
userwebsite_replicas = 1
userwebsite_host     = "userwebsite.example.com"

# Environment secrets
mongodb_uri         = "mongodb+srv://<username>:<password>@<cluster>.mongodb.net/?retryWrites=true&w=majority"
jwt_secret          = "<your-jwt-secret-key>"
complex_public_url  = "https://complex.example.com"

# Payment configuration
zarinpal_merchant_id = "<your-zarinpal-merchant-id>"

# Arvan Cloud configuration
arvan_api_token  = "<your-arvan-api-token>"
arvan_access_key = "<your-arvan-access-key>"
arvan_bucket_name = "<your-bucket-name>"

# SMS configuration
sms_ir_line_number = "<your-sms-line-number>"
sms_ir_template_id = "<your-template-id>"
sms_ir_api_key     = "<your-sms-api-key>"

# AI configuration
ai_deepseek_key = "<your-deepseek-api-key>"

# Public URLs
next_public_base_userwebsite_payment_url = "https://example.com"