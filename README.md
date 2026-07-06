# apigee-hybrid-deployment — Apigee Hybrid Deployment Workspace

> **A portable workspace for deploying Apigee Hybrid (K8s) instances** — Ansible playbooks, Helm chart overrides, service account management, mTLS cert processing, and multi-region configuration for GKE/EKS. The deployment-tier companion to the [`apigee-hybrid-workspace`](https://github.com/carlosfrias/apigee-hybrid-workspace) automation collection.

> [!NOTE]
> Engineering portfolio note — this project demonstrates Apigee Hybrid deployment configuration and multi-region K8s lifecycle management. See the [skills assessment →](SKILLS-ASSESSMENT.md) for the expertise applied.

This is the deployment workspace — where the `apigee-hybrid-workspace` collection is applied to real GKE/EKS clusters. It provides the `hybrid-common-attributes.yml` (the centralized variable file), multi-region configs (`region-dc-1`, `region-dc-2`), and utility playbooks for Cassandra access, mTLS cert processing, and troubleshooting.

<!-- BEGIN Google Required Disclaimer -->

## Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->

---

## What the workspace provides

- **`hybrid-common-attributes.yml`** — the centralized variable file for Apigee Hybrid deployment: project IDs, service accounts, work directories, Helm chart paths, cert paths, APIGEE version, cluster channels.
- **Multi-region configuration** — `hybrid-region-dc-1.yml` and `hybrid-region-dc-2.yml` (+ `-prep`) for dual-datacenter deployments.
- **`credentials.yml.template`** — credential template for service account management.
- **`hybrid-org-host-metadata.yml`** — org/host metadata for virtual host configuration.
- **mTLS cert processing** — `mTLS-certs.yml` and `mTLS-certs-process-cert-attribute-material.yml`.
- **Cassandra client access** — container manifest, template, and creation playbooks for Cassandra client access in Hybrid.
- **Gather-all and troubleshooting** — `hybrid-gather-all-script.yml` (comprehensive diagnostic collection), `troubleshooting-node.yml`, `apigee-operator-troubleshooting.yml`.
- **AWS EKS support** — `aws-cluster/` with EKS provisioning playbooks.
- **Dockerfile** — containerized Ansible controller for reproducible deployments.

---

## Architecture

```
resources/
├── hybrid-common-attributes.yml      ← centralized variables
├── hybrid-region-dc-1.yml            ← single-region config
├── hybrid-region-dc-2.yml            ← second DC config
├── hybrid-region-dc-2-prep.yml       ← second DC prep
├── hybrid-org-host-metadata.yml      ← org/host metadata
├── credentials.yml.template          ← service account template
└── requirements.txt

utils/
├── mTLS-certs.yml                    ← cert processing
├── mTLS-certs-process-cert-attribute-material.yml
├── cassandra-client-container-*.yml  ← Cassandra client access
├── hybrid-gather-all-script.yml      ← diagnostic collection
├── apigee-operator-troubleshooting.yml
├── kubernetes-info.yml
├── aws-cluster/                      ← EKS provisioning
├── bootstrap/                        ← workspace bootstrap
└── build/                            ← build utilities

Dockerfile                            ← containerized controller
hybrid-eks-manifest.yml               ← EKS manifest
```

---

## Provenance

Authored and maintained by **Carlos Frias** during his tenure on Apigee. The deployment-tier companion to the [`apigee-hybrid-workspace`](https://github.com/carlosfrias/apigee-hybrid-workspace) automation collection.

## License

See [LICENSE](./LICENSE).