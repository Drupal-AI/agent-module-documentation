# Configuration

Path Redirect Import has no settings form. "Configuring" it means understanding the
**CSV format** and using the **Migrate** and **Export** tabs (or the Drush
commands). Everything below is reached from **Configuration → Search and metadata →
URL redirects** (`/admin/config/search/redirect`), and every action requires the
**Administer redirects** permission (from the Redirect module).

## The CSV format

The header row is required and must be exactly these four columns:

```
source,destination,language,status_code
```

Sample rows:

| source | destination | language | status_code |
|---|---|---|---|
| `source-path` | `<front>` | `und` | `301` |
| `source-path-other?param=value` | `my-path` | `en` | `302` |
| `my-source-path` | `https://example.com` | `und` | `302` |

What each column means:

- **source** — the old path to redirect *from*. A leading `/` is stripped
  automatically, and query strings are kept. Together with **language** this forms
  the row's unique identifier.
- **destination** — where to send visitors: an internal path, `<front>`, or an
  absolute external URL.
- **language** — the langcode (for example `en`, or `und` for "undefined"/all
  languages).
- **status_code** — the HTTP redirect code (301, 302, …). If you leave it blank, the
  import defaults it to **301** (permanent).

## Import redirects (Migrate tab)

1. Open the **Migrate** tab (`/admin/config/search/redirect/migrate`).
2. Upload your CSV and submit **Migrate data**.
3. The file is validated row by row. It is **rejected** if the header doesn't match
   the four column names, if any cell isn't valid UTF‑8, if any cell is empty, or if
   a source equals its destination.
4. On success the import runs as a **batch**, so large files process without timing
   out.

Because the import runs through Migrate, re‑uploading a file with the same
source+language **updates** those redirects in place rather than creating
duplicates.

## Delete redirects (same tab)

To remove redirects instead of creating them, tick **"Delete redirects defined in
the spreadsheet"** before submitting on the Migrate tab. The module looks up the
redirects matching each row in your CSV and forwards you to Redirect's standard
multiple‑delete confirmation form.

## Export redirects (Export tab)

Open the **Export** tab (`/admin/config/search/redirect/export`) and submit it to
write **all** existing redirects to a CSV using the same
`source,destination,language,status_code` structure — the inverse of import. This is
handy for backups, review, or round‑tripping redirects from one environment to
another.

## Automating with Drush

Two commands let you run imports and exports in CI or deploy scripts:

```bash
# Import (alias: prii) — takes the path to a CSV file
drush path_redirect_import:import /path/to/redirects.csv
drush prii /path/to/redirects.csv

# Export (alias: prie) — no arguments; writes all redirects to CSV
drush path_redirect_import:export
drush prie
```

Both commands need the **Migrate Tools** module enabled (it is, as a dependency).

> **Heads‑up:** unlike the web form, the Drush import does **no** pre‑validation of
> the header, encoding, empty cells, or self‑redirects — feed it a clean CSV.
