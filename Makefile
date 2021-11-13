USER_NAME=sample
USER_PASSWORD=sample
INIT_DIR=/mnt/mysql_init
DATA_DIR=/mnt/mysql_data
SRC_DIR=default
PV_SIZE=1Gi

DEPLOYMENT_YML=mysql-deployment.yml
PV_YML=mysql-pv.yml

.PHONY: make-install-default
make-install-default:
	-sudo rm -rf $(INIT_DIR)
	-sudo rm -rf $(DATA_DIR)
	-sudo rm -rf $(DEPLOYMENT_YML)
	sudo mkdir $(INIT_DIR)
	sudo mkdir $(DATA_DIR)
	bash shell/create-deployment-yml.sh $(SRC_DIR) $(PV_SIZE) $(USER_NAME) $(USER_PASSWORD)
	sudo cp mysql_init/*sql $(INIT_DIR)
	kubectl apply -f $(SRC_DIR)

.PHONY: create-deployment-yml-default
create-deployment-yml-default:
	bash shell/create-deployment-yml.sh $(SRC_DIR) $(PV_SIZE) $(USER_NAME) $(USER_PASSWORD)

.PHONY: start-default
start-default:
	kubectl apply -f $(SRC_DIR)

.PHONY: stop-default
stop-default:
	-kubectl delete -f $(SRC_DIR)

.PHONY: prune-default
prune-default:
	-kubectl delete -f $(SRC_DIR)
	-sudo rm -rf $(INIT_DIR)
	-sudo rm -rf $(DATA_DIR)
	-sudo rm -rf $(SRC_DIR)/$(DEPLOYMENT_YML)
	-sudo rm -rf $(SRC_DIR)/$(PV_YML)