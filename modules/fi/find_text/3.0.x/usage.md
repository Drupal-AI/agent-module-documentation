An editor/administrator tool that searches every text field on the site for a given string (or regular expression) directly against the database, and shows which entities and fields contain it, with the match highlighted.

---

Find Text provides a single admin search form at `/admin/find-text` (permission `access find text`, `restrict access: true`). You type a needle and get a results table of the entities where it appears, the specific field(s) it appears in, and the surrounding text with matches highlighted. Under the hood, `TextSearchService::getTextFieldTables()` maps all configured text-based field types (`string`, `string_long`, `text_long`, `text_with_summary`, `link`, `heading`, …) to their storage tables per entity type, then `searchFields()` queries each table: a plain search uses a `LIKE` with `escapeLike()` (so `_` and `%` act as single/multi-char wildcards), and the "regexp" option uses a SQL `REGEXP` condition instead. For paragraphs and Layout Builder blocks it walks up to the owning node so results point at the real host entity. A settings form at `/admin/config/find-text/settings` (`administer find text configuration`, also `restrict access: true`) controls which field types and entity types/bundles are searchable, tables to skip, an optional "render markup" display mode, result caching (on by default, 1 hour), and a CSV export toggle. `hook_find_text_results()` lets other modules filter the result set. This is a direct-DB search utility intended for trusted content managers, not a public site search.

---

- Find every place a product name or phrase appears before renaming it.
- Locate all uses of a specific HTML class across body/text fields.
- Search for a relative or absolute link (broken URL cleanup) across content.
- Hunt down a deprecated shortcode/token string sitewide.
- Search text stored inside paragraphs and Layout Builder custom blocks.
- Use `_`/`%` wildcards for fuzzy single- or multi-character matches.
- Run a regular-expression search across all text fields.
- See exactly which field of which entity contains a match, highlighted.
- Search menu link titles/URLs and taxonomy term names/descriptions.
- Restrict searching to chosen entity types and bundles.
- Restrict searching to chosen field types (e.g. only long text).
- Skip specific/expensive tables from the search.
- Export search results to CSV for audit or bulk-edit planning.
- Cache repeated searches for an hour to reduce DB load.
- Audit content for leftover placeholder or "lorem ipsum" text.
- Verify a legal/brand phrase is present (or absent) across the site.
- Find embedded entity/media references by their raw markup.
- Give content managers a search tool without database access.
- Filter/exclude results programmatically with `hook_find_text_results()`.
- Render matched HTML (tables/lists/headings) for readability via the render mode.
- Preflight a content migration by locating all instances of an old string.
