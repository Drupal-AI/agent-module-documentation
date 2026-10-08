<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# redirect_sage CSV format & usage

## Import — `/admin/config/search/redirect/sage_import`
Choose **text** (paste) or **file** (upload). One redirect per line:

```
source, destination, language code, status code
```

- `source`, `destination` — required. Query strings are parsed off (`?a=b`). Leading/trailing slashes trimmed.
- `language code` — optional; `und` or an installed langcode. Unknown codes → row skipped and logged.
- `status code` — optional; must be `> 300 && < 400`, else 301 is used.

Existing redirects are matched by `Redirect::generateHash(source, sourceQuery, langCode)` and updated; otherwise a new redirect entity is created. Invalid/skipped rows are written to the `import sage` dblog channel; a finished callback summarises inserted/updated/skipped counts.

## Export — `/admin/config/search/redirect/sage_export`
Optional filters: `from` (source CONTAINS), `code` (exact HTTP code), `lang` (langcode, `und` for unspecified). Produces a streamed `redirect-export.csv` with columns source, destination, language, status code.

Both routes require the `administer redirects` permission.
