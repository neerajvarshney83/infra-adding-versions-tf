## infra
infrastructure as code for project Milli (formerly known as Gen6/Mino) 

## environments
- `int`: `dev`/`int` environment where changes are automatically merged in from app `master` branch. Requires [VPN](https://www.notion.so/millibank/Connecting-to-test-environments-8dfff3e44f67414aa3f11412de09a562) connection for access.
- `qa`: `dev`/`qa` environment where changes are merged in by [@gen6-ventures/qa](https://github.com/orgs/gen6-ventures/teams/qa) merging the **Staged release from Int to QA** PRs. Requires [VPN](https://www.notion.so/millibank/Connecting-to-test-environments-8dfff3e44f67414aa3f11412de09a562) connection for access.
- `milli-prod`: `prod` environment where changes are merged in by merging the **Staged release from QA to Prod** PRs when ready to deploy the appropriate service from `qa` to 'production'. A Github `release` with the `draft` flag will be automatically raised and must be `published` via the UI or API to deploy in 'production'. [1] Requires [VPN](https://www.notion.so/millibank/Connecting-to-environments-and-internal-tools-8dfff3e44f67414aa3f11412de09a562) connection for access to internal tools.

| Tool                                        | Description                             | int | qa | milli-prod |
|---------------------------------------------|-----------------------------------------|-----|----|------|
| [Tekton](https://cloud.google.com/tekton)   | k8s Native Deployments                  | [x](https://tekton.int.us-east-1.dev.gen6bk.com/) | [x](https://tekton.qa.us-east-1.dev.gen6bk.com/) | [x](https://tekton.us-east-1.prod.milli-bank.com/) |
| [Dex](https://github.com/dexidp/dex) | Authentication/RBAC for K8s                    | [x](https://login.int.us-east-1.dev.gen6bk.com/) | [x](https://login.qa.us-east-1.dev.gen6bk.com/) | [x](https://login.us-east-1.prod.milli-bank.com/) |
| [Prometheus](https://prometheus.io/)        | Metrics gathering and querying          | [x](https://prometheus.int.us-east-1.dev.gen6bk.com/) | [x](https://prometheus.qa.us-east-1.dev.gen6bk.com/) | [x](https://prometheus.us-east-1.prod.milli-bank.com/) |
| [AlertManager](https://prometheus.io/)        | Metrics alerting  | [x](https://alertmanager.int.us-east-1.dev.gen6bk.com/) | [x](https://alertmanager.qa.us-east-1.dev.gen6bk.com/) | [x](https://alertmanager.us-east-1.prod.milli-bank.com) |
| [Grafana](https://grafana.com/)             | Monitoring dashboards & logs  | [x](https://grafana.int.us-east-1.dev.gen6bk.com/) | [x](https://grafana.qa.us-east-1.dev.gen6bk.com/) | [x](https://grafana.us-east-1.prod.milli-bank.com/) |
| [Jaeger](https://www.jaegertracing.io/) | Distributed tracing for observability | [x](https://jaeger.int.us-east-1.dev.gen6bk.com/search) | [x](https://jaeger.qa.us-east-1.dev.gen6bk.com/search) | [x](https://jaeger.us-east-1.prod.milli-bank.com) |
| [Hubble](https://github.com/cilium/hubble) | Observability for networking | [x](https://hubble.int.us-east-1.dev.gen6bk.com) | [x](https://hubble.qa.us-east-1.dev.gen6bk.com) | [x](https://hubble.us-east-1.prod.milli-bank.com) |

- for access to internal tools, you must use the [VPN](https://www.notion.so/millibank/Connecting-to-environments-and-internal-tools-8dfff3e44f67414aa3f11412de09a562) appropriate for the environment
- `jaeger`, postgres `reporting` and `prometheus` data is also visible on `grafana` under the `Explore` tab

## k8s
Contains the Kubernetes environments `int`, `qa` and `milli-prod`, with shared `base` (and `kops-base` for kops-created clusters) code. Uses `kustomize` via `tekton` to automatically apply on changes to this repository in the case of `int` and `qa`. For `milli-prod`, new Github releases will trigger changes to be applied.

In `k8s`, there is a YAML file for each environment - `int.yaml`, `qa.yaml` and `milli-prod.yaml`. These YAML files are [kops](https://github.com/kubernetes/kops) cluster declarations.

If `int.yaml` or `qa.yaml` are changed, they will trigger Tekton to run Kops to reconciliate the cluster. 

If `milli-prod.yaml` is changed, it will trigger Tekton in the production cluster to make changes accordingly on the next release.

Do be careful editing these files - they control low-level Kubernetes functions and features! `kops update` output will be added on each release as they are built.

Note that most components in `k8s/base/structs` are obtained from `11FSConsulting/platform` and are refreshed on each PR.

## terraform
Contains Terraform code to create infrastructure necessary for Gen6 components.

There are two environments - `dev`, updated by the `int` environment and `production`, updated by the `milli-prod` environment. Tekton runs the `terraform apply` whenever a change is made in this repository (for `int`/`qa`) or on release (for `milli-prod`).

Do be careful making changes in Terraform - note that removing a resource from Terraform management will cause it to be destroyed! A `terraform plan` will be added to the release each time one is built.

Note that most components in `terraform/structs` are obtained from `11FSConsulting/platform` and are refreshed on each PR.

## Notes
[1] Alternatively, `milli-prod` can be directly deployed to, bypassing `qa`, by adding the `adhoc-release/prod` label onto a PR targeting `production` code and garnering reviews from [@gen6-ventures/back-end](https://github.com/orgs/gen6-ventures/teams/back-end) and [@gen6-ventures/qa](https://github.com/orgs/gen6-ventures/teams/qa).
