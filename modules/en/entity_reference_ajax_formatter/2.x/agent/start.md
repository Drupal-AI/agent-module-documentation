<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Ajax Formatter (entity_reference_ajax_formatter) — agent index

A single **field formatter** that renders the referenced entities of an entity-reference field in a
chosen view mode, with an optional AJAX **"Load More"** link that fetches and swaps in the next
batch. Package `Fields`. Core requirement `^8 || ^9 || ^10 || ^11`. No dependencies beyond core.
License GPL-2.0-or-later. Doc version `2.x` (installed 2.0.2).

- **The formatter, every setting, sort modes, how to enable it** →
  [fields/formatter.md](fields/formatter.md)
- **The AJAX Load-More route + controller (how the next batch is produced)** →
  [api/ajax-endpoint.md](api/ajax-endpoint.md)

## What it actually is

- One plugin: `EntityReferenceAjaxFormatter` (id **`entity_reference_ajax_entity_view`**, label
  *"Rendered Entity Ajax Formatter"*), in
  `src/Plugin/Field/FieldFormatter/EntityReferenceAjaxFormatter.php`, **extending core's
  `EntityReferenceEntityFormatter`**. `field_types = { "entity_reference",
  "entity_reference_revisions" }`.
- One controller: `EntityReferenceAjaxController` in `src/Controller/`, reached by the single route
  **`entity_reference_ajax_formatter.ajax_field`** (`entity_reference_ajax_formatter.routing.yml`).
- Config schema for the formatter settings only:
  `config/schema/entity_reference_ajax_formatter.schema.yml`
  (`field.formatter.settings.entity_reference_ajax_entity_view`).
- **No** field type, **no** widget, **no** permissions of its own, **no** Drush, **no** hooks,
  **no** config/install, **no** submodules.

## Mechanism (from source)

- `viewElements()` gets the referenced entities via the parent's `getEntitiesToView()` (so core
  referenced-entity view access is honoured), optionally re-orders them for display (`sort`),
  slices to `number` starting at the current-route `start` offset, and renders each with the
  entity view builder in the configured view mode. When `load_more` is on and more items remain
  (and `max` is not reached), it appends a `use-ajax` `#type => 'link'` pointing at the ajax route
  with the next `start`/`printed`, wrapped in a container whose `id` is
  `ajax-field-{entity_type}-{entity_id}-{field_name}`, and attaches `core/drupal.ajax`.
- The controller's `viewField()` renders `$entity->getTranslation($language)->get($field_name)->view($view_mode)`
  into an `AjaxResponse` with a `ReplaceCommand` targeting that same container id.

## Settings (`defaultSettings()`)

`number` (6), `sort` (0 = field order; 1 random; 2/3 changed asc/desc; 4/5 created asc/desc),
`load_more` (FALSE), `max` (0 = unlimited) — plus everything inherited from the core rendered-entity
formatter (`view_mode`, `link`). Details, sort semantics, the max validator, and a config-export
example are in [fields/formatter.md](fields/formatter.md).
