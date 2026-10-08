<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Contextual Links — agent start

info.yml name **Configure Contextual Links** (`configure_contextual_links`), version **1.0.4**,
package `Contextual`, core `^9.4 || ^10 || ^11`. Depends on core `drupal:contextual`.

Lets a site administrator alter Drupal's **contextual links** (the "pencil" quick-edit menus that
appear on blocks, nodes, menus, media, etc.) at the **plugin** level. Two operations only:

- **Disable** chosen contextual-link plugins so they stop appearing everywhere at once.
- **Relabel** chosen contextual-link plugins to a custom title (blank label = keep the default).

There is no per-block/per-entity granularity and no "enable" toggle beyond leaving a plugin
un-disabled — disabling and relabelling are the only stored actions.

## Mechanism

- **Hook** `configure_contextual_links_contextual_links_alter()` (in the `.module`) delegates to
  `ConfigureContextualLinksManager::alter()` via `\Drupal::classResolver()`. This is core's
  `hook_contextual_links_alter(&$links, $group, $route_parameters)`.
- `src/ConfigureContextualLinksManager.php` reads immutable config
  `configure_contextual_links.settings`:
  - `disabled` (sequence of plugin ids): for each id present in `$links`, `unset($links[$key])`.
    Matched with `array_intersect(array_keys($links), $disabled)`.
  - `relabel` (sequence keyed by a config-safe id → new label): the config key has `-` replaced
    back to `.` (`str_replace('-', '.', ...)`) to match the live link key, then
    `$links[$key]['title'] = $new_label`.
- The altered `title` is rendered through core's contextual-links link rendering (Twig
  autoescaped).

## Config, route, permission

- **Settings form** `src/Form/ContextualLinkSettingsForm.php` (`ConfigFormBase`, form id
  `configure_contextual_links_settings`) at route `configure_contextual_links.settings` →
  path `/admin/config/user-interface/configure-contextual-links`.
  - Route requirement: `_permission: "administer contextual links settings"` (defined in
    `configure_contextual_links.permissions.yml`).
  - Menu link under `system.admin_config_ui` (Configuration → User interface).
- The form lists every registered contextual-link plugin from
  `plugin.manager.menu.contextual_link` (`getDefinitions()`), shown as
  `group: title`. Two vertical tabs: **Disable Contextual Links** (`checkboxes`) and
  **Relabel Contextual Links** (one `textfield` per plugin). Keys are stored with `.`→`-`
  substitution (`convertKeyToConfig()`).
  - On submit it saves config and calls `contextualLinkManager->clearCachedDefinitions()`.
  - A message warns that contextual links are cached in browser session data, so users may need
    to clear session / restart the browser to see changes.
- **Config schema** `config/schema/configure_contextual_links.schema.yml`: `disabled` sequence of
  `string`, `relabel` sequence of `label` (both nullable).

## Scope note

Hiding or relabelling a contextual link is a **display** change only. It does not grant or revoke
any permission — core still enforces access to each linked operation, so a hidden link's action
remains reachable by other routes. This module is a UI-tidy tool, not an access-control mechanism.

Single-purpose module; no submodules, services.yml, JS, templates, install hooks, Drush commands,
or API file. Source is two PHP classes plus the `.module` hook.
