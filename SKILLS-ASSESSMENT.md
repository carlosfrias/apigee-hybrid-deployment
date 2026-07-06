# Skills Assessment — apigee-hybrid-deployment

> **Skill domain:** Apigee Hybrid (K8s) deployment configuration and multi-region lifecycle — the deployment workspace where the `apigee-hybrid-workspace` automation collection is applied to real GKE/EKS clusters. Part of the broader Apigee platform-operations portfolio; see the [`bap_coe` portfolio hub →](https://github.com/carlosfrias/apigee-hybrid-workspace/blob/main/SKILLS-ASSESSMENT.md) for the full corpus.

---

## Why this project is notable

- **Centralized deployment configuration.** `hybrid-common-attributes.yml` is the single source of truth for project IDs, service accounts, work directories, Helm chart paths, cert paths, and Apigee version — the variable file that drives the entire deployment.
- **Multi-region (DC-1 + DC-2) configs.** Separate playbooks for the second datacenter (`hybrid-region-dc-2.yml` + `-prep`), with region-specific variable overrides.
- **mTLS cert processing.** Dedicated playbooks for processing cert attribute material — mTLS is the trust model in Hybrid, and this workspace automates the cert pipeline.
- **Cassandra client access in K8s.** Container manifests and creation playbooks for accessing Cassandra in the Hybrid runtime — a diagnostic and operational tool.
- **Diagnostic collection.** `hybrid-gather-all-script.yml` (16K) — a comprehensive diagnostic harvester for troubleshooting Hybrid deployments.
- **AWS EKS support.** `aws-cluster/` and `hybrid-eks-manifest.yml` — the workspace supports both GKE and EKS.

---

## Expertise demonstrated

> Ansible/K8s is the medium. The engineering evidence lives in the [project README →](README.md). What follows is the skills assessment for the business reader.

- **Apigee Hybrid deployment configuration** — the centralized variable file that drives the entire Hybrid deployment, from project IDs and service accounts to Helm chart paths and mTLS cert locations. The workspace is the operational expression of the collection.
- **Multi-region K8s lifecycle** — DC-1 and DC-2 configs with separate prep and deploy phases. The same discipline as the OPDK multi-DC expansion, applied to K8s.
- **mTLS cert pipeline automation** — cert processing playbooks that automate the mTLS trust model. In Hybrid, mTLS is the trust boundary; this workspace automates cert creation and processing.
- **Cassandra client access in K8s** — container manifests for accessing Cassandra in the Hybrid runtime. Not `nodetool` on a VM — a K8s-native diagnostic tool.
- **Diagnostic collection at scale** — `hybrid-gather-all-script.yml` harvests diagnostics from across the Hybrid deployment. The same discipline as the OPDK `opdk-setup-log-files.yml`, applied to K8s.

---

## How this shows the expertise

This workspace is the deployment-tier companion to the `apigee-hybrid-workspace` collection. The collection provides the automation (42 roles); this workspace provides the configuration — project IDs, service accounts, cluster names, cert paths, and multi-region variable overrides. The expertise is not in "writing Ansible variables" — it is in **designing a deployment workspace that centralizes all Hybrid configuration in one file** (`hybrid-common-attributes.yml`) and then composes it with region-specific overrides for multi-DC deployments.

The mTLS cert processing and Cassandra client access playbooks are the K8s-native equivalents of the OPDK operational tools — the same discipline (automate the operational lifecycle, don't rely on manual steps), applied to a different substrate.

---

## Related expertise

| Skill | Repository | Assessment |
|-------|-----------|-----------|
| Apigee Hybrid / K8s automation (collection) | [`apigee-hybrid-workspace`](https://github.com/carlosfrias/apigee-hybrid-workspace) | [SKILLS-ASSESSMENT.md →](https://github.com/carlosfrias/apigee-hybrid-workspace/blob/main/SKILLS-ASSESSMENT.md) ✅ portfolio hub |
| Multi-DC expansion (OPDK) | [`apigee-opdk-playbook-maintenance-expand-region`](https://github.com/carlosfrias/apigee-opdk-playbook-maintenance-expand-region) | [SKILLS-ASSESSMENT.md →](https://github.com/carlosfrias/apigee-opdk-playbook-maintenance-expand-region/blob/main/SKILLS-ASSESSMENT.md) ✅ |
| Rolling upgrade / DR (OPDK) | [`apigee-opdk-playbook-maintenance-opdk-upgrade`](https://github.com/carlosfrias/apigee-opdk-playbook-maintenance-opdk-upgrade) | [SKILLS-ASSESSMENT.md →](https://github.com/carlosfrias/apigee-opdk-playbook-maintenance-opdk-upgrade/blob/main/SKILLS-ASSESSMENT.md) ✅ |

---

## Provenance

Authored and maintained by **Carlos Frias** during his tenure on Apigee. This skills assessment is the companion to the engineering [README →](README.md). For the full engineering detail — variables, architecture, and utility playbooks — see the project README.

## License

See [LICENSE](./LICENSE).