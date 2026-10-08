<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloud is the core framework of a Drupal-based multi-cloud orchestration dashboard for AWS, Kubernetes, OpenStack, VMware, Docker and Terraform Cloud.

---

Cloud provides the shared entity model, permissions, plugin system and dashboard scaffolding that the per-provider submodules build on. It defines base content entities such as the cloud service provider config (`cloud_config`), launch templates (`cloud_launch_template`), projects (`cloud_project`) and stores (`cloud_store`), plus pluggable managers (`cloud_config`, `cloud_launch_template`, `cloud_project`, `cloud_store`) so each provider (aws_cloud, k8s, openstack, vmware, docker, terraform) can register its own resource types. Cloud service provider credentials (AWS access keys, kubeconfig, OpenStack/VMware endpoints) are stored as `cloud_config` entities and used to make authenticated external API calls via the provider services and vendor SDKs (aws/aws-sdk-php, maclof/kubernetes-client, google/apiclient).

Operationally, almost every route is permission-gated (`administer cloud`, `view/list/add/edit ... cloud ...`, `access dashboard`) and many use a `_custom_access` callback that also validates the `{cloud_context}` per provider. Setup is: enable `cloud` plus the provider submodule(s) you need, grant permissions, add a cloud service provider under Structure > Cloud service providers, then run cron to import resources. Security notes worth knowing: several provider services disable TLS verification when talking to their API endpoints (k8s, vmware), the public `/health_check` POST endpoint authenticates a username/password from the request body, and the geocoder helper route is anonymous — see the security report. Configure the module at `/admin/config/services/cloud/settings` (`administer cloud`).

---
- Enable the `cloud` core framework plus one or more provider submodules (aws_cloud, k8s, openstack, vmware, docker, terraform).
- Add an AWS cloud service provider and enter access key ID / secret access key, or use EC2 instance credentials.
- Configure an IAM policy granting the EC2 Describe* actions the module needs before adding an AWS provider.
- Use Assume Role credentials so the module accesses another AWS account's EC2 resources.
- Add a Kubernetes (k8s) cluster with its API endpoint and token/kubeconfig.
- Add an OpenStack, VMware or Docker cloud service provider.
- Run cron to import and refresh regions, images, instances and other cloud resources.
- Import machine images (AMIs) by name pattern into a provider.
- Import or generate SSH key pairs used to log into launched instances.
- Create and manage security groups and network interfaces.
- Design a launch template, approve its workflow status, then launch instances from it.
- Create cloud projects to group resources and launch templates.
- Create cloud stores (e.g. S3-style object stores) and browse their contents.
- Browse the React-based cloud dashboard at `/clouds/dashboard`.
- Grant granular permissions per role (view/list/add/edit/delete each cloud entity type).
- Restrict which providers a role can view via `view all cloud service providers` and per-context permissions.
- Configure module-wide options at `/admin/config/services/cloud/settings`.
- Set the geocoder provider used to plot provider locations on a map.
- Use the Drush queue commands to process cloud resource import queues.
- Run the Behat helper Drush commands during automated testing.
- Copy an existing launch template or project to a new one.
- Delete cloud resources individually or via multi-select bulk operations through the dashboard REST API.
- Enable submodules such as cloud_budget (cost tracking) or gapps (Google Workspace).
- Use the k8s_to_s3 / s3_to_k8s tools submodules to move data between Kubernetes and object storage.
- Query the `/health_check` endpoint to verify the site and credentials are responsive.
