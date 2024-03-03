.DEFAULT_GOAL := help

.PHONY: help
help:
	@ awk 'BEGIN {FS = ":.*##"; printf "\nИспользование:\n  make \033[36m<команда>\033[0m\n\nКоманды:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: login
login:
	@ cd terraform && terraform login

.PHONY: init
init:
	@ cd terraform && terraform init

.PHONY: apply
apply:
	@ bash ./run_terraform.sh apply

.PHONY: inventory
inventory:
	@ bash ./run_terraform.sh inventory

.PHONY: creds
creds:
	@ bash ./run_terraform.sh credentials

.PHONY: destroy
destroy:
	@ bash ./run_terraform.sh destroy && rm ./ansible/group_vars/all/database-vault.yml ./ansible/inventory.ini

.PHONY: encrypt
encrypt:
	@ ansible-vault encrypt ansible/group_vars/all/main-vault.yml

.PHONY: vault
vault:
	@ env EDITOR=nano ansible-vault edit ansible/group_vars/all/main-vault.yml

.PHONY: deploy
deploy:
	@ cd ansible && ansible-galaxy install -r requirements.yml && ansible-playbook playbook.yml --ask-vault-pass -i inventory.ini