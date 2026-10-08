# Field API, status & Views

## Field value API
The field item list (`OfficeHoursItemListInterface`, `OfficeHoursItemList`) exposes:
```php
$items = $entity->get('field_office_hours');
$items->isOpen($time = 0);          // bool — open at $time (0 = now)
$items->getStatus($time = 0);       // int  — see status constants below
$items->getCurrentSlot($time = 0);  // ?OfficeHoursItem
$items->getNextDay($time = 0);      // array — next opening day/slot
$items->getRows($settings, $field_settings, $tp_settings, $time, $plugin);
$items->getSeasons(...);            // seasonal hours
$items->getExceptionItems();        // OfficeHoursItemListInterface
$items->getSeasonItems($season_id);
$items->countExceptionDays();
```

## Status constants
`OfficeHoursStatus`: `CLOSED = 0`, `OPEN = 1`, `NEVER = 2`
(`getPossibleValues()`, `getSettableOptions()`, etc.).

## Live status refresh (AJAX)
The status formatter can update without a full reload via route
`office_hours.status_update`:
`/office_hours/status_update/{entity_type}/{entity_id}/{field_name}/{langcode}/{view_mode}`
(`StatusUpdateController::updateStatus`, permission `access content`). JS library
`office_hours/office_hours_formatter_status_update`.

## Views integration (`src/Plugin/views`)
Fields: `TimeSlot`, `Season`, `Status`; filter: `OfficeHoursStatusFilter` (list/filter entities
by open/closed). `ViewsDataProvider` wires the field into Views data.
