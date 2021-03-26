USER_NAME=sample
USER_PASSWORD=sample
INIT_DIR=/mnt/mysql_init
DATA_DIR=/mnt/mysql_data
SRC_DIR=default
PV_SIZE=1Gi

INIT_DIR_PRJ=/mnt/mysql_init2
DATA_DIR_PRJ=/mnt/mysql_data2
SRC_DIR_PRJ=prj
PV_SIZE_PRJ=1Gi

DEPLOYMENT_YML=mysql-deployment.yml
PV_YML=mysql-pv.yml

.PHONY: install-default
install-default:
	-sudo rm -rf $(INIT_DIR)
	-sudo rm -rf $(DATA_DIR)
	-sudo rm -rf $(DEPLOYMENT_YML)
	sudo mkdir $(INIT_DIR)
	sudo mkdir $(DATA_DIR)
	bash shell/create-deployment-yml.sh $(SRC_DIR) $(PV_SIZE) $(USER_NAME) $(USER_PASSWORD)
	sudo cp mysql_init/*sql $(INIT_DIR)
	kubectl apply -f $(SRC_DIR)

.PHONY: install-prj
install-prj:
	-sudo rm -rf $(INIT_DIR_PRJ)
	-sudo rm -rf $(DATA_DIR_PRJ)
	-sudo rm -rf $(DEPLOYMENT_YML)
	sudo mkdir $(INIT_DIR_PRJ)
	sudo mkdir $(DATA_DIR_PRJ)
	bash shell/create-deployment-yml.sh $(SRC_DIR_PRJ) $(PV_SIZE_PRJ) $(USER_NAME) $(USER_PASSWORD)
	sudo cp mysql_init/*sql $(INIT_DIR_PRJ)
	kubectl apply -f $(SRC_DIR_PRJ)

.PHONY: create-deployment-yml-default
create-deployment-yml-default:
	bash shell/create-deployment-yml.sh $(SRC_DIR) $(PV_SIZE) $(USER_NAME) $(USER_PASSWORD)

.PHONY: create-deployment-yml-prj
create-deployment-yml-prj:
	bash shell/create-deployment-yml.sh $(SRC_DIR_PRJ) $(PV_SIZE_PRJ) $(USER_NAME) $(USER_PASSWORD)

.PHONY: start-default
start-default:
	kubectl apply -f $(SRC_DIR)

.PHONY: start-prj
start-prj:
	kubectl apply -f $(SRC_DIR_PRJ)

.PHONY: stop-default
stop-default:
	-kubectl delete -f $(SRC_DIR)
	
.PHONY: stop-prj
stop-prj:
	kubectl delete -f $(SRC_DIR_PRJ)

.PHONY: prune-default
prune-default:
	-kubectl delete -f $(SRC_DIR)
	-sudo rm -rf $(INIT_DIR)
	-sudo rm -rf $(DATA_DIR)
	-sudo rm -rf $(SRC_DIR)/$(DEPLOYMENT_YML)
	-sudo rm -rf $(SRC_DIR)/$(PV_YML)
	
.PHONY: prune-prj
prune-prj:
	-kubectl delete -f $(SRC_DIR_PRJ)
	-sudo rm -rf $(INIT_DIR_PRJ)
	-sudo rm -rf $(DATA_DIR_PRJ)
	-sudo rm -rf $(SRC_DIR_PRJ)/$(DEPLOYMENT_YML)
	-sudo rm -rf $(SRC_DIR_PRJ)/$(PV_YML)
