<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the PDF Reader formatter

No admin settings page (`configure: null`). PDF Reader is a **field formatter**; you enable
it per field on an entity's *Manage display*.

## UI

1. Add (or reuse) a field of type **File**, **Text (plain)** (`string`), or **URI** holding
   a PDF (a file upload, or a text/URI field with a PDF URL).
2. Go to *Manage display* for the bundle/view mode
   (e.g. `admin/structure/types/manage/<bundle>/display`).
3. For that field, set **Format** to **PDF Reader**.
4. Click the gear to set the options, *Update*, then *Save*.

## Formatter id and settings

Formatter plugin id: **`FieldPdfReaderFields`** (field types `string`, `file`, `uri`).
Stored as ordinary formatter settings on the display component
(`core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>.settings`):

| Setting | Values | Default | Notes |
|---|---|---|---|
| `pdf_width` | integer | `600` | viewer width |
| `pdf_height` | integer | `780` | viewer height |
| `renderer` | `google`, `ms`, `embed`, `pdf-js`, `colorbox` | `google` | `colorbox` only if Colorbox + Libraries enabled |
| `embed_view_fit` | `Fit`, `FitH`, `FitV` | `Fit` | direct-embed only (Adobe open params) |
| `embed_hide_toolbar` | bool | `false` | direct-embed only |
| `download` | bool | `false` | show a download link |
| `link_placement` | `top`, `bottom` | `top` | where the download link sits |

Renderer meaning: `google` = Google Docs Viewer, `ms` = Microsoft Office Web viewer,
`embed` = native `<embed>` with `view`/`toolbar` fragment, `pdf-js` = bundled pdf.js viewer,
`colorbox` = lightbox.

## Setting it programmatically

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_pdf', [
  'type' => 'FieldPdfReaderFields',
  'label' => 'hidden',
  'region' => 'content',
  'weight' => 10,
  'settings' => [
    'pdf_width' => 800, 'pdf_height' => 1000,
    'renderer' => 'pdf-js',
    'embed_view_fit' => 'Fit', 'embed_hide_toolbar' => FALSE,
    'download' => TRUE, 'link_placement' => 'bottom',
  ],
])->save();

// Read back:
$component = $vd->getComponent('field_pdf');   // $component['type'] === 'FieldPdfReaderFields'
```

The `field_pdf` field must be a `file`, `string`, or `uri` field for the formatter to be
offered/applicable. Permission `administer pdf reader` is defined by the module (no admin
form ships with it).
