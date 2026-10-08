<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The vertical calendar: cells, state writes, access

## Opening the calendar

`/admin/beehotel/vertical` (`Controller\Vertical::page`). Access is the static
`Vertical::checkAccess()` — allowed if the account has **`access_vertical_basic`** or
**`access_vertical_full`**. The table is built by `TableBuilder` from `RowGenerator` +
`HeaderGenerator`, cells by `CellContentBuilder`/`CellRenderer`. Rows = units
(`BeeHotelUnit`), columns = days; each cell is a flip-card ("AV"/"NO").

## Cell state model

Availability is a BAT `availability_daily` event with `event_state_reference` (1 = available,
2 = not available) and `event_bat_unit_reference` (the unit's bid). `Event::getNightState()`
reads the current state from `bat_event_availability_daily_day_state`.

## AJAX write paths (`Service\AjaxHandlers`)

- **Toggle** — `toggleStateCard($nojs, $cardId)`: parses `cardId = card-{bid}-{year}-{month}-{day}`,
  flips state via `toggleState()`, then `saveEvent()` creates an `availability_daily` bat_event
  with the new state for that unit/date, and refreshes the card HTML.
- **Save** — `saveAvailabilityState($nojs, $cardId)`: deletes existing events for the day/unit and
  creates a new one with the posted `state`. Route requires `access_vertical_full` /
  `access_vertical_basic`.
- **Edit modal** — `openEditModal()` renders `Form\BeeHotelVerticalEditEvent` in a dialog.

## Settings

`Form\BeeeHotelVerticalSettingsForm` at `/admin/beehotel/vertical/settings`
(perm `administer vertical settings`) controls the calendar display.
