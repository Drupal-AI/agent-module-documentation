<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# authorization_drupal_roles — agent start

Submodule of **authorization**. Provides one `@AuthorizationConsumer` plugin,
id **`authorization_drupal_roles`** (label "Drupal Roles"), so an `authorization_profile`
can grant/revoke Drupal **roles**. No settings, no permissions, no Drush.

- Consumer plugin id, mapping shape (`role` value; `none` / `source` specials), grant/revoke
  behaviour → [plugins/drupal-roles.md](plugins/drupal-roles.md)
- Parent framework, the `authorization_profile` config entity, and how to build a profile →
  [../../../../1.5.x/agent/start.md](../../../../1.5.x/agent/start.md)
