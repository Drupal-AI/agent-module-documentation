<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel VertiCal (beehotel_vertical) — agent index

A **vertical availability calendar** (units × days) for daily hotel management. Dependency:
`bee_hotel`. Core `^9.4 || ^10 || ^11`. Provides permissions via
`BeehotelVerticalPermissions::permissions`. Uses `plugin.manager.beehotel.pricealterator` for
season context.

## Routes (`.routing.yml`)

- `beehotel_vertical.vertical` — `/admin/beehotel/vertical` → `Controller\Vertical::page`,
  custom access `Vertical::checkAccess` (needs `access_vertical_basic` OR `access_vertical_full`).
- `beehotel_vertical.admin_settings` — `/admin/beehotel/vertical/settings` →
  `Form\BeeeHotelVerticalSettingsForm`, perm `administer vertical settings`.
- `beehotel_vertical.event_form` — `/admin/beehotel/vertical/event-form/{nojs}` →
  `Form\EventForm`, perm `administer vertical settings`.
- `beehotel_vertical.ajax_link_callback` — `/beehotel-vertical/ajax/status/{nojs}/{card_id}`
  → `Vertical::ajaxLinkCallback` (toggle a night's state).
- `beehotel_vertical.ajax_availability_save` — `/beehotel-vertical/ajax/availability-save/{nojs}/{card_id}`
  → `Vertical::ajaxAvailabilitySave`, perm `access_vertical_full+access_vertical_basic`.

## Permissions (`BeehotelVerticalPermissions`)

`view beehotel_vertical all`, `administer vertical settings`, `access_vertical_basic`,
`access_vertical_full`, plus per-node-bundle `view unit vertical … nodes` (marked SUSP).

## Services

Refactored builder stack: `table_builder`, `row_generator`, `header_generator`,
`cell_content_builder`, `cell_renderer`, `cell_attributes_builder`, `state_manager`,
`order_item_builder`, `order_data_resolver`, `season_resolver`, `field_value_extractor`,
`card_service`, `ajax_handlers`, and controller service `controller.vertical`. State writes go
through `AjaxHandlers` → `bat_event_create('availability_daily')`.

## Solution docs

- The calendar, its cells, AJAX state writes and permissions →
  [config/calendar.md](config/calendar.md)
