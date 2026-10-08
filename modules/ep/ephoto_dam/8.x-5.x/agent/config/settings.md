<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ephoto DAM — configuration

## Install / enable

`drush en ephoto_dam -y`. Core `ckeditor5` and `system` are the only dependencies (no Composer
`require`, no PHP library). Menu link `ephoto_dam.admin_settings` (`ephoto_dam.links.menu.yml`)
appears under **Configuration** (parent `system.admin_config`, weight 99).

## Site-wide settings form

- Class `Form\ConfigurationForm` (extends `ConfigFormBase`), form id `ephoto_dam_admin_settings`.
- Route `ephoto_dam.admin_settings` → path `/admin/config/ephoto_dam`, requirement
  `_permission: 'administer site configuration'` (`ephoto_dam.routing.yml`).
- Editable config object: **`ephoto_dam.settings`** (`getEditableConfigNames()`).
- One field only: `settings_server_url` — a required `#type => url` for "the URL of your Ephoto
  Dam software" (placeholder `https://ephoto.mycompany.com/`).
  - `validateForm()` runs `filter_var($url, FILTER_VALIDATE_URL)` and errors if invalid.
  - `submitForm()` appends a trailing `/` if missing, then saves `server_url`.
- **No credential/API-key field exists.** The module stores only the server URL. Authentication
  with Ephoto is performed at runtime by the browser (see
  [../plugins/ckeditor5-filter.md](../plugins/ckeditor5-filter.md)); there is no Key entity,
  environment variable or secret consumed by this module.

`ephoto_dam.module` reads `ephoto_dam.settings` in `ephoto_dam_preprocess_page()` and exposes
`server_url` and `auth_id` to the page as `drupalSettings.ephoto_dam.*`.

## Per-text-format CKEditor 5 plugin settings

Class `Plugin\CKEditor5Plugin\EphotoDam` (id `ephoto_dam_simplebox`) implements
`CKEditor5PluginConfigurableInterface`. Settings are stored inside the editor/text-format config,
not in `ephoto_dam.settings`. `defaultConfiguration()` / `buildConfigurationForm()`:

| Key | Type | Default | Purpose |
|-----|------|---------|---------|
| `captions` | checkbox | TRUE | Show a caption under embedded media |
| `captions_format` | textarea | '' | Caption template; `[fieldName]` tokens are replaced from Ephoto file metadata |
| `zoom` | checkbox | TRUE | Allow click-to-zoom on images |
| `images_size` | number (0–6000) | 320 | Display width (px) for images |
| `videos_size` | number (0–6000) | 360 | Display width (px) for videos |
| `documents_size` | number (0–6000) | 320 | Display width (px) for documents |

`getDynamicPluginConfig()` passes these to the JS as `config.ephoto_dam.*` (plus `align: "none"`),
and defaults CKEditor image captions on. `submitConfigurationForm()` / `validateConfigurationForm()`
just copy the six values from the form state.

The `ephoto_dam_simplebox` plugin (see `ephoto_dam.ckeditor5.yml`) supplies toolbar item
`simpleBox`, loads library `ephoto_dam/ephoto_dam` (editing) and `ephoto_dam/admin.ephoto_dam`
(config UI), and declares allowed elements `<h2>`, `<div>`, `<section>` (with matching classes).

## Config schema

`config/schema/ephoto_dam.schema.yml` defines `ckeditor5.plugin.ephoto_dam_simplebox` (mapping:
`auth_id`, `server_url` strings; `captions`/`zoom` booleans; `captions_format` string;
`images_size`/`videos_size`/`documents_size` integers) — i.e. the schema for the per-format plugin
settings. (There is no separate schema file for the `ephoto_dam.settings.server_url` value.)

## Enabling the button on a text format (from `hook_help` + `hook_form_alter`)

1. Set the Server URL on the settings form first.
2. At **Configuration → Content authoring → Text formats and editors**, edit a format that uses
   CKEditor 5 and drag the **Ephoto Dam** button into the active toolbar.
3. Enable the **Ephoto Dam** filter in the format's filter list (put it first if multiple filters
   run).
4. `ephoto_dam_form_filter_format_form_alter()` adds two validators:
   `ephoto_dam_toolbar_filter_validate()` (button and filter must both be enabled or both disabled)
   and `ephoto_dam_settings_validate()` (if the button is enabled, `server_url` must be set).
