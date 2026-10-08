# Field formatters

Two `@FieldFormatter` plugins for `entity_reference` fields, aimed at collection/reference display on
a search-driven site. Select them on a field's Manage display tab.

## `entity_reference_url_title` — "Children Entity Count, Label."

`Drupal\advanced_search\Plugin\Field\FieldFormatter\EntityReferenceCountFormatter` (extends
`EntityReferenceFormatterBase`). Renders the **count** of referenced (accessible) entities plus a
label, e.g. `12 Items in Collection` (pluralized). Setting `label` (default `Items in Collection`)
is edited via the "Text to appear next to the children's count" field.

## `searchable_entity_formatter` — "Searchable entity formatter"

`Drupal\advanced_search\Plugin\Field\FieldFormatter\SearchableEntityFormatter` (extends
`EntityReferenceLabelFormatter`). Renders each referenced entity's label as a **link to a facet
search URL** (built with the `facets.utility.url_generator` service) so clicking a referenced term
runs a filtered search. Access uses `view label`.

| Setting | Default | Meaning |
|---|---|---|
| `search_link` | `search?f[0]` | Search base path (informational label in the settings summary). |
| `search_var` | `all_subjects` | Facet variable the value is applied to when generating the URL. |
| `search_term` | `FALSE` | If TRUE, use the entity **label** as the search value; otherwise use the entity **id**. |
