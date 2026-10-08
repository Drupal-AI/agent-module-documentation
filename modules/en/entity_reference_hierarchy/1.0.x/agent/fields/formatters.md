<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "with hierarchy" formatters

Two formatters render the referenced entities as a **nested list** that follows the field's tree
outline. Both live under `src/Plugin/Field/FieldFormatter/` and share
`EntityReferenceHierarchyFormatterTrait`.

## Plugins

| Formatter id | Label | Extends | File |
|---|---|---|---|
| `entity_reference_hierarchy_entity_view` | *Rendered entity (with hierarchy)* | core `EntityReferenceEntityFormatter` | `EntityReferenceHierarchyEntityFormatter.php` |
| `entity_reference_hierarchy_label` | *Label (with hierarchy)* | core `EntityReferenceLabelFormatter` | `EntityReferenceHierarchyLabelFormatter.php` |

Both declare `field_types = { "entity_reference_hierarchy" }`. (The `field_formatter_info_alter`
hook additionally lets the plain core formatters target the field, but only these two nest.)

## Settings — `EntityReferenceHierarchyFormatterTrait`

- `defaultSettings()` adds `list_type => 'ol'` on top of the parent formatter's defaults.
- `settingsForm()` adds a `list_type` radios element with options `ol` (*Ordered List*) /
  `ul` (*Unordered List*). (Note: the label text is mis-worded as *"Link label to the referenced
  entity"* in source, but it controls the list type.)
- `settingsSummary()` appends the chosen list type to the parent summary.

## How the nesting is rendered

`viewElements()`:

1. Calls `parent::viewElements()` to get the flat per-delta render array (rendered entity or
   label, honouring core reference access).
2. Calls `$items->getFieldHierarchyOutline()` (see [../api/tree-outline.md](../api/tree-outline.md))
   to get the delta-keyed parent/children outline.
3. `getNestedListItemElements()` walks that outline, and for each branch places the delta's
   rendered element, recursing into `$branch['children']` as a nested `#items` list.
4. `viewNestedElements()` wraps the whole thing in a single
   `#theme => 'item_list'` render array with `#list_type` = the configured `ol`/`ul`.

So the output is one `<ol>`/`<ul>` with `<li>` items nested to match the depth structure. There
is no custom Twig template — it reuses core's `item_list` theme, and the leaf content is whatever
the parent formatter produced (full rendered entity, or an escaped label link).

## Choosing a formatter (config)

Set it on *Manage display*, or via config, e.g.:

```bash
drush cset core.entity_view_display.node.page.default \
  content.field_tree.type entity_reference_hierarchy_entity_view -y
drush cr
```

For the revisions field type, use the equivalent
`entity_reference_hierarchy_revisions_entity_view` formatter from the revisions submodule.
