<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Façade (facade) — agent index
**Multi-tenant deployment framework: a Tenant entity + launch plugins that drive remote cloud orchestrators.**

- **Version:** 2.0.x (dev-2.0.x checkout)
- **Core:** ^10.3 || ^11
- **Depends:** drupal/cloud (reference provider)
- **Configure:** `facade.settings` (/admin/config/services/facade, `administer site configuration`)
- **Entities:** `tenant` (content), `tenant_type` (config); plugin manager `FacadeLaunchTenantPluginManager`
- **Permissions:** `add tenant`, `view/edit/delete tenant entities`, `administer tenant entities` (restrict access: true) + per-bundle via `TenantPermissions::generatePermissions`
- **Submodule:** `facade_remote_worker` — REST `entity.cloud_config`, Drush `EntityCommands`, global bearer-token auth provider, `field_bearer_token` user field

**Security:** the single route is admin-settings gated by `administer site configuration`; tenant CRUD is permission-gated (admin permission is `restrict access: true`). Observation for reviewers: `facade_remote_worker` authenticates via a **plaintext** bearer token stored in the `field_bearer_token` user field and matched by exact entity-query equality (`FacadeBearerToken.php:76`), and registers the provider `global: TRUE` — tokens are not hashed at rest.

See [extend/plugins.md](extend/plugins.md).
