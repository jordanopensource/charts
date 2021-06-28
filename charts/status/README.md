# Statping

## Description
JOSA Status for monitoring all JOSA's websites and services

**Image:**
statping/statping

**Version:**
v0.90.74

**Helm chart:**
```
statping
```

## Requirements
- A running `Kubernetes` cluster.
- Helm v3.0+.
- Traefik v2.0+ as a LoadBalancer.

## Needed Credentials
- DB_PASS: Databebase password
- ADMIN_PASSWORD: Default admin password

## Deployment
Enter `helm/org.jordanopensource.status` directory.

Install helm chart:
```bash
helm install --namespace=josa-status \
               -f values-override.yaml \
               josa-status statping
```

## Upgrade
In `helm/org.jordanopensource.status` directory:

Update your values in `values-override.yaml` then run:
```
helm upgrade --install --namespace=josa-status \
               -f values-override.yaml \
               josa-status statping
```
