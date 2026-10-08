<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install / update glue

`acquia_cms_event.install` is the module's only lifecycle PHP. It contains no runtime request logic —
just install-time hooks and config updates. Relevant to integrators:

## Hooks

- `hook_content_model_role_presave_alter(RoleInterface &$role)` — grants the Event node permissions
  to the family's `content_author` / `content_editor` roles. See
  [../permissions/permissions.md](../permissions/permissions.md).
- `hook_module_preinstall($module)` — calls
  `\Drupal::service('acquia_cms_common.utility')->setModulePreinstallTriggered($module)`. This is a
  hard runtime dependency on the `acquia_cms_common.utility` service; the module will not install
  cleanly without `acquia_cms_common` present.

## Update hooks

| Function | What it does |
|----------|--------------|
| `acquia_cms_event_update_8001` | Sets the `event_cards` view's `past_events_block` display title to "Past Events" and clears its display title override. |
| `acquia_cms_event_update_8002` | Swaps the `event_path` pathauto pattern's legacy `node_type` selection condition for `entity_bundle:node`. |
| `acquia_cms_event_update_8003` | Adds `field_event_image` to the default/card/horizontal_card/search_results/teaser view displays (per-display view mode), bumps sibling field weights, and switches `field_event_place` on the default display to `entity_reference_entity_view` (`referenced_image` mode). |
| `acquia_cms_event_update_8004` | Adds scheduler components (`publish_on`/`unpublish_on`/`publish_state`/`unpublish_state`/`scheduler_settings`) to the `node.event.default` form display. |
| `acquia_cms_event_update_8005` | Only if `acquia_cms_site_studio` is enabled: sets enforced module dependencies on the Site Studio templates under `config/pack_acquia_cms_event`. |
| `acquia_cms_event_update_8006` | Only if `acquia_cms_site_studio` is enabled: deletes Site Studio config entities under the two `pack_*` dirs that shipped with invalid (missing uuid/id) data, logging each deletion. |

Run with `drush updatedb`. Nothing here exposes an API for other modules to call. The one service the
module does register is unrelated to install — see
[../api/default_content_event_update.md](../api/default_content_event_update.md).
