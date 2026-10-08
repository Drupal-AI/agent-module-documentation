<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring PDF

Two independent things to configure: the **global viewer path** (`pdf.settings`) and the
**per-field formatter** on *Manage display*.

## Global: `pdf.settings.custom_viewer`

| | |
|---|---|
| Route | `pdf.config_form` → `/admin/config/media/pdfjs` |
| Form class | `Drupal\pdf\Form\ConfigForm` (`getFormId()` returns `config_form`) |
| Permission | `administer pdfjs` ("Administer PDF.js") |
| Menu link | `pdf.config_form`, parent `system.admin_config_media`, title "PDF.js" |
| Config object | `pdf.settings` — **one** key: `custom_viewer` |
| `configure` in info.yml | **absent** → `configure: null`. The form is reachable only via the menu link/route. |

`custom_viewer` is a full docroot-relative path to a replacement `viewer.html`, e.g.
`/sites/default/themes/yourtheme/pdfjs/viewer.html`. Leave it empty to use the default,
`base_path() . 'libraries/pdf.js/web/viewer.html'`. Only `pdf_default` reads it; the canvas
formatters render with the pdf.js API and ignore it.

```bash
drush config:set pdf.settings custom_viewer '/themes/custom/mytheme/pdfjs/viewer.html' -y
drush config:get pdf.settings
drush config:delete pdf.settings -y   # back to baseline: the module ships no config/install
```

The module has **no `config/schema/`**, so `pdf.settings` is schema-less: `drush config:set`
will ask to create the object the first time (it does not exist after install) and strict
config-schema checking in tests will complain about it.

## The pdf.js library (required, not bundled)

`pdf.libraries.yml` declares:

- `pdf/mozilla.pdf.js` → `/libraries/pdf.js/build/pdf.js` (remote: mozilla/pdf.js, Apache).
- `pdf/drupal.pdf` → depends on `pdf/mozilla.pdf.js`, adds `js/pdf.js` + `css/pdf.css`.
- `pdf/default` → `js/acrobat_detection.js` + `js/default.js` (browser plugin detection).

Download a pdf.js release and unpack it so the docroot contains
`libraries/pdf.js/build/pdf.js`, `libraries/pdf.js/build/pdf.worker.js` and
`libraries/pdf.js/web/viewer.html`. Without it the iframe 404s and the canvases stay blank —
there is no requirements check or status-report warning.

## Per field: pick a formatter on Manage display

1. Add a core **File** field to a bundle and allow the `pdf` extension.
2. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
3. Set the field's Format to one of *PDF: Default viewer of PDF.js* / *PDF: Display the first
   page* / *PDF: Continuous scroll (experimental)*.
4. Open the cog to set width/height/scale and the pdf.js viewer options.

Scriptable equivalent (settings keys are listed in
[../plugins/formatters.md](../plugins/formatters.md)):

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_pdf_doc', [
  'type' => 'pdf_thumbnail',
  'region' => 'content',
  'label' => 'hidden',
  'settings' => ['scale' => 1.5, 'width' => '300px', 'height' => ''],
])->save();
```

## Permission

`administer pdfjs` gates only the settings route. Nothing else in the module is permission
controlled — viewing a rendered PDF is governed by the file field's own access.

```bash
drush role:perm:add editor 'administer pdfjs'
```
