<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Availability service, Twig function, and Views field

Source: `src/NodeAvailabilityService.php`, `src/Plugin/views/field/NodeAvailability.php`,
`date_range_availability.services.yml`, `date_range_availability.module`.

## Install / enable

`drush en date_range_availability -y`. Requires core `datetime_range` and `views` (declared in
`date_range_availability.info.yml`). Add a **datetime_range** field to your content type (a range,
i.e. with an end date) — its machine name (e.g. `field_date`) is the one input everything below
needs. There is no settings route and no permission to grant.

## The service

- Service id: `date_range_availability.node_availability_service`
  (class `Drupal\date_range_availability\NodeAvailabilityService`, arg `@datetime.time`).
- Tagged `twig.extension`; extends `Twig\Extension\AbstractExtension`. `getFunctions()` registers
  one Twig function: **`node_availability`** → `getNodeAvailability()`.

### `getNodeAvailability($node, $field_date): array`

Returns `['label' => <TranslatableMarkup|string>, 'label_class' => <string>]`.

Logic (verbatim from source):

1. Read `$node->get($field_date)->value` (start) and `->end_value` (end); each is run through
   `strtotime()`, or `0` when empty.
2. If the node is missing or **not published** → returns `Unavailable` / `unavailable-label`
   immediately.
3. `current = \Drupal::service('datetime.time')->getCurrentTime()`. **Only when the end value is
   non-zero:**
   - `current < start` → `Coming Soon` / `soon-label`
   - `start < current < end` → `Available` / `available-label`
   - `current > end` → `Unavailable` / `unavailable-label`
4. If the end value is `0` (start-only or empty field) none of the branches fire and the label is
   an **empty string** with an empty class.

Boundary note: the comparisons use strict `<` / `>`, so the exact start or end second falls into
no branch (empty label). Dates are parsed with `strtotime()` on the field's stored string value.

## Twig usage

The node object must be in scope (node template, or a paragraph/block template that has it):

```twig
{% set state = node_availability(node, 'field_date') %}
<div class="availability {{ state.label_class }}">{{ state.label }}</div>
```

`node` is the entity object (not an id). Style `.soon-label`, `.available-label`,
`.unavailable-label` in your theme — the module ships no CSS.

## Views field

- Registered globally by `hook_views_data_alter()` (`date_range_availability.module`): adds
  `views.node_availability` with field id `node_availability`, under group
  **"Custom Global - Node Availability"**, title **"Node Availability"** / label "Availability".
- Plugin `NodeAvailability` (`@ViewsField("node_availability")`, extends `FieldPluginBase`):
  - `query()` — intentionally empty (no query alteration).
  - `defineOptions()` — adds option `field_date` (default `''`).
  - `buildOptionsForm()` — a **required** textfield "Machine name of the date range field"
    (e.g. `field_date`).
  - `render(ResultRow $values)` — `getEntity($values)` → service → returns the `label`.

To use: edit a View whose base is (or exposes) the node entity → **Add** field → search the
"Custom Global - Node Availability" group → add **Node Availability / Availability** → set the
date field's machine name in the field settings. The state renders per row.

## Constraints & gotchas

- Because `render()` uses `getEntity($values)`, the View must expose the entity for that row
  (a node-based View, or one where the row's entity is a node with the named field). If the named
  field does not exist on the entity, `$node->get($field_date)` will error — enter a real machine
  name.
- Requires an **end value** to produce any state; ranges configured end-optional will show blank.
- No caching metadata is added by the field; the computed label is time-dependent, so on a cached
  render it reflects the time of render, not of view. For time-accurate output, ensure the
  rendering context is not statically cached past a state transition.
