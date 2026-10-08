<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliography & Citation - Import (bibcite_import) — agent index

Imports `bibcite_reference` entities from uploaded files in any registered `bibcite_format`
(BibTeX, RIS, EndNote, MARC), as a batch, with contributor/keyword deduplication controls.

- **Settings (`bibcite_import.settings`: dedup toggles)** → [configure/settings.md](configure/settings.md)
- **Import/populate forms, routes, formats** → [api/import.md](api/import.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts: config object `bibcite_import.settings` with nested `settings.contributor_deduplication`
and `settings.keyword_deduplication` (both default `true`). Import form at
`/admin/content/bibcite/reference/import` (permission `bibcite import`+`administer bibcite`);
populate form at `/admin/content/bibcite/reference/populate` (permission `bibcite
populate`+`administer bibcite`); settings form at `/admin/config/bibcite/settings/import` (route
`bibcite_import.settings`). Import formats = `bibcite_format` plugins whose encoder is a
`DecoderInterface`.
