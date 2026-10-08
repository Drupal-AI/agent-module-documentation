<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloud — routes, plugins & Drush

## Plugin types (extend per provider)
- `plugin.manager.cloud_config_plugin` — cloud service provider config plugins.
- `plugin.manager.cloud_launch_template_plugin` — launch/server-template plugins.
- `plugin.manager.cloud_project_plugin` — project plugins.
- `plugin.manager.cloud_store_plugin` — store/object-storage plugins.
Provider submodules (aws_cloud, k8s, openstack, vmware, docker, terraform) register these.

## Notable routes (`cloud.routing.yml`)
- `cloud.settings` — `/admin/config/services/cloud/settings` (`administer cloud`).
- Entity CRUD for `cloud_launch_template`, `cloud_project`, `cloud_store` — permission-gated,
  mostly via `_custom_access` callbacks that validate `{cloud_context}` + a `perm:` option.
- Dashboard REST API under `/cloud_dashboard/...` — GET options/flavors/count (`access dashboard`,
  `list cloud store`) and POST delete/launch operations (`edit ... server templates`,
  `launch ...`). All permission-gated.
- `cloud_dashboard.manage_menu.visible` — `/cloud_dashboard/manage_menu/visible` (`access dashboard`).

### Anonymous / public routes (security-relevant, report only)
- `cloud.health_check` — POST `/health_check`, `_access: 'TRUE'`; reads `username`/`password`
  from the request and calls `user.auth`->authenticate(), returning success/fail JSON
  (unauthenticated credential-check oracle; brute-force surface).
- `entity.cloud_config.geocoder` — `/clouds/geocoder/{country}/{city}`, `_access: 'TRUE'`;
  anonymous geocoding lookup via the configured provider.
- `cloud_dashboard` submodule: `/clouds/dashboard`, `/clouds/cloud_dashboard/config/callback_uri`,
  `.../client_id`, `.../scope` are `_access: 'TRUE'` (expose OAuth2 client bootstrap config to anon).

## Drush (`drush.services.yml`)
- `cloud.queue.commands` — process cloud resource import queues.
- `behat.commands` — helpers used during automated Behat testing.
