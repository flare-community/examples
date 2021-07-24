# Gateway

This repository will:
    
    * install Istio in a kubernetes cluster using _istioctl_
    * install prometheus and grafana as recommended by the Istio team
    * expose the mesh using a kubernetes Ingress that will provision an HTTPS Global Loadbalancer in GCP

# Running locally

 * You must have terraform, istioctl, helm v3 and kubectl installed in your system.
 
 * A GCP Project to use and gcloud+kubectl authenticated and configured properly.

### TLDR;
    
    make upsert
    
    make delete

### Detailed
* First you should provision the necessary infrastructure to support the ingress. To do so, head over to the folder
_terraform/local/_ where you will find an example that uses the terraform module that will provision everything.

    ```
        cd terraform/local/
        terraform init
        terraform plan -input=false -out=tfplan
        terraform apply -input=false tfplan
        terraform output -json
    ```

* Next, install Istio using _istioctl_

    ```
        cd manifests/istio/
        istioctl install -f istio-operator.yaml --dry-run --skip-confirmation
        istioctl install -f istio-operator.yaml --skip-confirmation
    ``` 
 
* Next, install prometheus and grafana
 
    ```
         cd manifests/istio/
         kubectl apply --recursive -f /addons/
     ``` 

* Finally, let's create the ingress to expose the mesh
 
     ```
         cd chart/
         helm upgrade -i gateway gateway/
     ``` 
  
To delete check the Makefile.

## Terraform module

The terraform module support this repository will provision the following components:

    * a global static ip to use in the LB
    * A Cloud armor policy to use in the LB (Mitigate XSS attacks, ...)
    * DNS A records using GCP Endpoints

## Ingress chart

The ingress chart's goal is expose the mesh using a K8s Ingress. Additionally, we create the appropriate istio components
to expose grafana to the outside world.

The ingress will use a custom annotations and a BackendConfig to configure the GCP Global Loadbalancer.

    # enables or disables simple HTTP
    kubernetes.io/ingress.allow-http: "true"
    
    # the name of the global static ip to use
    kubernetes.io/ingress.global-static-ip-name: {{ .ip }}
    
    # certificates to use when accepting HTTPS
    networking.gke.io/managed-certificates: {{ join "," (keys .domains) }} 

The BackendConfig configures a specific health check to *istio-ingressgateway*, enables CDN and uses the given *securityPolicy*.
Check the *values.yaml* file to know more details. 
