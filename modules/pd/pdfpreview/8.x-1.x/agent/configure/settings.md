# Configure PDF Preview

Global preview settings live in the config object **`pdfpreview.settings`**. Edit them at
`/admin/config/media/pdfpreview` (route `pdfpreview.settings`, form
`Drupal\pdfpreview\PDFPreviewSettingsForm`, permission `administer site configuration`). The menu link
sits under *Configuration › Media* (`system.admin_config_media`).

## Config keys (schema `config/schema/pdfpreview.schema.yml`)

| Key | Type | Install default | Editable in the settings form? | Meaning |
|-----|------|-----------------|-------------------------------|---------|
| `size` | string | `1024x1024` | yes | ImageMagick `-resize` geometry (pixels). Must be large enough for any image style you apply. |
| `quality` | integer | `75` | yes | ImageMagick `-quality` value (percentage). |
| `path` | string | `pdfpreview` | yes | Sub-directory inside the default file scheme where previews are written. |
| `filenames` | string | `human` | yes | `human` = `<fid>-<transliterated-pdf-basename>`; `machine` = `md5('pdfpreview'.<fid>)`. |
| `type` | string | `png` | yes | Output image type, `png` or `jpg`. |
| `show_description` | boolean | `FALSE` | no (formatter default only) | Default for the formatter's "show description" option. |
| `tag` | string | `span` | no (formatter default only) | Default wrapper HTML tag (`span`/`div`) for the formatter. |
| `fallback_formatter` | string | `file_default` | no (formatter default only) | Default value seeded into the formatter's fallback option. |

Only `path`, `size`, `quality`, `filenames`, and `type` are exposed by the settings form. The last
three keys are read by the formatter's `defaultSettings()` as per-display defaults; they are not edited
through this global form (they ship from `config/install/pdfpreview.settings.yml`).

Changing `filenames` or `type` does not rewrite already-generated previews — old files must be deleted
manually (previews are regenerated lazily on next view; see [../api/generator.md](../api/generator.md)).

## Set via drush / PHP

```php
\Drupal::configFactory()->getEditable('pdfpreview.settings')
  ->set('size', '800x800')
  ->set('quality', 90)
  ->set('path', 'pdfpreview')
  ->set('filenames', 'machine')
  ->set('type', 'jpg')
  ->save();
```

```bash
drush config:set pdfpreview.settings size 800x800 -y
drush config:set pdfpreview.settings type jpg -y
```

Destination previews are written to `<default_scheme>://<path>/…` where `<default_scheme>` comes from
core `system.file:default_scheme`.
