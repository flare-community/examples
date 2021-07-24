## my-go-service-flare

An example of how to integrate the my-go-service and my-go-service-provision into flare.

## Notes

All plans were generated from [community-plans](https://github.com/flare-community/plans).

In order to successfully run this, you'll need to create a [Cipher](https://docs.flare.engineering/resources/ciphers/) with
a valid gcp service account. This cipher is used by the terraform-plan to authenticate gcloud.

  ```
  flarectl create cipher -f gcp-service-acc.json -n gcp-terraform-service-account
  ```
