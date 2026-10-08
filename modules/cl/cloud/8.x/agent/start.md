<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloud (cloud) — agent index

**Core framework for a multi-cloud orchestration dashboard (AWS, Kubernetes, OpenStack, VMware, Docker, Terraform Cloud); provides the entity model, permissions and plugin managers the provider submodules extend.**

- **Version:** 8.x (dev checkout of the `8.x` / `8.x-dev` branch; no `version:` in info.yml)
- **Core requirement:** ^10.6 || ^11 (README also states PHP 8.5+)
- **Package:** Cloud
- **Configure route:** `cloud.settings` → `/admin/config/services/cloud/settings` (permission `administer cloud`)
- **Dependencies:** field, file, filter, image, link, options, user, taxonomy, text, views
- **Composer libs:** aws/aws-sdk-php, maclof/kubernetes-client, google/apiclient, drupal/geocoder, geocoder-php/nominatim-provider

**Key entities:** `cloud_config` (cloud service provider + credentials), `cloud_launch_template`, `cloud_project`, `cloud_store`.
**Plugin managers:** `plugin.manager.cloud_config_plugin`, `plugin.manager.cloud_launch_template_plugin`, `plugin.manager.cloud_project_plugin`, `plugin.manager.cloud_store_plugin`.
**Services:** `cloud` (CloudService), `cloud.subscriber`, `entity.link_renderer`, `cloud.cache`, `cloud.access_check.entity_operate_multiple`. **Drush:** queue + Behat commands (`drush.services.yml`).
**Submodules:** cloud_budget, cloud_cluster_worker, cloud_dashboard, gapps, tools (k8s_to_s3, s3_to_k8s), and cloud_service_providers/{aws_cloud, cloud_cluster, docker, k8s, openstack, terraform, vmware}.
**Permissions:** yes (`cloud.permissions.yml`) — `administer cloud`, `access dashboard`, and per-entity view/list/add/edit/delete + `view all cloud service providers`.

**Security:** Most routes are permission-gated with a per-`cloud_context` `_custom_access` check. Notable exceptions/observations (report only): `/health_check` (`cloud.routing.yml:378`, `_access: TRUE`) authenticates a username/password from the POST body (unauthenticated credential-check oracle); the geocoder route `cloud.routing.yml:135` and dashboard config routes are anonymous; provider services disable TLS verification (`k8s` K8sService.php:297/301/2675, `vmware` VmwareService.php:347). See solution docs below.

See [configure/setup.md](configure/setup.md) and [api/routes-and-plugins.md](api/routes-and-plugins.md).
