# Configure Entity PDF

## Settings form
Route `entity_pdf.settings` → `/admin/config/system/entity_pdf`, permission
`administer entity pdf settings` (`restrict access: true`). Form
`Drupal\entity_pdf\Form\EntityPdfSettingsForm`, config object `entity_pdf.settings`.

| Key | Field | Default | Meaning |
|---|---|---|---|
| `filename` | textfield | `[node:nid].pdf` | Output filename; accepts entity **tokens** (replaced via `token.replace`, alterable with `hook_entity_pdf_filename_alter`). |
| `tempDir` | textfield | `sites/default/files/entity_pdf` | mPDF temp/font-cache dir, **relative to `DRUPAL_ROOT`** (no leading slash). Used as `DRUPAL_ROOT . '/' . tempDir`. |
| `customPdfTemplatePath` | textfield | `''` | Dir (relative to `DRUPAL_ROOT`) containing a custom `htmlpdf.html.twig`. Empty = module's bundled template. Only honoured if `DRUPAL_ROOT/<path>/htmlpdf.html.twig` exists (checked in `entity_pdf_theme()`). |
| `openInBrowser` | checkbox | `false` | If TRUE, PDFs render inline; else download. `?inline=1` on a PDF URL forces inline per-request. |
| `renderingEngine` | select | `entity_pdf_engine_mpdf` | Plugin id of the active `EntityPdfRenderingEngine`. |
| `renderingEngineOptions` | vertical tabs | — | Per-engine option values; each engine supplies its own settings sub-form (`overrideSettingsForm`). |

Schema: `config/schema/entity_pdf.schema.yml` (`entity_pdf.settings`, all scalar). Defaults in
`config/install/entity_pdf.settings.yml`.

## Drush
```
drush config:set entity_pdf.settings filename '[node:title].pdf' -y
drush config:set entity_pdf.settings openInBrowser 1 -y
drush config:set entity_pdf.settings renderingEngine entity_pdf_engine_mpdf -y
```

## The htmlpdf template
`templates/htmlpdf.html.twig` receives `title`, `content`, `base_url`, `langcode`. No Drupal
CSS/JS is attached — the template is the entire document, so add all styling inline. Override by
copying it into `customPdfTemplatePath` (then `drush cr`). Per-field print theming: the module
adds `field__<view_mode>` template suggestions (`entity_pdf_theme_suggestions_field_alter`).

## Install / library
Requires `mpdf/mpdf ^8.0` — install the module **with Composer** so the library is present.
The bulk action config `system.action.entity_pdf_download_action` ships in `config/install`.
