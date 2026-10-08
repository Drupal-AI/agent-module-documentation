# How Bricks turns a flat field into a nested tree

All logic is in `src/Bricks.php` (static helpers) plus a few hooks in `bricks.module`. Useful when
writing custom formatters/widgets or debugging output.

## Depth model & correction

- Each `bricks` field item carries a `depth` (via `BricksFieldItemInterface::getDepth()/setDepth()`).
- `Bricks::correctDepths(\Traversable $items)` normalises depths so each child is exactly one deeper than
  its parent (a stack walk). Called from `bricks_entity_presave()` for any entity whose field items are
  `BricksFieldItemInterface`, so stored depths are always well-formed.
- A NULL depth is treated as 0; if encountered on a non-new entity, a shutdown re-save is registered.

## Nesting the render array

`bricks_preprocess_field()` fires for any formatter id starting with `bricks_` and replaces the items
with `[ ['content' => Bricks::nestItems($rendered_items, $field_items)] ]`.

`Bricks::nestItems($render_elements, $all_items)`:
1. `newElements()` pairs each rendered element with its source field item (see "item matching" below),
   drops elements whose parent was access-denied, and enriches each with `#label`, `#bricks_parent_key`,
   `#attributes` (classes `brick`, `brick--type--<bundle>`, `brick--id--<id>`), a `bricks_children`
   array, and per-item `options` (`#view_mode`, `#layout`, css class/id) via `newElement()`.
2. Walking bottom-up, each non-root element is `array_unshift`ed into its parent's `bricks_children`.
3. If an element is a `layout` (option `layout`) and `layout_discovery` is enabled, its children are
   distributed into the layout's regions by `layoutFromItems()` (single default region -> all children;
   otherwise regions are filled in order) and the element is replaced with the built layout render array
   (keeping `#label`, `#attributes`, `#paragraph`, `#parent_paragraph`).

## Item matching & access

- Parents are computed from the field items (not the render list) in `parentItems()`, using the corrected
  depths, so access-denied entities don't break the tree.
- `getAllowedItems()` collects items whose referenced entity passes `access('view')` (translation-aware).
  If the render list length matches and is a list, elements map 1:1; otherwise `nestItems` falls back to
  `fieldItem()` which fishes the entity out of the render array (`#<theme>` key or a sole
  `EntityInterface` property) and reads its `_referringItem`.
- Access-denied elements — and everything under them — are removed from output.

## Integrations

- **Entity Usage**: `src/Plugin/EntityUsage/Track/BricksField.php` (`@EntityUsageTrack id = "bricks_field"`)
  extends the core entity-reference tracker for `bricks` fields.
- **Replicate**: `BricksServiceProvider::alter()` registers `ReplicateFieldSubscriber` (extends the
  Paragraphs one, for `bricks_revisioned`) only when the `replicate` module is installed.
- **Powered-by block**: `bricks_preprocess_block__system_powered_by_block()` appends a "Bricks" link.

## No invited hooks

Bricks ships no `*.api.php`; it implements core hooks (`hook_field_widget_info_alter`,
`hook_field_widget_*_form_alter`, `hook_entity_presave`, preprocess hooks) rather than inviting its own.
Extend behaviour by implementing the same core hooks or subclassing the field plugins.
