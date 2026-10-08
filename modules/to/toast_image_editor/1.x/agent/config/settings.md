<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

## Install / enable

`composer require drupal/toast_image_editor` then `drush en toast_image_editor`. Core deps (media,
file, user, system) must be present. Grant `use toast image editor` to editor roles and
`administer toast image editor` to admins at `/admin/people/permissions#module-toast_image_editor`.
The editor then appears automatically on any image-source media type's edit form.

## Settings form

`Form\SettingsForm` (`ConfigFormBase`, form id `toast_image_editor_settings`) at
**`/admin/config/media/toast-image-editor`** (route `toast_image_editor.settings`,
`_permission: 'administer toast image editor'`; menu link under Configuration → Media). Editable
config: `toast_image_editor.settings`.

Fields:

- **`enabled_tools`** — checkboxes over the 9 tools from `getAvailableTools()`:
  `crop, flip, rotation, draw, shape, icon, text, mask, filter`. Each checkbox label is rendered with
  an inline SVG icon loaded from `assets/icons/ic-<tool>.svg` (`rotation` → `ic-rotate.svg`) via
  `getToolIcon()`, with a unicode-glyph fallback if the SVG is missing. `submitForm()` saves
  `array_keys(array_filter(...))` — i.e. the checked tool machine names.
- **`editor_width`** — number 0–2000 px; `0` (default) means full width (JS receives `100%`).
- **`editor_height`** — number 300–1500 px; default 600.
- **`theme`** — select `white` (Light, default) or `black` (Dark).

`SettingsForm::defaultTools()` returns all 9 tools enabled (TRUE) and is used as the fallback set the
form-alter service passes to JS when `enabled_tools` is unset.

## Config object & schema

Config name **`toast_image_editor.settings`**. `config/install/toast_image_editor.settings.yml`
defaults:

```yaml
enabled_tools: [crop, flip, rotation, draw, shape, icon, text, mask, filter]
editor_width: 0
editor_height: 600
theme: white
```

`config/schema/toast_image_editor.settings.schema.yml` types it as a `config_object`:
`enabled_tools` = sequence of string; `editor_width` / `editor_height` = integer; `theme` = string
(`white` or `black`).

## How the config reaches the editor

`MediaFormAlterService::alterMediaForm()` reads this config and emits
`drupalSettings.toastImageEditor`: `width` = `editor_width . 'px'` or `100%`; `height` =
`editor_height . 'px'` or `600px`; `theme` = `theme` or `white`; `enabledTools` = `enabled_tools` or
`SettingsForm::defaultTools()`. These control which toolbar buttons the Toast UI editor shows and its
size/theme — they do **not** affect server-side access checks, which are always
`use toast image editor` + media `update`.
