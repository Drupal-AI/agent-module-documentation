# Redirect Sage — manual setup guide

**Redirect Sage** (`redirect_sage`) does bulk **CSV import and export** for the
[Redirect](https://www.drupal.org/project/redirect) module — and it does it
without dragging in the whole Migration stack. If you have a spreadsheet of old
and new URLs from an SEO clean‑up or a site relaunch, this module lets you paste
or upload it and turn it straight into redirect entities, and export your existing
redirects back to CSV just as easily.

Its distinguishing feature is that it understands **language prefixes** in source
URLs, which most bulk‑import tools handle awkwardly. The simplest input line is
just `/old-page-url,/new-page-url`, and the importer also accepts an optional
language code and status code per line to override the defaults — so SEO teams can
work from a clean, minimal CSV rather than repeating boilerplate on every row.

Redirects are created and updated through Redirect's own entity API (no raw SQL),
and imports run through Drupal's Batch API so a large file won't time out. Both
the import and export screens require the **Administer redirects** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Redirect.

There is no traditional settings form — the module's two screens *are* its
interface (an import form and an export form), both described under "How to use
it" below.

## Where it lives in the admin menu

Both screens sit under the Redirect module's area at **Configuration → Search and
metadata → URL redirects**:

- **Import:** `/admin/config/search/redirect/sage_import`
- **Export:** `/admin/config/search/redirect/sage_export`

Both require the **Administer redirects** permission.

## How to use it

### Importing redirects from CSV

1. Go to the import form (`/admin/config/search/redirect/sage_import`).
2. Choose **text** (paste rows directly) or **file** (upload a CSV).
3. Provide one redirect per line in this format:

   ```
   source, destination, language code, status code
   ```

   - **source** and **destination** are **required**. Any query string is parsed
     off (for example `?a=b`), and leading/trailing slashes are trimmed.
   - **language code** is optional — use `und` (unspecified) or an installed
     language code. An unknown code causes that row to be skipped and logged.
   - **status code** is optional — it must be greater than 300 and less than 400;
     otherwise **301** is used.

4. Submit. The importer matches existing redirects (by a hash of source, source
   query, and language) and updates them; anything with no match is created as a
   new redirect. Invalid or skipped rows are written to the `import sage` log
   channel, and when the batch finishes you get a summary of how many rows were
   inserted, updated, and skipped.

### Exporting redirects to CSV

1. Go to the export form (`/admin/config/search/redirect/sage_export`).
2. Optionally filter the export by **from** (source contains), **code** (exact
   HTTP status code), and **lang** (language code, or `und` for unspecified).
3. Submit to download a streamed `redirect-export.csv` with columns *source*,
   *destination*, *language*, and *status code*.

> **Compatibility note:** this release declares support for **Drupal 9.3 and 10**
> (`core_version_requirement: ^9.3 || ^10`). Confirm Drupal 11 compatibility on
> the [project page](https://www.drupal.org/project/redirect_sage) before using
> it on a Drupal 11 site.
