# Configure facets

![Facets list](../../../../../../../screenshots/facets/3.0.x/facets.png)

Manage at `/admin/config/search/facets` (route `entity.facets_facet.collection`). Each facet
is a `facets.facet.*` config entity — exportable and deployable like any config.

## Create a facet
1. **Add facet** (`entity.facets_facet.add_form`) → pick a **facet source** (a Search API
   view/display) and the indexed **field** to facet on.
2. Choose a **widget** on the settings form (`entity.facets_facet.settings_form`):
   `links`, `checkbox`, `dropdown`, or `array` (plus widgets from submodules).
3. Enable/order **processors** (see below) and set **URL alias** + query operator (OR/AND).
4. Place the facet's **block** (Block layout) in a region near your search results.

Other entity routes: `edit`, `delete`, `clone`, and per-source config
(`entity.facets_facet_source.edit_form` at `/admin/config/search/facets/facet-sources/{id}/edit`).

## Processors (stages)
Processors run at stages defined in `ProcessorInterface`: `pre_query`, `post_query`,
`build`, `sort`. Common built-ins (`src/Plugin/facets/processor/`):

- **Hide non-narrowing / hide empty** — drop facets that would not refine results.
- **Count limit / soft limit** — cap items shown; soft limit adds show-more/less JS.
- **Sort** — by count, display value, active state, raw value.
- **Exclude specified items**, **Combine facets**, **Dependent facet** (show only when
  another facet is active), **Boolean / Date / Granular item** transforms, **Translate**.

## Config schema
Defined in `config/schema/` (`facets.facet.schema.yml`, `facets.widgets.schema.yml`,
`facets.processor.schema.yml`, `facets.facetsource.schema.yml`, `facets.blocks.schema.yml`).
Export with `drush config:export`; the facet id becomes `facets.facet.<id>.yml`.
