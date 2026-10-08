<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Views Filter adds one exposed Views text filter that searches media by media name, file name, file path and thumbnail alt/title all at once, plus two Views fields that display a file's URL and a media item's alt text.

---

Drupal core's media administration view (`/admin/content/media`) lets editors filter only by the *media* entity's name, never by the underlying *file* name — a real problem when someone remembers "the file was called `budget-final-v3.pdf`" but not what the media item was titled. This module closes that gap with a single Views handler. Via `hook_views_data()` it registers three handlers on the `media_field_data` table: a filter (`media_file_name`, class `MediaFileNameFilter`) and two display fields (`media_file_name` and `media_alt_text`). The filter extends the core `StringFilter` but deliberately exposes only the **contains** operator — every other operator (`=`, `starts`, `regex`, `empty`, `word`/`allwords`, etc.) is unset in `operators()`. When queried, it LEFT-joins `media_field_data` → `file_usage` and INNER-joins `file_usage` → `file_managed`, groups by `media_field_data.mid` to de-duplicate, then builds an **OR** where-group that runs the entered value as `LIKE '%value%'` against five columns: `media_field_data.name`, `file_managed.filename`, a `REPLACE(...)`-normalised `file_managed.uri` (stripping the `public://`/`private://` stream prefix), `thumbnail__alt` and `thumbnail__title`. All search values are passed through `Connection::escapeLike()` and bound as query parameters, so the LIKE wildcards are escaped and there is no SQL injection surface. The intended workflow is: add the "Media name/file name" filter to a core media view, tick "Expose this filter", delete the stock "Media: Name" filter, and save. The two optional fields — "File name" (renders an `<a>` link to `File::createFileUrl()`) and "Alt text" (renders the thumbnail's alt attribute) — exist mainly to make the filter's matches visible in the result table. The module has no admin UI, no settings, no permissions and no config schema; all configuration happens per-view in the Views UI, so remember to export config after editing a view. Package `OHSU` marks it as work released from Oregon Health & Science University's own site; it is a `1.0.0-rc1` release candidate not covered by Drupal's security advisory policy, and `info.yml` declares no explicit module dependencies even though the code hard-requires `media`, `views` and `file`.

---

- Let editors filter the core media library by the underlying file name, not just the media name.
- Search `/admin/content/media` by a remembered filename like `report-Q3.pdf`.
- Find a media item when you only recall part of the file path.
- Add a single "contains" search box that matches media name OR file name OR alt text at once.
- Expose the filter on the `media_library` modal so the media picker becomes searchable by filename.
- Locate an image by its alt-text wording.
- Build a custom media administration view with one unified search field.
- Replace the stock "Media: Name" exposed filter with a broader media/file search.
- Show the real file URL in a media listing with the "File name" field.
- Display each media item's alt text as a column for an accessibility audit.
- Search media by the file's stored URI without the `public://`/`private://` scheme getting in the way.
- Help content editors who think in filenames rather than media titles.
- Give a media report view a free-text search across name, filename and alt attributes.
- Match media whose thumbnail title attribute contains a term.
- De-duplicate media rows that would otherwise repeat once per file-usage record (handled via GROUP BY).
- Provide a filename-aware search on a documents/downloads media view.
- Surface unnamed or badly named media by searching their actual file paths.
- Build an editor-facing "find my file" view without writing a custom Views handler.
- Add filename search to a media browser embedded in a custom admin dashboard.
- Give reviewers a single field to check both alt text and filename while curating media.
- Search across image, document and video media types in one filter (it matches on shared media/file columns).
