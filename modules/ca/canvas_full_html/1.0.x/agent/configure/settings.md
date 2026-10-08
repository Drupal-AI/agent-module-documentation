# Configure — canvas_full_html

## The one setting

Config object **`canvas_full_html.settings`**, schema `canvas_full_html.schema.yml`:

| Key | Type | Default | Effect |
|---|---|---|---|
| `enabled` | boolean | `true` | When TRUE, Canvas WYSIWYG props that use a Canvas format are switched to `canvas_full_html`. When FALSE the module does nothing and Canvas keeps `canvas_html_block` / `canvas_html_inline`. |

Admin form: route **`canvas_full_html.settings`** → `/admin/config/content/canvas-full-html`
(`Drupal\canvas_full_html\Form\SettingsForm`, form id `canvas_full_html_settings`,
permission `administer site configuration`). It exposes the single **"Enable Full HTML
format in Canvas"** checkbox. On submit it saves `enabled` and invalidates the `rendered`
and `config:filter.format.full_html` cache tags.

Read / set it with drush (no admin UI needed):

```bash
drush cget canvas_full_html.settings enabled
drush cset canvas_full_html.settings enabled 0 -y   # disable
drush cset canvas_full_html.settings enabled 1 -y   # enable (default)
```

## Config entities installed on enable

`config/install/` ships three entities (all prefixed `canvas_full_html`):

- **`filter.format.canvas_full_html`** — the "Canvas Full HTML" text format itself.
- **`editor.editor.canvas_full_html`** — its CKEditor 5 configuration. Default toolbar:
  bold, italic, underline, strikethrough, superscript, subscript, removeFormat, heading,
  link, bulletedList, numberedList, blockQuote, horizontalLine, sourceEditing.
- **`canvas_full_html.settings`** — the `enabled` flag above.

Uninstalling the module **deletes `filter.format.canvas_full_html`**; Canvas content saved
with it loses its format association, so switch components back to a Canvas default format
first if you plan to uninstall.

## Editing the Canvas toolbar

The toolbar is an ordinary CKEditor 5 config. Edit it at
`/admin/config/content/formats/manage/canvas_full_html`. Adding/removing buttons here
changes only Canvas editors — the site's `full_html` and other formats are unaffected.
Both core and contrib CKEditor 5 plugins (e.g. `ckeditor5_plugin_pack`,
`ui_icons_ckeditor5`) are supported; the module pre-loads every plugin library enabled on
this editor config so they are ready before Canvas's React editor initialises. The core
integration library `ckeditor5/internal.drupal.ckeditor5` is intentionally excluded (it
pulls in `core/drupal.ajax` which conflicts with Canvas's own AJAX handling).

## How it takes effect

Behavior lives in `Drupal\canvas_full_html\Hook\CanvasFullHtmlHooks` (autowired service):

- `#[Hook('canvas_storable_prop_shape_alter')]` — when `enabled` is TRUE and a prop's schema
  has `contentMediaType: text/html` whose `allowed_formats` include a Canvas format and the
  `canvas_full_html` format exists, it rewrites `allowed_formats` to `['canvas_full_html']`.
- `#[Hook('library_info_alter')]` — appends `canvas_full_html/ckeditor-fixes` to the
  `canvas/canvas-ui` library (CSS/JS that fixes clipped toolbar dropdowns), and attaches all
  enabled CKEditor 5 plugin libraries so contrib plugins load in time.

After toggling the setting: run `drush cr` (or clear caches) and **add new component
instances** — existing instances keep the format they were created with.
