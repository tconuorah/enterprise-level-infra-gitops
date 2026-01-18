locals {
  name_prefix = "${var.project}-${var.environment}-${var.region}"

  tags = merge(var.tags, {
    Project     = var.project
    Environment = var.environment
    Region      = var.region
  })
}
