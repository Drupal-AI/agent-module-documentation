<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Signature plugin & AJAX save routes

## Enable

`drush en sign_widget`, then at *Administration › Configuration › Content authoring › Text formats
and editors* (`/admin/config/content/formats/manage/<format>`) drag the **Signature** button into a
CKEditor 5 toolbar for a text format whose editor is CKEditor 5. The text format must allow the
`<svg>` element (the plugin declares `elements: [<svg>]`).

## The plugin

- PHP: `src/Plugin/CKEditor5Plugin/Signature.php` — `CKEditor5PluginDefault` +
  `CKEditor5PluginConfigurableInterface`. YAML definition `sign_widget.ckeditor5.yml` (id
  `sign_widget_plugin`): toolbar item `signature`, JS plugin `signature.Signature`, Drupal library
  `sign_widget/sign` (compiled `js/build/signature.js`), admin library `sign_widget/admin.sign`.
- `buildConfigurationForm()` exposes the same pen settings as the field plugins plus a
  **`file_directory`** textfield (default `inline-images`) — the subdirectory under the public
  scheme where drawn SVGs are written. `defaultConfiguration()` sets them; schema
  `config/schema/sign_widget_plugin.schema.yml` (`ckeditor5.plugin.sign_widget_plugin`).
- `getDynamicPluginConfig()` hands the JS the settings, the resolved signature_pad library URL
  (`local` → `signature_pad.local` library, else CDN via `library.discovery`), and the save
  endpoint URL from `Url::fromRoute('sign_widget.save')`. Black background (`#000000`/`#000`) is
  coerced to `#fff` for the editor canvas.
- JS: `js/ckeditor5_plugins/signature/src/*` (source) compiled to `js/build/signature.js` via
  `webpack.config.js`. It POSTs the drawn SVG data-URL to the save route and inserts the returned
  file URL as an `<svg>`/image into the document.

## Routes (`sign_widget.routing.yml`)

| route | path | controller | methods | requirement |
|-------|------|------------|---------|-------------|
| `sign_widget.save` | `/ajax/sign-widget/save` | `SignWidgetController::save` | POST | `_permission: 'access content'` |
| `sign_widget.sendSign` | `/ajax/sign_widget/sendSign/{selector}` | `SendSignForm::saveSign` | (any) | `_permission: 'access content'` |

### `SignWidgetController::save` (`src/Controller/SignWidgetController.php`)

Reads a JSON body `{svg, file_directory}`. Token-replaces `file_directory`, builds
`public://<dir>/`, `prepareDirectory(CREATE_DIRECTORY)`, and `file.repository->writeData()`s the
SVG to `<ymd>_<rand>.svg` (`FileExists::Replace`). Returns `{url}` (or `{error}` / HTTP 400 if the
directory can't be prepared). Used by the CKEditor plugin to persist the inline signature.

### `SendSignForm::saveSign` (`src/Form/SendSignForm.php`)

A static controller (despite living in a `ConfigFormBase` subclass). Reads POST fields `sign`
(PNG data-URL), `file_directory`, `entity_type`, `entity_id`, `field_name`. It decodes the base64
PNG, writes it under `<default_scheme>://<file_directory>/<ymd>_<rand>.png`, then loads the named
entity, `appendItem(['target_id' => fid, 'width', 'height'])` onto the named field and `save()`s.
Returns an `AjaxResponse` carrying `SendSignCommand` (`src/Ajax/SendSignCommand.php`) → JS command
`SendSign`, which swaps the canvas for the saved `<img>`. This is what the **formatter's** live
canvas (see [../fields/widget-and-formatter.md](../fields/widget-and-formatter.md)) posts to.

## Notes

- Written SVGs land under the public files scheme in the CKEditor plugin's `file_directory`
  (default `inline-images/`); PNGs land under the field's / posted `file_directory`. Filenames are
  `date('ymd')_rand(1000,9999)` with `FileExists::Replace`.
- No `*.services.yml`; the controller injects `file.repository`, `file_url_generator`,
  `file_system`, `token` via `create()`.
