#! make

GENERATE_DOCS_COMMAND:=terraform-docs --sort-inputs-by-required markdown table . > README.md

fmt:
	@terraform fmt

lint:
	@terraform fmt -check
	@tflint

generate-docs:
	@$(GENERATE_DOCS_COMMAND)

all: lint generate-docs
