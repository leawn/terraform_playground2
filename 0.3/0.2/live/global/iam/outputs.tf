# output "neo_arn" {
#   value = aws_iam_user.example[*].arn
#   description = "The ARN for all users"
# }

output "all_users" {
  value = values(aws_iam_user.example)[*].arn
}