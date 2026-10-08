<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the `eref_node_titles` Views filter

There is no admin settings page. You configure everything inside a **View**.

## Prerequisites in the View

1. A base that exposes `node_field_data` (e.g. a Content / node View).
2. A **standard entity-reference relationship** — in the Views UI, *Advanced → Relationships →
   Add*, choose a "Content referenced from <field>" relationship (a node entity-reference
   field). The filter only accepts standard node reference relationships; it strips out
   comment/user/vid/nid and target_id relationships and marks itself **broken** if none is valid.

## Adding the filter (UI)

*Filter criteria → Add* → search "Entity Reference Exposed Filters Node Titles"
(id `eref_node_titles`, on the Content table). It is **always exposed** (the expose button is
disabled), so once added it appears as an exposed dropdown of referenced node titles.

### Extra options (filter settings form)

| Option | Values | Effect |
|---|---|---|
| `sort_by` | `nid` (0) / `title` (1) | attribute the option list is sorted by |
| `sort_order` | `DESC` (0) / `ASC` (1) | order of the option list |
| `sort_bundle_order` | `DESC` (0) / `ASC` (1) | order when multiple target bundles |
| `get_unpublished` | Unpublished (0) / Published (1) / All (2) | which referenced nodes appear |
| `get_filter_no_results` | Yes (0) / No (1) | drop options that would yield no results |

(The stored values are the numeric indexes shown above.)

## Config shape (views.view.* )

Inside a display's `display_options.filters`, the filter entry looks like:

```yaml
eref_node_titles:
  id: eref_node_titles
  table: node_field_data
  field: eref_node_titles
  plugin_id: eref_node_titles
  relationship: <your_reference_relationship_id>
  exposed: true
  sort_by: 1
  sort_order: 1
  sort_bundle_order: 1
  get_unpublished: 1
  get_filter_no_results: 1
```

Check a View's config for the filter:

```bash
drush cget views.view.<your_view> display.default.display_options.filters
# look for a filter whose plugin_id is eref_node_titles
```

## Config schema

`config/schema/entity_reference_exposed_filters.schema.yml` defines
`views.filter.eref_node_titles` (type `views_filter`) and
`views.filter_value.eref_node_titles` (numeric), so the filter validates within Views config.

## Limitations

- Node references only — **not** taxonomy terms or users (separate handling would be needed).
- Reference fields whose selection handler is a **View** are unsupported (the filter errors and
  asks for a content-type–filtered field instead).
