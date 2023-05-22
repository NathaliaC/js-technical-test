output "users_endpoint" {
  value = "${aws_api_gateway_deployment.ton_deployment.invoke_url}/users"
}

output "authentication_endpoint" {
  value = "${aws_api_gateway_deployment.ton_deployment.invoke_url}/authentication"
}

output "visits_endpoint" {
  value = "${aws_api_gateway_deployment.ton_deployment.invoke_url}/visits"
}
