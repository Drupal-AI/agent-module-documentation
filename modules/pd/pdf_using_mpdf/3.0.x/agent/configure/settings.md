# Configure PDF using mPDF

Global settings form: `admin/config/user-interface/mpdf` (route `pdf_using_mpdf.admin_form`,
form `AdminSettingsForm`, permission `administer mpdf settings`). All values persist in the
single config object **`pdf_using_mpdf.settings`** under one nested `pdf_using_mpdf` key
(schema `pdf_using_mpdf.settings`). These are *defaults*; a per-call `$settings` array to the
conversion service or `hook_mpdf_settings_alter()` overrides them for a specific document.

## Settings keys (defaults from `config/install`)

| Key | Default | Meaning |
|---|---|---|
| `pdf_filename` | `[site:name]-[date:custom:Y-m-d-H-i]` | Filename (tokens replaced, then transliterated + `[^a-zA-Z0-9_-]` stripped). |
| `pdf_save_option` | `'0'` | Output: `0`=inline in browser, `1`=download dialog, `2`=save to server. |
| `pdf_save_schema` | `default` | File scheme for save-to-server (`default` = system default, or `public`/`private`/…). |
| `pdf_save_path` | `pdf_using_mpdf` | Folder under the scheme for saved PDFs. |
| `pdf_set_title` / `pdf_set_author` / `pdf_set_subject` / `pdf_set_creator` | `''` | PDF document metadata. |
| `view_mode` | `full` | Node view mode rendered for the `node/{node}/pdf` route. |
| `render_anonymous` | `false` | Render the node as the anonymous user before conversion. |
| `margin_top/right/bottom/left/header/footer` | `16/15/16/15/9/9` | Margins in mm (validated numeric ≥ 0). |
| `pdf_font_size` | `12` | Default font size (validated numeric ≥ 1). |
| `pdf_default_font` | `dejavusanscondensed` | One of mPDF's bundled fonts (see `getDefaultFonts()`). |
| `pdf_page_size` | `A4` | Page format (A/B/C series, Letter, Legal, …). |
| `dpi` / `img_dpi` | `96` | Document / image DPI. |
| `orientation` | `P` | `P` portrait or `L` landscape. |
| `pdf_template_file` | `''` | Drupal-root-relative path to a `.pdf` template overlaid via `SetSourceFile`/`UseTemplate`. |
| `watermark_option` | `'0'` | `0`=text watermark, `1`=image watermark. |
| `watermark_opacity` | `'0.1'` | Watermark opacity. |
| `pdf_watermark_text` | `''` | Text watermark (when option 0). |
| `watermark_image` | `{}` | Managed-file id of an uploaded image watermark (when option 1). |
| `pdf_header` | `<strong>[node:title] - [site:name]</strong>\r\n<hr/>` | HTML header (mPDF `SetHTMLHeader`; supports `{PAGENO}`, `{DATE ...}`). |
| `pdf_footer` | `<hr/>\r\n[node:title]` | HTML footer (`SetHTMLFooter`). |
| `pdf_css_file` | `''` | Drupal-root-relative path to a `.css` file to inject; if empty, theme CSS is used. |
| `pdf_css_from_theme` | `true` | Load the active theme's intended library CSS into the PDF. |
| `pdf_css_from_theme_all` | `false` | Load *all* CSS from the theme's declared libraries. |
| `pdf_password` | `''` | If set, `SetProtection(['print','copy'], $password, $password)` — encrypts + restricts print/copy. |

## Notes

- **Tokens:** every non-array setting string is run through the Token service with the node
  context (`['node' => $node]`) at generation time (`replaceAllSettingsTokens()`), so
  `[node:*]` / `[site:*]` / `[date:*]` work in filename, header, footer, and metadata.
- **Template / CSS path validation** (`validateForm`): both must resolve under `DRUPAL_ROOT`
  (`realpath($path) === $path`, blocking `./`/`../`), must exist, and must end in `.pdf` / `.css`
  respectively. These are admin-only inputs.
- **mPDF constructor** is built in `getDefaultConfig()` — `tempDir`, `useActiveForms=TRUE`,
  `format` (page size + `-L` for landscape), font, margins, DPI. `WriteHTML()` receives the body
  HTML (chunked when it exceeds `pcre.backtrack_limit`).
- **Save to server** writes via `file.repository` `writeData()` to `<scheme>://<path>/<filename>.pdf`
  and shows a status message; the other modes return a `Response` with `application/pdf`.

## Set defaults with Drush

```php
// drush php:eval
$c = \Drupal::configFactory()->getEditable('pdf_using_mpdf.settings');
$s = $c->get('pdf_using_mpdf');
$s['pdf_page_size'] = 'Letter';
$s['orientation'] = 'L';
$s['pdf_save_option'] = '1'; // force download dialog
$c->set('pdf_using_mpdf', $s)->save();
```
