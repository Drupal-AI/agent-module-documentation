<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# authorization — agent start

Framework that maps external identity data (e.g. LDAP groups) onto Drupal-side grants
(e.g. roles). The unit of configuration is the **`authorization_profile`** config entity:
it pairs one **provider** plugin (`@AuthorizationProvider`, supplies proposals about a user)
with one **consumer** plugin (`@AuthorizationConsumer`, grants/revokes a target), plus a
mapping table between them. At login (`hook_user_login`) the `authorization.manager` service
reconciles the user against every enabled profile. Depends on `externalauth`. No permissions
of its own (admin gated by `administer site configuration`); no Drush.

- The `authorization_profile` config entity, its fields, admin route, and how to build one
  with Drush → [configure/authorization.md](configure/authorization.md)
- The two plugin types (Provider / Consumer) and how to implement each →
  [plugins/provider-consumer.md](plugins/provider-consumer.md)
- The `authorization.manager` service and the profile grant/revoke API →
  [api/service.md](api/service.md)
- Bundled consumer submodule (Drupal Roles) →
  [../../modules/authorization_drupal_roles/1.5.x/agent/start.md](../../modules/authorization_drupal_roles/1.5.x/agent/start.md)
