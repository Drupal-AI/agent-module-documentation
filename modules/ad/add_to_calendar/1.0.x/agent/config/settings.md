<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling the field & the settings form

## Install & enable

```bash
composer require drupal/add_to_calendar   # pulls in spatie/calendar-links ^1
drush en add_to_calendar -y
```

Depends on core **`datetime_range`** (auto-enabled). The formatter reads a **daterange** field, so
the entity/bundle you target must have one. Optionally install `drupal/fontawesome` (suggested) so
the template's `<i class="fa-solid fa-calendar">` label icon renders.

## Step 1 — turn the field on for an entity type

`SettingsForm` (`src/Form/SettingsForm.php`, form id `add_to_calendar_settings`) at route
**`add_to_calendar.settings`** → **`/admin/config/user-interface/add-to-calendar`**
(*Configuration → User interface → Add to calendar*).

- It lists every **content** entity type (`getGroup() === 'content'`) as checkboxes.
- Chosen ids are saved into config object **`add_to_calendar.settings`** key
  **`enabled_entity_types`** (a sequence of strings; install default `{}`).
- Route requirement: permission **`administer add_to_calendar configuration`**
  (`add_to_calendar.permissions.yml`, `restrict access: true`). `_admin_route: TRUE`.

`add_to_calendar_entity_base_field_info()` (in `add_to_calendar.module`) then adds a **computed**
base field `add_to_calendar` (`->setComputed(TRUE)`, class `AddToCalendarItemList`) to each
enabled entity type, displayable but hidden by default (`region => hidden`). Because it is
computed, nothing is written to storage.

Config / Drush equivalent:

```bash
drush cset add_to_calendar.settings enabled_entity_types.node node -y
drush cr   # rebuild so the base field appears
```

(The value is a keyed sequence like `{ node: node }`, matching the checkboxes render.)

## Step 2 — place & configure it on the display

The new **Add to calendar** field then appears under *Structure → (bundle) → Manage display*,
initially in the **Disabled** region. Drag it into a visible region and set format
**Add to calendar** — the per-display formatter settings are documented in
[../fields/formatter.md](../fields/formatter.md).

## Config schema

`config/schema/add_to_calendar.schema.yml` defines:

- `add_to_calendar.settings` (`config_object`) → `enabled_entity_types` sequence of `string`.
- `field.formatter.settings.add_to_calendar_default` (mapping) → `date_field`, `description_field`,
  `address_field` (strings) + `enabled_generators` (sequence of string).
- `field.value.add_to_calendar` → `value` (label) — the placeholder value mapping.

## What it does NOT expose

No additional routes, no REST/JSON endpoint, no `.ics` download controller, no Drush commands, no
services. The only privileged surface is the settings form, and it is gated by the dedicated
restrict-access permission above.
