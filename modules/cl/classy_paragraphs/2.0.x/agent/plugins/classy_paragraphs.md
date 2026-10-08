# classy_paragraphs — EntityReferenceSelection plugin

The module ships **one plugin**: an EntityReferenceSelection handler that controls which
styles a reference field offers and in what order. It is optional — a field can use core's
`default:classy_paragraphs_style` handler instead.

- Plugin id: `classy_paragraphs`
- Class: `Drupal\classy_paragraphs\Plugin\EntityReferenceSelection\ClassyParagraphsSelection`
  (extends core `DefaultSelection`)
- Annotation: `entity_types = {"classy_paragraphs_style"}`, `group = "classy_paragraphs"`, `weight = 5`.

The module does **not** define any plugin *type* of its own; it only implements this core
plugin type. To use it, set the field instance's `settings.handler` to `classy_paragraphs`.

## Configuration form options it adds

- **Filter by** (`filter.type`):
  - `_none` — offer all styles.
  - `target_bundles` — restrict to specific chosen styles (checkboxes in
    `filter.target_bundles`), with an optional **Negate filter** (`filter.negate`) to
    instead exclude them (lets newly added styles appear automatically).
  - `starts_with` — restrict to styles whose **machine name** starts with a given string
    (`filter.starts_with`), matched via a `STARTS_WITH` query condition.
- **Sort by** (`sort.field`): `_none`, `id` (machine name), or `label`, with a
  `sort.direction` of `ASC`/`DESC`.

Internally `buildEntityQuery()` applies these conditions, adds autocomplete matching on
`label`, and tags the query `classy`.

## When to use it

Use `classy_paragraphs` (instead of `default:classy_paragraphs_style`) when one field should
only expose a subset of the global style catalog (e.g. only `btn_*` styles) or needs a
specific option order, without hard-coding target IDs that must be updated as styles grow.
