<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install / update glue

`acquia_cms_place.install` is the module's only PHP. It contains no runtime logic — just install-time
hooks and config updates. Relevant to integrators:

## Hooks

- `hook_content_model_role_presave_alter(RoleInterface &$role)` — grants the Place node permissions
  to the family's `content_author` / `content_editor` roles. See
  [../permissions/permissions.md](../permissions/permissions.md).
- `hook_module_preinstall($module)` — calls
  `\Drupal::service('acquia_cms_common.utility')->setModulePreinstallTriggered($module)`. This is a
  hard runtime dependency on the `acquia_cms_common.utility` service; the module will fail to install
  cleanly without `acquia_cms_common` present.

## Update hooks

| Function | What it does |
|----------|--------------|
| `acquia_cms_place_update_8001` | Swaps the pathauto pattern's legacy `node_type` selection condition for `entity_bundle:node`. |
| `acquia_cms_place_update_8002` | Adds `field_place_image` to the default/card/horizontal_card/search_results/teaser view displays and rewrites the `referenced_image` display via `_acquia_cms_common_rewrite_configuration()`. |
| `acquia_cms_place_update_8003` | Adds scheduler components (`publish_on`/`unpublish_on`/`publish_state`/`unpublish_state`/`scheduler_settings`) to the `node.place.default` form display. |
| `acquia_cms_place_update_8004` | Only if `acquia_cms_site_studio` is enabled: sets enforced module dependencies on the Site Studio templates under `config/pack_acquia_cms_place`. |
| `acquia_cms_place_update_8005` | Only if `acquia_cms_site_studio` is enabled: deletes Site Studio config entities that shipped with invalid (missing uuid/id) data, logging each deletion. |

Run with `drush updatedb`. Nothing here exposes an API for other modules to call.
