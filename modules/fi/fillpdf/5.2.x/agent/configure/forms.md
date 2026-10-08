# FillPDF forms & field mappings

Templates are managed at **`/admin/structure/fillpdf`** (route `fillpdf.forms_admin`, permission
`administer pdfs`). Two content entities are involved:

- **`fillpdf_form`** — one uploaded PDF template + its output settings.
- **`fillpdf_form_field`** — one mapping per fillable field found in the PDF.

## Upload a template → create a FillPdfForm

The overview form (`FillPdfOverviewForm`) and the form edit form (`FillPdfFormForm`) expose a
`managed_file` upload restricted to **PDF only**:

```php
'#type' => 'managed_file',
'#upload_validators' => ['FileExtension' => ['extensions' => 'pdf']],
```

The `file` base field also sets `file_extensions: 'pdf'`. On upload, `InputHelper::attachPdfToForm()`
saves the file permanent, creates/updates the `fillpdf_form`, then `parseFields()` asks the configured
backend to parse the AcroForm fields and creates a `FillPdfFormField` per unique field name.

## `fillpdf_form` base fields (output configuration)

| Field | Purpose |
|---|---|
| `file` | The managed PDF template (`.pdf`). |
| `admin_title` | Label on the overview page. |
| `title` | **Filename pattern** for the generated PDF; supports tokens (e.g. `Invoice-[node:title].pdf`). |
| `default_entity_type` / `default_entity_id` | Default entity used when the link supplies none. |
| `destination_path` | Optional subdirectory (token-supported) under `fillpdf/` when saving. |
| `scheme` | Storage scheme for saved output (allowed values = available ∩ `allowed_schemes`). |
| `destination_redirect` | If set (and saving), redirect the browser to the saved PDF. |
| `replacements` | Transform values before writing into the PDF. |
| `pdftk_encryption` | `''` / `encrypt_128bit` / `encrypt_40bit` (pdftk backend). |
| `permissions` | pdftk permission flags (Printing, CopyContents, FillIn, …); **none set = none allowed**. |
| `owner_password` / `user_password` | pdftk PDF passwords (shell-escaped when used). |

Filename building (`HandlePdfController::buildFilename()`): tokens are replaced first, then spaces →
`_`, a trailing `.pdf` stripped, all chars outside `[a-zA-Z0-9_.-]` removed, and `.pdf` re-appended.
Empty → `untitled.pdf`.

## Field mapping (`fillpdf_form_field`)

Edit each field at `/admin/structure/fillpdf/{fillpdf_form}/{fillpdf_form_field}`
(`FillPdfFormFieldForm`). A mapping resolves at merge time into either:
- a **TextFieldMapping** — a token/text string written to the PDF field, or
- an **ImageFieldMapping** — image data (e.g. from an image field) placed into the PDF field.

Tokens are resolved by `fillpdf.token_resolver` against the request's loaded entities.

## Form operations (routes, all `administer pdfs`-gated via entity access)

| Route | Path | Use |
|---|---|---|
| `entity.fillpdf_form.edit_form` | `/admin/structure/fillpdf/{id}` | Edit template + settings + fields. |
| `entity.fillpdf_form.delete_form` | `…/{id}/delete` | Delete. |
| `entity.fillpdf_form.export_form` | `…/{id}/export` | Export config + field mappings. |
| `entity.fillpdf_form.import_form` | `…/{id}/import` | Import config + field mappings. |
| `entity.fillpdf_form.duplicate_form` | `…/{id}/duplicate` | Clone form + mappings. |

Access to all of these is governed by `fillpdf_form` / `fillpdf_form_field` entity access
(`_entity_access` requirements), i.e. the `administer pdfs` permission.

## Saving output

`OutputHandler::savePdfToFile()` resolves `destination_path` tokens, builds a URI in the form's `scheme`
under `fillpdf/…`, creates the directory, writes the data (`FileExists::Rename`), and records a
`FillPdfFileContext` linking the saved file to the generating context. If the scheme is unavailable or
not allowed, the controller downgrades to a browser download instead of writing.
