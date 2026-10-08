<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks FullCalendar invites (`fullcalendar.api.php`)

Four hooks let other modules influence event CSS classes, drag-and-drop, and dates.

## `hook_fullcalendar_classes(EntityInterface $entity): array`

Return an array of CSS classes to add to the event element for `$entity`.

```php
function mymodule_fullcalendar_classes(\Drupal\Core\Entity\EntityInterface $entity): array {
  return [$entity->getEntityTypeId()];
}
```

## `hook_fullcalendar_classes_alter(array &$classes, EntityInterface $entity): void`

Alter the full list of classes gathered from all modules (e.g. remove or add some).

```php
function mymodule_fullcalendar_classes_alter(array &$classes, $entity): void {
  $classes = [];  // strip all module-set classes
}
```

## `hook_fullcalendar_droppable(): bool`

Merely *implementing* this hook makes a checkbox appear in the View settings; when checked,
FullCalendar looks for JS callbacks at
`Drupal.fullcalendar.droppableCallbacks.MODULENAME.callback`. The PHP body is never executed —
it is a declaration that your module provides a droppable JS callback.

## `hook_fullcalendar_process_dates_alter(string &$date1, string &$date2, array $context): void`

Alter the start/end date strings after loading, before rendering. `$context` has `entity` and
`fields`.

```php
function mymodule_fullcalendar_process_dates_alter(string &$date1, string &$date2, array $context): void {
  if ($date1 !== $date2) { $date2 = $date1; }  // force single-day display
}
```

## Related alter hook (not in api.php)

`hook_fullcalendar_type_info(array &$info)` — alter the discovered FullcalendarOption plugin
definitions (invoked by the plugin manager). See
[../plugins/fullcalendar-option.md](../plugins/fullcalendar-option.md).
