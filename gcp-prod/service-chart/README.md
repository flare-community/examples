# istio-workload

A simple chart that deploys the following manifests to a kubernetes cluster:

    * Deployment
    * Service
    * DestinationRule
    * VirtualService
    
These components form the foundation needed to configure a kubernetes workload that gets traffic managed by Istio.

## Values

The following are the default values.

```yaml

environment: dev

replicaCount: 1

service:
  type: ClusterIP
  prefix: /toptal/v1/
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
      name: tcp

deployment:
  maxUnavailable: 1
  maxSurge: 50%
  container:
    image:
      pullPolicy: IfNotPresent
      url:
    ports:
      - 8080
    environment:
    health:
      readiness:
        path: /health
        port: 8080
        initialDelaySeconds: 60
        timeoutSeconds: 2
        failureThreshold: 5
        periodSeconds: 5
      liveness:
        path: /health
        port: 8080
        initialDelaySeconds: 60
        timeoutSeconds: 2
        failureThreshold: 10
        periodSeconds: 5
    resources:
     requests:
       cpu: 100m
       memory: 100Mi
     limits:
       cpu: 300m
       memory: 300Mi

destinationRule:
  host: toptal-service.demo.svc.cluster.local
  tlsMode: DISABLE
  #https://istio:io/docs/reference/config/networking/destination-rule/#LoadBalancerSettings-SimpleLB
  lbMode: LEAST_CONN
  subsets:
    - name: v1
      labels:
        version: v1

virtualService:
  gateways:
    - istio-system/default-gateway
  hosts:
    - "*"
  match:
    - name: default
      prefixes:
        - /toptal/v1
      rewrite: /
      routes:
        - host: toptal-service.demo.svc.cluster.local
          port: 80

```

## TODO

Add HPA
