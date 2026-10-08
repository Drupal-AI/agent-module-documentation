<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add to calendar (add_to_calendar) — agent index

A **computed field + field formatter** that renders "add to calendar" links (Google, iCalendar,
Office, Outlook, Yahoo) on any content entity, built from the entity's own date-range /
description / address fields via the `spatie/calendar-links` PHP library. No external service or
JS widget. Core requirement `^10.1 || ^11`. License GPL-2.0-or-later. Version 1.0.3.

Depends on core **`datetime_range`**. Composer requires **`spatie/calendar-links: ^1`** (a real
PHP dependency — `composer require drupal/add_to_calendar` pulls it in). Suggests
`drupal/fontawesome` for the label icon.

- **Enable per entity type + the settings form + config schema** →
  [config/settings.md](config/settings.md)
- **The formatter, its per-display settings, the computed field & field type, theming** →
  [fields/formatter.md](fields/formatter.md)

## What it actually provides (from source)

- **Field type** `add_to_calendar` (`src/Plugin/Field/FieldType/AddToCalendarItem.php`) — a simple
  `varchar(255)` `value` field; `default_formatter = "add_to_calendar_default"`.
- **Computed field / item list** `AddToCalendarItemList` (`src/AddToCalendarItemList.php`,
  `ComputedItemListTrait`) — `computeValue()` puts a single placeholder item ("Add to calendar")
  so **nothing is stored**.
- **Formatter** `AddToCalendarFormatter` (id **`add_to_calendar_default`**,
  `src/Plugin/Field/FieldFormatter/AddToCalendarFormatter.php`) — targets `field_types = {"add_to_calendar"}`.
- **Base field injection** — `add_to_calendar_entity_base_field_info()` in `add_to_calendar.module`
  adds the computed `add_to_calendar` base field to every entity type listed in
  `add_to_calendar.settings:enabled_entity_types`.
- **Settings form** `SettingsForm` (`src/Form/SettingsForm.php`) at route
  **`add_to_calendar.settings`** → `/admin/config/user-interface/add-to-calendar`
  (menu link `add_to_calendar.settings`, parent `system.admin_config_ui`).
- **Permission** `administer add_to_calendar configuration` (`restrict access: true`) gating that route.
- **Config object** `add_to_calendar.settings` (`enabled_entity_types` sequence) + formatter schema
  `field.formatter.settings.add_to_calendar_default`. Schema in `config/schema/add_to_calendar.schema.yml`.
- **Theme hook** `field__add_to_calendar` + template `templates/field--add-to-calendar.html.twig`;
  library `add_to_calendar/field` (`css/add_to_calendar.css`, `js/add_to_calendar.js` — a small
  touch-hover behavior).

No routes other than the settings form, no controllers, no `.ics` download endpoint (the ics link
is a self-contained data URI produced by the library), no Drush commands, no services file.
