<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conword (conword) — agent index

Front-end integration for the **DeepL-based Conword translation widget** (Conword GmbH, proprietary
SaaS — needs a paid contract + customer ID). It attaches the vendor's external JavaScript to
front-end pages, forwards two display flags via `drupalSettings`, and gates visibility with core
condition plugins. Package `Content`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.x.
**No module dependencies** (composer suggests `drupal/csp`; `conflict` with `drupal/csp` `<1.12`).

- **Config form, config object/schema, routes, permission, hooks** →
  [config/settings.md](config/settings.md)
- **The optional language-picker block + template/JS UI** → [plugins/block.md](plugins/block.md)

## What it actually is (from source)

- **One config form** `ConwordConfigForm` (`src/Form/ConwordConfigForm.php`, extends
  `ConfigFormBase`) at route **`conword.settings`** → `/admin/config/services/conword`, permission
  **`administer conword`** (`conword.permissions.yml`), menu link under *Configuration → Services*.
  Config object constant `CONFIG_OBJECT_NAME = 'conword.settings'`.
- **One block plugin** `ConwordBlock` (id `conword`, `src/Plugin/Block/ConwordBlock.php`) — an
  optional replacement language switcher; `access()` returns *allowed* only when the
  `disable_language_switcher` flag is set, else *forbidden*.
- **Hooks** in `conword.module`: `hook_theme` (`conword` theme, template `conword.html.twig`),
  `hook_page_attachments` (attaches `conword/conword` library + `drupalSettings.conword.conwordConfig`
  when `conword__is_conword_active()` is true), `hook_library_info_alter` (injects the external vendor
  script `https://static.conword.io/js/v2/{customer_id}/conword.js` as an `external` JS asset onto the
  `conword` library).
- **Visibility** — `conword__is_conword_active()` evaluates a `ConditionPluginCollection` built from
  `conword.settings:visibility`, exactly like core block visibility. Default install config negates a
  request-path list (admin/batch/media/node-add/edit/user paths).
- **No entities, no plugin types, no services, no Drush, no REST/routes beyond the admin form.**

## Config keys (`conword.settings`, schema in `config/schema/conword.schema.yml`)

- `customer_id` (string, `NotBlank`) — the Conword customer ID used to build the vendor script URL.
- `conwordConfig.disable_language_switcher` (bool) — hides the vendor switcher; also the gate that
  enables the `conword` block.
- `conwordConfig.disable_rtl_attribute` (bool) — disables the widget's RTL attribute handling.
- `visibility` (sequence of `condition.plugin.[id]`) — standard condition-plugin config.

## Libraries (`conword.libraries.yml`)

- `conword` — `js/conword.js` (copies `drupalSettings.conword.conwordConfig` to
  `window.conword_config`) + core/drupalSettings; the external vendor script is added by
  `hook_library_info_alter`.
- `conword_ui` — `css/conword.css` + `js/conword_ui.js` (builds the popover picker from the vendor
  `Conword` JS API); depends on `conword/conword`. Attached by the block.
- `conword.admin` — `js/conword.admin.js` (vertical-tab summaries on the settings form).
