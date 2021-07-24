all: noflow

upsert: terraform-upsert istio-upsert helm-upsert
delete: helm-delete istio-delete terraform-delete

noflow:
	echo 'Specify a flow, upsert or delete'

##### UPSERT
terraform-upsert:
	cd terraform/local && \
    terraform init && \
    terraform plan -o tfplan && \
    terraform apply tfplan

istio-upsert:
	cd manifests/istio && \
    istioctl install -f istio-operator.yaml && \
    kubectl apply --recursive -f addons/

helm-upsert:
	cd chart/ && \
	helm upgrade -i gateway ../chart/gateway

##### DELETE
terraform-delete:
	cd terraform/local && \
    terraform init && \
    terraform plan -o tfplan && \
    terraform destroy tfplan

istio-delete:
	cd manifests/istio && \
	kubectl delete --recursive -f addons/ && \
    istioctl manifest generate -f istio-operator.yaml | kubectl delete --ignore-not-found=true -f -

helm-delete:
	helm uninstall gateway
