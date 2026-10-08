<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a view to render as a tree

There is **no admin settings page**. You configure it per view display by choosing one of the
module's Views **style plugins** and filling in its options. Everything is stored in the view's
config entity `views.view.<id>` under `display.<display>.display_options.style`.

## The three style plugins

| Style id | Title in Views UI | Base | Theme hook | Use for |
|---|---|---|---|---|
| `tree` | Tree (list) | `HtmlList` | `views_tree` | nested `<ul>`/`<ol>` |
| `tree_table` | Tree (table) | core `Table` | `views_tree_table` | table with an indented column |
| `tree_entity_reference_selection` | TreeHelper (Adjacency model) | `tree` | `views_tree` | entity-reference widgets (`display_types: entity_reference`) |

## Options (all styles)

- `main_field` (**required**) — the field whose value is each row's **unique id**.
- `parent_field` — the field whose value is the **parent row's id**. A row whose parent value is
  `0` (or empty/not matching another row) is treated as a **root**.

`tree` list style also has:
- `type` — `ul` (unordered, recommended) or `ol` (ordered). Inherited from `HtmlList`.
- `collapsible_tree` — `0` (Off), `expanded`, or `collapsed`. When not `0`, attaches the
  `views_tree/views_tree` library (jQuery `collapsible.js`) and passes the view id + mode in
  `drupalSettings.views_tree_settings`.

`tree_table` style also has:
- `display_hierarchy_column` (**required**) — the table column (a field's id, usually the
  title/label) that will be indented to show the hierarchy. That cell gets the CSS class
  `views-tree-hierarchy-cell`, and rows get a `data-hierarchy-level` attribute.
- The entity-reference style (`tree_entity_reference_selection`) also adds `search_fields`
  (which fields the autocomplete searches).

## Via the UI

1. Create/edit a view of the content that carries the parent relationship. Add a **field** for
   the unique id (e.g. Term ID / Content ID) and a **field** for the parent id (e.g. the parent
   reference's target id). Mark them *Exclude from display* if you only want them for structure.
2. In **Format**, click the style link and choose **Tree (list)** or **Tree (table)**.
3. In the style **Settings**, set **Main field** and **Parent field** (and, for the table,
   **Hierarchy display column**). For the list, optionally set **Collapsible view**.
4. Apply and **Save**.

## Config shape (what gets written)

```yaml
# views.view.my_tree
display:
  default:
    display_options:
      style:
        type: tree          # or tree_table
        options:
          main_field: nid
          parent_field: field_parent_target_id
          collapsible_tree: collapsed   # list style only
          # tree_table only:
          # display_hierarchy_column: title
```

## Read / set with drush

```bash
drush cget views.view.my_tree display.default.display_options.style.type
# tree

# switch an existing display to the tree style and set the fields:
drush cset views.view.my_tree display.default.display_options.style.type tree -y
drush cset views.view.my_tree display.default.display_options.style.options.main_field nid -y
drush cset views.view.my_tree display.default.display_options.style.options.parent_field field_parent_target_id -y
```

(Or load the `View` config entity in `drush php:eval` and set `display_options.style` on the
display, then `->save()`.)

## Config schema

The module ships `views.style.tree` and `views.style.tree_table` schema (in
`config/schema/views_tree.schema.yml`) extending `views.style.html_list` / `views.style.table`
with the `main_field`, `parent_field`, `collapsible_tree`, and `display_hierarchy_column` keys.
