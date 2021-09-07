# output "neo_arn" {
#   value = aws_iam_user.example[*].arn
#   description = "The ARN for all users"
# }

output "all_users" {
  value = values(aws_iam_user.example)[*].arn
}

output "upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) > 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = {for name, role in var.hero_thousand_faces : upper(name) => upper(role)}
}

output "for_directive" {
  value = <<EOF
%{~ for name in var.names }
  ${name}
%{~ endfor }
  EOF
}