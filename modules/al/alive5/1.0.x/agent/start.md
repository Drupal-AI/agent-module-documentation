<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alive5 (alive5) — agent index

Embeds the **Alive5** third-party live chat widget on chosen pages, cache-safely, from an admin
settings page. No theme/template changes. Package `Third party integration`. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0. **No module or library dependencies**
(core Node is optional — it only unlocks the content-type rule).

- **Settings form, config object + schema, display rules, route/permission** →
  [config/settings.md](config/settings.md)
- **The visibility service and how the script is injected** → [services/widget_manager.md](services/widget_manager.md)

## What it actually is

- No entities, no plugin types, no Drush. It provides one service, one config form, one permission,
  one config object, and one JS loader library.
- **Service** `alive5.widget_manager` → `Alive5WidgetManager` (implements `Alive5WidgetManagerInterface`),
  `src/Alive5WidgetManager.php`. Decides visibility per request and builds the JS settings.
- **Config form** `Alive5SettingsForm` (`src/Form/Alive5SettingsForm.php`, `ConfigFormBase`) at route
  **`alive5.settings`** = `/admin/config/system/alive5`, permission **`administer alive5`**
  (`restrict access: true`). Menu link under *Configuration → System*, one local task "Settings".
- **Config object** `alive5.settings` (schema in `config/schema/alive5.schema.yml`, install defaults in
  `config/install/alive5.settings.yml`).
- **Library** `alive5/widget` = `js/alive5.js` (`Drupal.behaviors.alive5Widget`), deps `core/drupal`,
  `core/drupalSettings`.

## Mechanism (from source)

- `alive5.module`: `hook_page_attachments()` seeds a `CacheableMetadata` from the render array, calls
  `Alive5WidgetManager::isVisible($cacheability)`. If TRUE, attaches library `alive5/widget` and
  `drupalSettings.alive5 = {widgetId, scriptUrl, elementId:'a5widget'}` from `getWidgetSettings()`.
  The cacheability is **always** applied to `$attachments` (even on a negative result) so a page that
  hides the widget caches under the same conditions as one that shows it.
- `Alive5WidgetManager::isVisible()`: returns FALSE early if `enabled` is off or `widget_id`/`script_url`
  is empty. Otherwise evaluates four rules — `matchesUser`, `matchesAdminRoute`, `matchesPath`,
  `matchesContentType` — with `!in_array(FALSE, $rules, TRUE)` (ALL must pass). Every rule is evaluated
  even after one fails, so recorded cache metadata reflects the configured rules, not this request's outcome.
- `js/alive5.js`: builds the vendor `<script>` via `document.createElement`, sets `.src`, `.async`, and
  `data-widget_code_id`; guards on element id `a5widget` so it never injects twice (AJAX/BigPipe/manual
  snippet). DOM APIs only — no `innerHTML`.
- `alive5.install`: `hook_requirements('runtime')` reports Not configured / Disabled / Enabled on the
  Status report; `hook_uninstall()` deletes `alive5.settings`.

## Config keys (`alive5.settings`)

`enabled` (bool, default true), `widget_id` (string, default ''), `script_url` (uri, default
`https://alive5.com/js/a5app.js`), `visibility_mode` (`all`|`include`|`exclude`, default `all`), `pages`
(text, newline path patterns), `hide_on_admin` (bool, default true), `hide_on_user_pages` (bool, default
false), `hide_on_checkout` (bool, default true), `user_visibility` (`all`|`anonymous`|`authenticated`),
`roles` (sequence), `content_types` (sequence). Full semantics + validation in
[config/settings.md](config/settings.md).
