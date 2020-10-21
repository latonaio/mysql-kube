INIT_DIR=/mnt/mysql_init
DATA_DIR=/mnt/mysql_data
DEPLOYMENT_YML=default/mysql-deployment.yml
PV_YML=default/mysql-pv.yml

INIT_DIR_PRJ=/mnt/mysql_init2
DATA_DIR_PRJ=/mnt/mysql_data2
DEPLOYMENT_YML_PRJ=prj/mysql-deployment.yaml
PV_YML_PRJ=prj/mysql-pv.yaml

.PHONY: install-default
install-default:
	-sudo rm -rf $(INIT_DIR)
	-sudo rm -rf $(DATA_DIR)
	-sudo rm -rf $(DEPLOYMENT_YML)
	sudo mkdir $(INIT_DIR)
	sudo mkdir $(DATA_DIR)
	bash shell/create-deployment-yml.sh $(DEPLOYMENT_YML)
	sudo cp mysql_init/*sql $(INIT_DIR)
	kubectl apply -f $(DEPLOYMENT_YML) -f $(PV_YML)

.PHONY: install-prj
install-prj:
	-sudo rm -rf $(INIT_DIR_PRJ)
	-sudo rm -rf $(DATA_DIR_PRJ)
	-sudo rm -rf $(DEPLOYMENT_YML_PRJ)
	sudo mkdir $(INIT_DIR_PRJ)
	sudo mkdir $(DATA_DIR_PRJ)
	bash shell/create-deployment-yml.sh $(DEPLOYMENT_YML_PRJ)
	sudo cp mysql_init/*sql $(INIT_DIR_PRJ)
	kubectl apply -f $(DEPLOYMENT_YML_PRJ) -f $(PV_YML_PRJ)

.PHONY: create-deployment-yml-default
create-deployment-yml-default:
	bash shell/create-deployment-yml.sh $(DEPLOYMENT_YML)

.PHONY: create-deployment-yml-prj
create-deployment-yml-prj:
	bash shell/create-deployment-yml.sh $(DEPLOYMENT_YML_PRJ)

.PHONY: start-default
start-default:
	kubectl apply -f $(DEPLOYMENT_YML) -f $(PV_YML)

.PHONY: start-prj
start-prj:
	kubectl apply -f $(DEPLOYMENT_YML_PRJ) -f $(PV_YML_PRJ)

.PHONY: stop-default
stop-default:
	-kubectl delete -f $(DEPLOYMENT_YML) -f $(PV_YML)
	
.PHONY: stop-prj
stop-prj:
	kubectl delete -f $(DEPLOYMENT_YML_PRJ) -f $(PV_YML_PRJ)

.PHONY: prune-default
prune-default:
	-kubectl delete -f $(DEPLOYMENT_YML) -f $(PV_YML)
	-sudo rm -rf $(INIT_DIR)
	-sudo rm -rf $(DATA_DIR)
	-sudo rm -rf $(DEPLOYMENT_YML)
	
.PHONY: prune-prj
prune-prj:
	-kubectl delete -f $(DEPLOYMENT_YML_PRJ) -f $(PV_YML_PRJ)
	-sudo rm -rf $(INIT_DIR_PRJ)
	-sudo rm -rf $(DATA_DIR_PRJ)
	-sudo rm -rf $(DEPLOYMENT_YML_PRJ)
