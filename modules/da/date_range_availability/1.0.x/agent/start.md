<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Range Availability (date_range_availability) — agent index

Computes an availability **state** (Coming Soon / Available / Unavailable) for a node by comparing
the current time against the **start and end values of a datetime_range field**, and exposes it as
a **Twig function** and a **Views field**. Package `Custom`. Depends on `datetime_range` and
`views`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1. No config UI, no
permissions, no schema, no Drush.

- **The service, the Twig function, and the Views field handler — how to enable and use each** →
  [api/availability.md](api/availability.md)

## What it actually is

- One service: `date_range_availability.node_availability_service` →
  `Drupal\date_range_availability\NodeAvailabilityService` (`src/NodeAvailabilityService.php`),
  constructed with `@datetime.time`. It is also tagged `twig.extension` (it extends
  `Twig\Extension\AbstractExtension`) and registers the Twig function **`node_availability`**.
- One Views field plugin: `NodeAvailability` (id **`node_availability`**,
  `src/Plugin/views/field/NodeAvailability.php`, extends `FieldPluginBase`). Registered as a
  *global* field via `hook_views_data_alter()` in `date_range_availability.module` under the group
  **"Custom Global - Node Availability"**.
- No routes, no forms, no config objects, no entities, no install/schema files, no CSS/JS assets.

## Mechanism (from source)

- `NodeAvailabilityService::getNodeAvailability($node, $field_date)`:
  - Reads `$node->get($field_date)->value` and `->end_value`, converting each with `strtotime()`
    (0 when empty).
  - If `!$node || !$node->isPublished()` → returns `{ label: t('Unavailable'), label_class:
    'unavailable-label' }` early.
  - Otherwise, using `$this->time->getCurrentTime()` and **only when `end_value` is set** (`$expire_date != 0`):
    before start → `Coming Soon` / `soon-label`; between start and end → `Available` /
    `available-label`; after end → `Unavailable` / `unavailable-label`.
  - Returns `{ label, label_class }`. Labels are `t()` strings.
- `NodeAvailability` Views field: `query()` is a no-op; `defineOptions()` adds a `field_date`
  option; `buildOptionsForm()` renders a required textfield for the date field machine name;
  `render(ResultRow $values)` calls `getEntity($values)`, passes it to the service, and returns
  `['label']`.

## Notes / caveats

- A **start-only** range (no `end_value`) never matches any branch → empty label. An end value is
  required for a non-empty state.
- The service parameter is documented as "the node" but is used as an entity object
  (`$node->get(...)`, `->isPublished()`); pass the entity, not an id, despite the README's older
  `node.id()` example — the shipped README's second example (`node`) is correct.
- Ships **no CSS**; the `*-label` classes are style hooks you must define in your theme.

Details, exact settings, and a Twig/Views example → [api/availability.md](api/availability.md).
