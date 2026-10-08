# Configure a facets summary

A summary is a `facets_summary` config entity bound to a facet source. Manage under
`/admin/config/search/facets` (routes in `facets_summary.routing.yml`):

- **Add**: `entity.facets_summary.add_form` (`/admin/config/search/facets/add-facet-summary`)
- **Edit / Settings / Delete**: `entity.facets_summary.{edit,settings,delete}_form`
  (`.../facet-summary/{facets_summary}/...`)

Steps:
1. Add a summary, pick the **facet source** (the same Search API display your facets use).
2. On the settings form enable **summary processors** and order them.
3. Place the summary's **block** in a region (usually above the results).

## Built-in summary processors (`src/Plugin/facets_summary/processor/`)
- **ShowSummaryProcessor** — list each active facet value as a removable item.
- **ResetFacetsProcessor** — add a "reset all filters" link.
- **ShowCountProcessor** — show the total result count.
- **ShowTextWhenEmptyProcessor** — display custom text when no filters are active.

Config schema: `config/schema/facets_summary.facets_summary.schema.yml` +
`facets_summary.processor.schema.yml`. Export as `facets.facets_summary.<id>.yml`.
Views integration: a filter and an area plugin let the summary render inside a view.
