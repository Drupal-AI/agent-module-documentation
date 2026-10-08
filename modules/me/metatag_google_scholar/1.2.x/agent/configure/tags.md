<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Scholar citation tags

This module has no config UI of its own. It plugs into **Metatag**: configure the tags via
**Configuration → Search and metadata → Metatag** (`/admin/config/search/metatag`) as global defaults,
or through a Metatag field on an entity. A **Google Scholar** group appears in those forms.

## Group

`google_scholar` — `src/Plugin/metatag/Group/GoogleScholar.php` (extends Metatag `GroupBase`).

## Tags (each renders `<meta name="<name>" content="…">`)

| Tag id / meta name | Purpose | Notes |
|---|---|---|
| `citation_title` | Article title | |
| `citation_author` | Author(s) | `multiple = TRUE`; at least one required by Google Scholar |
| `citation_publication_date` | Publication date | |
| `citation_journal_title` | Journal title | |
| `citation_issn` | ISSN | |
| `citation_isbn` | ISBN | |
| `citation_volume` | Volume | |
| `citation_issue` | Issue | |
| `citation_firstpage` | First page | |
| `citation_lastpage` | Last page | |
| `citation_dissertation_institution` | Dissertation institution | |
| `citation_technical_report_institution` | Tech-report institution | |
| `citation_technical_report_number` | Tech-report number | |
| `citation_pdf_url` | Full-text PDF URL | `type = "uri"` |

All tag classes are near-empty subclasses of `MetaNameBase` in `src/Plugin/metatag/Tag/`; rendering,
token replacement and per-entity overrides are handled entirely by Metatag core. All are declared
`secure = FALSE`, so Metatag allows tokens/URLs that resolve at render time.

## Setting values

Enter static text or **tokens** (e.g. `[node:title]`, `[node:field_authors]`,
`[node:field_pub_date:custom:Y/m/d]`) in the Metatag form. Configure globally per bundle in Metatag
defaults, or add a Metatag field to the content type and override per entity. No Drush commands are
provided by this module; use Metatag's own config/token workflow.
