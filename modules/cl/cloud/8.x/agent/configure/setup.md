<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloud — setup & configuration

**Admin settings:** `/admin/config/services/cloud/settings` (permission `administer cloud`).

## Enable
1. Enable `cloud` (core framework) plus the provider submodule(s) you need:
   `aws_cloud`, `k8s`, `openstack`, `vmware`, `docker`, `terraform`.
2. Grant permissions per role (`cloud.permissions.yml`): `administer cloud`,
   `access dashboard`, `view all cloud service providers`, and the per-entity
   view/list/add/edit/delete permissions.

## Add a cloud service provider (`cloud_config`)
- Structure > Cloud service providers > **+ Add cloud service provider**.
- **AWS** credential options: (1) *Use Instance Credentials* (EC2 IAM role, no keys stored),
  (2) *Simple access* (Access key ID + Secret access key), (3) *Assume role*.
  Configure a least-privilege IAM policy first (README lists the required EC2 `Describe*` actions).
- **k8s / OpenStack / VMware:** supply the API endpoint plus token/kubeconfig or user/password.
  Credentials are stored on the `cloud_config` entity.
- Run **cron** to import regions, images and existing resources into Drupal.

## Launch workflow
1. Design > Launch template > *[provider]* → create a `cloud_launch_template`.
2. Change its workflow status to **Approved** (`approve launch ...` permissions).
3. Click **Launch** (`launch cloud server template` / `launch approved cloud server template`).

## Location map
- Set `cloud_location_geocoder_plugin` in `cloud.settings` to a configured geocoder provider
  to plot provider locations (uses the `drupal/geocoder` module).
