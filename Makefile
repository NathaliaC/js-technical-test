.PHONY: install-dependencies init plan apply destroy

CODE_DIR := .
TERRAFORM_DIR := infrastructure/terraform

install-dependencies:
	cd $(CODE_DIR) && npm ci

init:
	cd $(TERRAFORM_DIR) && terraform init

plan: init
	cd $(TERRAFORM_DIR) && terraform plan

apply: install-dependencies init
	cd $(TERRAFORM_DIR) && terraform apply

build: apply
	cd $(CODE_DIR) && rm -rf lambda_function.zip

destroy:
	cd $(TERRAFORM_DIR) && terraform destroy