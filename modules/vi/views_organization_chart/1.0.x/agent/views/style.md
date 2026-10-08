<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style: Organization chart

Provides one Views **style plugin** so any view display can be rendered as a Highcharts
organization chart instead of a list/table.

- Plugin id: `views_organization_chart`
- Class: `Drupal\views_organization_chart\Plugin\views\style\ViewsOrganizationChart` (extends `StylePluginBase`)
- Registered via `#[ViewsStyle(id: "views_organization_chart", title: "Organization chart", help: "Displays rows in a organization chart.", theme: "views_style_views_organization_chart", display_types: ["normal"])]`
- `usesRowPlugin = TRUE`, `usesRowClass = TRUE`. `getCacheMaxAge()` returns `Cache::PERMANENT`; `getCacheTags()` returns `[]`.

## Enable it on a view

1. Create/edit a view that lists the entities forming the hierarchy (users, taxonomy terms, nodes…).
2. Set **Format → "Organization chart"**.
3. Add the view **fields** the style needs (below), then open the style **Settings** and map them.

Each row becomes a chart node; an edge is drawn from the row's parent to the row. Which row is
a "child of" which is determined entirely by the value of the **Parent field** you select — see
theme/rendering.md for the exact node/edge construction.

## Style options (settings form)

`buildOptionsForm()` builds `#type => select` dropdowns from the display's own field handlers.
Defaults come from `defineOptions()`.

| Option (config key) | Form label | Required | Choices offered | Default |
|---|---|---|---|---|
| `name_field` | Name field | **Yes** | any view field | `''` |
| `title_field` | Title field | No | any view field | `''` |
| `image_field` | Avatar field | No | only fields of type `image` | `''` |
| `parent_field` | Parent field | **Yes** | only fields of type `entity_reference_label` | `''` |
| `levels_color` | Level color | No | textfield, comma-separated colors | `silver,#980104,#359154` |

Field notes (from the code, not guessed):

- **Parent field** is the hierarchy edge. The dropdown only lists fields whose handler
  `options["type"] == "entity_reference_label"`, i.e. an entity-reference field displayed as a
  label. Add the entity's self-reference as a view field and choose it here:
  - taxonomy view → add the term **parent** field;
  - user view → add a **user reference** field pointing at the manager;
  - node view → add a **content/entity reference** field pointing at the parent node.
  At runtime the handler's `getValue($row)` yields the referenced entity id (its `current()` value
  if multi-valued); an edge `[parentId, rowEntityId]` is created when that id is truthy and differs
  from the row's own id. Rows whose parent is empty/0/self become root nodes.
- **Name field** (required) is the node label; rendered with the field's own Views render pipeline
  (`advancedRender()`), so any field formatter/rewrite you set applies. If Name renders empty the
  Title value is used as the label instead.
- **Avatar field** only lists `image` fields; the referenced file is run through the core
  **`thumbnail`** image style and shown inside the node. (The row must actually have a file for
  that field or preprocessing errors — leave it as "- None -" if unsure.)
- **Level color** maps to Highcharts `series.levels`: the string is `explode(',')`-split and each
  piece becomes a color for that 0-indexed hierarchy level (level 0 = roots). Fewer colors than
  levels simply leaves deeper levels at the series default `#007ad0`.

## Setting the options in config / PHP (no UI)

The style lives in the display's `style` section of the view config
(`views.view.<id>` → `display.<display>.display_options.style`):

```yaml
style:
  type: views_organization_chart
  options:
    name_field: title            # required
    parent_field: field_parent   # required; an entity_reference_label field
    title_field: field_job_title
    image_field: field_photo
    levels_color: 'silver,#980104,#359154'
```

Config-schema caveat: `config/schema/views_organization_chart.schema.yml` defines the mapping
`views.style.views_organization_chart` but only declares a single `wrapper_class` string key — it
does **not** list the five real option keys above. Views still stores and loads them (they are
declared in `defineOptions()`), but `drush config:inspect`-style schema validation will flag them
as unknown. Treat the option keys in this doc as authoritative.

No permissions are defined; visibility of a chart is exactly the access of the view display and of
the underlying rows (standard Views/entity access).
