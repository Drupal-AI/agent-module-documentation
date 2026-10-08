# Configuration

LocalGov Search has no dedicated settings form. Everything is configured through
standard Drupal admin screens — Search API, Views, Block layout and each content
type's display settings. This page walks through the pieces you will actually
touch.

## Place the search block

The header search box is the **Sitewide search block**. If you use the LocalGov
Base or Scarfolk theme it is placed automatically; otherwise add it yourself:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the search box (usually a header region), click
   **Place block**.
3. Choose **Sitewide search block** and save.

The block renders with a proper `role="search"` landmark for accessibility.

## Tune what is indexed and how results look

The two view modes are the main tuning surface — you rarely need to touch Search
API's field list directly:

- **`search_index` view mode** — controls *what content is fed into the index*
  for each content type. Edit it on the content type's **Manage display** screen
  (Structure → Content types → *type* → Manage display → the *Search index*
  display). Fields you show here are indexed; fields you hide are not. Because the
  index stores *rendered* output rather than raw field values, this is also where
  you influence how matches are weighted.
- **`search_result` view mode** — controls *how a result looks* on the `/search`
  page. Edit the *Search result* display on the same Manage display screen to
  change which fields and formatters appear in each result row.

After changing either display, reindex so the change takes effect:

```bash
drush search-api:index localgov_sitewide_search
```

## Adding and removing content types

- **Adding** a content type is automatic. When a new content type is created,
  LocalGov Search adds it to both the index and the results view for you, so it
  becomes searchable with no manual step.
- **Removing** a content type from search is manual. Edit the index at
  **Configuration → Search and metadata → Search API →
  `localgov_sitewide_search` → Edit fields** (or the *Rendered item* field
  configuration) and remove the bundle you no longer want indexed.

## The results page

The results page lives at `/search` (the *Sitewide search page* display of the
`localgov_sitewide_search` view). Out of the box it behaves sensibly:

- Before any search has been submitted (no `s` query parameter) it shows just the
  search form — no header text and no "no results" message.
- Once a search returns results, the search term is added to the results heading.

You can customise the page further by editing the view under **Structure →
Views → Sitewide search**, including adding facets with the
[Facets](https://www.drupal.org/project/facets) module.
