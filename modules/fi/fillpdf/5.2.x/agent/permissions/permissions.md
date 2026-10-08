# FillPDF permissions

From `fillpdf.permissions.yml` (three permissions):

| Permission | Gates |
|---|---|
| `administer pdfs` | The settings form (`/admin/config/media/fillpdf`) and all FillPDF form admin screens (`/admin/structure/fillpdf`, incl. upload, edit, delete, import/export, duplicate, and field mapping). Also always allowed to generate any PDF (incl. `sample`). |
| `publish own pdfs` | Generating a PDF from the `/fillpdf` route **only for contexts whose entities the user can already `view`** (checked entity-by-entity). |
| `publish all pdfs` | Generating a PDF from any FillPDF form with any content context, regardless of entity view access. |

## How they combine (`FillPdfAccessHelper::canGeneratePdfFromContext`)

1. `administer pdfs` OR `publish all pdfs` → allowed.
2. `sample` request → allowed only if `administer pdfs`.
3. `publish own pdfs` (non-sample) → allowed only if the user can `view` every entity in the context;
   any un-viewable entity → forbidden.
4. Otherwise → forbidden.

`administer pdfs` is the `_entity_access`/`_permission` requirement on every management route, so it is
effectively the "site builder" permission. Template uploads (`.pdf`-restricted) are only reachable with
it. `publish own pdfs` is the safe default for letting end users produce PDFs from their own/visible
content; grant `publish all pdfs` only to trusted roles since it bypasses per-entity view checks.
