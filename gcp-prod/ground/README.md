# Ground

This repo contains terraform modules that provision the following resources in GCP:

    * VPC
    * Subnetwork
    * GKE Cluster with ip aliasing to leverage container native loadbalancing and NEGs
    * A HA PostgresSQL cluster
    
# Running locally

 * You must have terraform and gcloud installed in your system.
 
 * A GCP Project to use and gcloud authenticated and configured properly. 
 
 * In the _local/_ folder you'll find examples. These use GCS as remote backend to store *tfstate*, replace *bucket*, *prefix* accordingly.
 
    
```
    cd _local/<resource>/
    terraform init
    terraform plan -input=false -out=tfplan
    terraform apply -input=false tfplan
    terraform output -json
```
