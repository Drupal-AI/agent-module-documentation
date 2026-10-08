<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Programmatic API

## The field item

`Drupal\date_recur\Plugin\Field\FieldType\DateRecurItem` (extends `DateRangeItem`). Stored
columns / properties: `value`, `end_value` (ISO strings), `start_date`, `end_date`
(`DrupalDateTime`), `rrule` (string), `timezone` (string, required), `infinite` (bool, derived
on `preSave()` from the rule), and the computed `occurrences` list. Item methods:

- `getHelper(): DateRecurHelperInterface` — the rule helper for this item (throws if empty).
- `isRecurring(): bool` — whether the value has a repeating rule.
- `getPartGrid(): DateRecurPartGrid` — the allowed-parts grid from field settings (on the item
  list, `DateRecurFieldItemList::getPartGrid()`).

```php
$item = $node->get('field_when')->first();
if (!$item->isEmpty() && $item->isRecurring()) {
  $helper = $item->getHelper();
}
```

## DateRecurHelper — the rule value object

`Drupal\date_recur\DateRecurHelper` (interface `DateRecurHelperInterface`), backed by
`rlanvin/php-rrule`. Build one directly from an RRULE string and a start (and optional
start-end) date:

```php
use Drupal\date_recur\DateRecurHelper;
$helper = DateRecurHelper::create(
  "FREQ=WEEKLY;BYDAY=MO,WE;COUNT=10",
  new \DateTime('2025-01-06 18:00:00'),
  new \DateTime('2025-01-06 19:00:00'), // optional first-occurrence end
);
```

Methods:

- `getOccurrences(?$rangeStart = NULL, ?$rangeEnd = NULL, ?int $limit = NULL): array` —
  materialise occurrences (each a `Drupal\date_recur\DateRange` with `getStart()`/`getEnd()`).
  **Pass a `$limit` (or range) for infinite rules** or it will not terminate.
- `generateOccurrences(?$rangeStart, ?$rangeEnd): \Generator` — lazy iteration, memory-safe for
  infinite rules.
- `isInfinite(): bool` — true when the rule has no COUNT/UNTIL bound.
- `getRules(): array` — the parsed `DateRecurRuleInterface` rules.
- `getExcluded(): array` — EXDATE excluded dates.
- The helper is itself an `Iterator` (`current()`/`next()`/`valid()`/`rewind()`).

```php
foreach ($helper->getOccurrences(NULL, NULL, 5) as $occurrence) {
  printf("%s → %s\n", $occurrence->getStart()->format('c'), $occurrence->getEnd()->format('c'));
}
```

## Occurrence storage

On entity save, `Drupal\date_recur\DateRecurOccurrences` (service `date_recur.occurrences`, an
event subscriber) writes each item's expanded occurrences to a per-field table named
`{entity_type}__{field_name}` + `_occurrence` (e.g. `node__field_when_occurrence`), which the
Views field/filter read.

## Events

`Drupal\date_recur\Event\DateRecurEvents` constants (dispatch a
`Drupal\date_recur\Event\DateRecurValueEvent` carrying `getField()` and `isInsert()`):

- `FIELD_VALUE_SAVE` (`date_recur_field_value_save`) — after an entity with a recur field saves.
- `FIELD_ENTITY_DELETE` (`date_recur_field_entity_delete`) — entity about to be deleted.
- `FIELD_REVISION_DELETE` (`date_recur_field_entity_revision_delete`) — revision deleted.

Subscribe with a normal tagged `event_subscriber` service:

```php
public static function getSubscribedEvents(): array {
  return [\Drupal\date_recur\Event\DateRecurEvents::FIELD_VALUE_SAVE => 'onSave'];
}
public function onSave(\Drupal\date_recur\Event\DateRecurValueEvent $event): void {
  $field = $event->getField(); // DateRecurFieldItemList
}
```

## Interpreting to text

To render a rule as a sentence, load a `date_recur_interpreter` config entity and call its
plugin — see [../plugins/interpreters.md](../plugins/interpreters.md).
