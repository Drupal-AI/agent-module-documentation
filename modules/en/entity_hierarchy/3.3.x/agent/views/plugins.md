# Views integration

`hook_views_data()` (in `entity_hierarchy.views.inc`) exposes each hierarchy field's
nested-set table `nested_set_<field>_<entity_type>` to Views, joined to the entity base
table. It adds a **`left_pos`** sort ("Hierarchy order") and these plugins.

## Arguments (contextual filters)

Given an entity id argument, filter the view relative to that entity in the tree:

| Argument id | Selects | Setting |
|---|---|---|
| `entity_hierarchy_argument_is_child_of_entity` | descendants of the argument entity | `depth` (integer, limit levels) |
| `entity_hierarchy_argument_is_parent_of_entity` | ancestors of the argument entity | `depth` |
| `entity_hierarchy_argument_is_sibling_of_entity` | siblings of the argument entity | `show_self` (boolean) |

Each has a `*_revision` variant (`..._is_child_of_entity_revision`, etc.) used automatically
for revisionable entity types (keys on revision id instead of entity id).

`depth` limits how many levels of children/parents are returned (e.g. `1` = direct children
only). `show_self` includes or excludes the argument entity from the sibling list.

## Relationship

- `entity_hierarchy_root` — relate each row to its **root ancestor** entity, so you can
  group/section content by the top of its tree.

## Field

- `entity_hierarchy_tree_summary` — a children-summary field; setting `summary_type` controls
  how the count/summary of an entity's children is displayed.

## Typical recipe

"Child pages of the current page": a page/section View with a contextual filter using
`entity_hierarchy_argument_is_child_of_entity` (depth `1` for direct children), argument
provided from the URL, sorted by the field's **Hierarchy order** (`left_pos`).
