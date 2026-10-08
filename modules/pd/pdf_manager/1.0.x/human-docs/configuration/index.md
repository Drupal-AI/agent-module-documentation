# Configuration

PDF Manager has no traditional "settings form" — its configuration is really
**one permission** plus the **management screen** where all the work happens. This
page covers both.

## Grant the permission (do this first)

Every operation in PDF Manager requires the restricted **administer pdf manager**
permission. Assign it deliberately:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Administer pdf manager** and tick it only for roles you fully trust
   (typically just Administrator).
3. Save.

> **Why this matters:** the bulk‑download feature can add loose files to the ZIP by
> their server path, and it does not confine those paths to Drupal's file
> directories. In practice that means a holder of this permission could download
> other server‑readable files, not just your PDFs. It is reachable only *after*
> authentication by someone who already has this admin permission, so the risk is
> limited to trusted administrators — but that is exactly why you should grant the
> permission sparingly.

## The management screen

Open **Content → PDF Manager** (`/admin/content/pdf-manager`). Everything below
happens here.

### Scan

Click to scan the site for PDFs. The module combines a database query for managed
files (MIME type `application/pdf`, published/active) with a recursive scan of
`public://`, `private://`, and the default files directories — skipping cache,
temp, and vendor‑style folders. Duplicates that exist both on disk and in the
database are merged. The page then shows the **total count** and **combined size**
of your PDF library. Results are cached for about 15 minutes so repeat visits are
fast.

### Clear cache

Clears the cached scan results so your next scan is fresh. Use this after you have
added, replaced, or removed PDFs and want an up‑to‑date inventory.

### Bulk‑download as ZIP

Select the PDFs you want and download them as a single ZIP archive. Large
selections are processed through Drupal's **batch** system so the download does
not time out; the archive is written to the temp directory with a per‑user name.

### Export to CSV

Export the scan results to a CSV file — a convenient inventory you can open in a
spreadsheet or use as the basis for a replacement mapping (below).

### Replace a PDF

To swap an existing PDF for a new version:

1. Upload a **CSV mapping** that ties filenames to their locations (the CSV you can
   generate with the export above is a natural starting point).
2. Upload the **replacement PDF**. The module validates it: the file must be a
   genuine `application/pdf` and no larger than **50 MB**, and its name is matched
   against the CSV mapping before the target file is replaced.

Failures (for example a rejected upload) are recorded to the `pdf_manager` log
channel, so check **Reports → Recent log messages** if something doesn't behave as
expected.
