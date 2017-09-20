variable "name" {
  description = "Name to give this environment."
  default     = "example"
}

variable "hostname" {
  description = "Hostname for this website."
  default     = "example.com"
}

variable "aliases" {
  description = "Additional aliases to host this website for."
  default     = []
}

variable "cache_ttl" {
  description = "Default TTL to give objects requested from S3 in CloudFront for caching."
  default     = 3600
}

variable "logs_transition_ia" {
  description = "How long to wait before transitioning log files into S3-IA."
  default     = 30
}

variable "logs_transition_glacier" {
  description = "How long to wait before transitioning log files into Glacier."
  default     = 60
}

variable "logs_expiration" {
  description = "How long to wait before deleting old log files."
  default     = 365
}

variable "price_class" {
  description = "Which price_class to enable in CloudFront."
  default     = "PriceClass_100"
}

variable "index_document" {
  description = "Default index document for directories and website root."
  default     = "index.html"
}

variable "error_document" {
  description = "Default html document to display for errors (e.g. 404)."
  default     = "error.html"
}

variable "tags" {
  description = "A map of tags (in addition to Name) to add to all resources."
  default     = {}
}
