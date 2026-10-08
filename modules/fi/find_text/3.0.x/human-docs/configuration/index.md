# Configuration

Find Text has two screens: the **search form** (where you run a search) and the
**settings form** (where you control what is searchable). Both are protected by
restricted permissions.

## Running a search

Go to `/admin/find-text` (requires **Access find text**). The form offers:

- **The search text** — the string to look for. In a plain search, `_` matches any
  single character and `%` matches any run of characters, so you can search with
  wildcards.
- **Regexp** — switch to a full regular‑expression search instead of a plain/wildcard
  match.
- **Render markup** — render the matched HTML so tables, lists, and headings display
  as themselves (more readable), instead of showing escaped surrounding text.
- **Language** — filter results to a specific language.

Results are grouped by entity, showing the field the match is in and the surrounding
text with the match highlighted. Matches inside paragraphs and Layout Builder blocks
are shown against their host node.

## Settings

Go to **Configuration → Content authoring → Find Text settings**
(`/admin/config/find-text/settings`, requires **Administer find text configuration**).
The settings control the scope and cost of searches:

- **Field types** — which text‑based field types are searched. Out of the box this
  includes plain text, long text, formatted long text (with summary), link fields,
  and heading fields. Only field types you enable here are searched.
- **Search all entity types** — when on (the default), every entity type's matching
  fields are searched. Turn it off to limit the search to specific entity types.
- **Entity types and bundles** — used when "search all entity types" is off: choose
  which entity types (and bundles) are searchable. Ships pre‑configured for nodes
  (page, article), menus, taxonomy, custom blocks, and paragraphs.
- **Tables to skip** — database tables to exclude from the search. By default this
  skips several `*_revision` and `*_field_data` tables so you don't get duplicate or
  old‑revision hits.
- **Enable search results cache** and **Cache duration** — cache repeated searches
  (on by default, for one hour / 3600 seconds) to reduce database load. Turn caching
  off if you need always‑fresh results.
- **Save as CSV** — off by default; when on, offers a CSV export of the results for
  audit or bulk‑edit planning.

## Permissions

- **Access find text** — use the search form. *Restricted* — grant only to trusted
  content managers, since it reads content directly from the database.
- **Administer find text configuration** — change the settings above. *Restricted*.

## A note on scope

This is a direct‑database search utility, not a public site search. Because it can be
expensive on large sites, keep caching on where you can, restrict searchable field
and entity types to what you actually need, and grant the permissions only to trusted
roles.
