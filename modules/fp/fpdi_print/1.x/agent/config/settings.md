<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings & the validate helper

## Install / enable

`composer require drupal/fpdi_print` (pulls TCPDF, FPDI, FPDM into vendor), then
`drush en fpdi_print`. No Drupal module dependencies. No `config/install` defaults ship, so
`fpdi_print.settings` keys are null until the settings form is saved.

## Settings form — `SettingsForm` (`src/Form/SettingsForm.php`)

Route `fpdi_print.settings` at `admin/config/content/fpdi-print` (menu link
`fpdi_print.links_menu.yml` under *Configuration → Content*), route permission
**`administer fpdi print`**. `ConfigFormBase` editing the single config object `fpdi_print.settings`.

Fields (all written in `submitForm`):

| Key | Form field | Meaning |
|---|---|---|
| `default_css` | textfield "Path print CSS" | Path to a CSS file; loaded with `file_get_contents` (`PrintBuilder::getStyle`) and injected as a `<style>` block into HTML positions/header/footer. |
| `force_download` | checkbox "Force Download" | Intended to force browser download using the node title (declared in schema/form; note: the actual download-vs-inline behaviour in `viewPrint` is driven by the per-view `file_pdf_name`, not this flag). |
| `page_format` | select "Paper Size" | Options are `array_keys(\TCPDF_STATIC::$page_formats)` — TCPDF's full page-format list (A4, LETTER, …). Used as the page format when **no** template is imported. |
| `orientation` | select "Paper Orientation" | `P` (Portrait) or `L` (Landscape); used when no template is imported. |
| `footer_height` | number "Page footer height" | Overrides `Pdf::$footerHeight` (default 15) for HTML footers. |

When a PDF **template** (`file_pdf`) is imported, page size/orientation come from the imported page
(`getTemplateSize`), so `page_format`/`orientation` apply only to the no-template (render-the-view)
path.

## Config schema — `config/schema/fpdi_print.schema.yml`

`fpdi_print.settings` (`config_object`): `default_css` (string), `force_download` (boolean),
`page_format` (string), `orientation` (string), `footer_height` (integer). This is the only schema;
`provides_config_schema` is true.

## Validate / preview helper — `ValidateForm` (`src/Form/ValidateForm.php`)

Route `fpdi_print.validate` at `/fpdi-print/validate`, permission `administer fpdi print`. A pure
**client-side** preview: a `pdf` path textfield (prefilled from the `?pdf=` query) and a YAML
textarea. It attaches `library fpdi_print/fpdi_print` (`js/pdfi.js` + Ace + pdf.js + js-yaml), which
renders the template with pdf.js and overlays the YAML positions in the browser. The form does **not**
parse the PDF server-side — `submitForm` only re-displays the form. The area handler's options form
deep-links here so editors can dial in x/y coordinates against the real template.

## Permission note

Both admin routes require `administer fpdi print`, but the module ships **no** `permissions.yml` /
`hook_permission` defining it, so no role can be granted it through the UI — in practice only user 1
reaches the settings and validate pages. Integrators who need non-root admins to configure it must
declare the permission themselves.
