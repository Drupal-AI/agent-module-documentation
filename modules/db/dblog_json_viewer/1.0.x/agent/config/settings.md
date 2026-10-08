<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form, config object & route

## Install / enable

`composer require drupal/dblog_json_viewer` then `drush en dblog_json_viewer`. Core **`dblog`**
must be enabled (declared dependency). `hook_install()` (`dblog_json_viewer.install`) only shows two
status messages; there is nothing else to bootstrap. Uninstall deletes the config object
(`hook_uninstall` → `configFactory()->getEditable('dblog_json_viewer.settings')->delete()`).

## Route & permission

`dblog_json_viewer.routing.yml` defines one route:

- `dblog_json_viewer.admin_settings` → path `/admin/config/development/dblog-json-viewer`,
  `_form: '\Drupal\dblog_json_viewer\Form\DblogJsonViewerSettingsForm'`,
  `_permission: 'administer site configuration'`.

An admin-menu link (`dblog_json_viewer.links.menu.yml`) places it under
*Configuration > Development*. `data.json`'s `configure` points here.

Note: this settings route is the **only** route. The viewer itself is not a route — it is a
library attached to the core `dblog.event` route (see [integration/viewer.md](../integration/viewer.md)).

## Config object `dblog_json_viewer.settings`

Shipped defaults live in `config/install/dblog_json_viewer.settings.yml`; the typed schema is
`config/schema/dblog_json_viewer.schema.yml` (`type: config_object`). Keys:

- **`button_texts`** (mapping of strings) — every UI label. Keys: `expand_all`, `collapse_all`,
  `show_raw_data`, `show_json_view`, `copy_json`, `copy_raw`, `copied`, `copy_failed`,
  `previous_result` (default `←`), `next_result` (`→`), `search_placeholder`, `no_json_found`,
  `raw_content_summary`, `no_results_found`, `clear_search`, `fullscreen` (`⛶ Fullscreen`),
  `exit_fullscreen` (`✕ Exit Fullscreen`).
- **`search_delay`** (integer, default `500`) — debounce in ms before a search runs.
- **`enable_debug_logs`** (boolean, default `false`) — emit `console.log('[Dblog JSON Viewer]', …)`
  parsing traces in the browser.
- **`api_patterns`** (sequence of strings) — key-name fragments that raise an object's relevance
  score during detection. Defaults include `data`, `response`, `result`, `items`, `order`,
  `payload`, `body`, `message`, `status`, `id`, `name`, `value`, etc.
- **`section_patterns`** (sequence of strings) — labels recognised as multi-section markers
  (matched as `Label:`). Defaults include `Options`, `Response`, `Request`, `Body`, `Headers`,
  `Payload`, `Error`, `Exception`, `Auth`, `Token`, `Metadata`, `Context`, `JSON`, `Input`,
  `Output`, etc.

## Settings form — `DblogJsonViewerSettingsForm`

`src/Form/DblogJsonViewerSettingsForm.php`, extends `ConfigFormBase`;
`getEditableConfigNames()` → `['dblog_json_viewer.settings']`; form id
`dblog_json_viewer_admin_settings`.

- `buildForm()` groups the button texts into `details`/`fieldset` sections (Navigation & Controls,
  View Toggle, Copy Actions, Search Features, Status Messages), each a required `textfield`
  (`#default_value` = stored value or the hard-coded default). Adds a `search_delay` number field
  (`#min 0`, `#max 2000`, `#step 100`), an `enable_debug_logs` checkbox, and two `textarea`s
  (`api_patterns`, `section_patterns`, one pattern per line). Attaches the (undefined)
  `dblog_json_viewer/admin` library for CSS — a missing-library reference that has no functional
  effect beyond the CSS not loading.
- `submitForm()` writes each `button_texts_<key>` value back to `button_texts.<key>`, saves
  `search_delay` and `enable_debug_logs`, and converts each textarea to an array with
  `array_filter(array_map('trim', explode("\n", …)))` before `->set()` + `->save()`.

## How settings reach the browser

`dblog_json_viewer_page_attachments()` reads this config and builds
`drupalSettings.dblogJsonViewer` = `{ buttonTexts: {…}, settings: { searchDelay, enableDebugLogs,
apiPatterns, sectionPatterns } }`, applying the same defaults inline (`?:` / `??`) if a value is
unset. The JS reads only from `drupalSettings`.
