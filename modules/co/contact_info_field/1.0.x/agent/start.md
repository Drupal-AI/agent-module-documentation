<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact info field — agent index

info.yml name **"Contact info field"** (`contact_info_field`), version **1.0.0**.
A single custom **Field API field type** that stores one or more contact entries — name, position/role,
email, phone, URL, notes, and an optional reference to a Drupal user — in one multi-value field. It ships
one widget and three formatters. Core `^8 || ^9 || ^10 || ^11`, package Custom, one dependency: core `field`.
No `.module`, `.install`, routing, services, hooks, permissions, templates, JS, or libraries — it is
entirely Field plugin classes plus a widget config schema. Maintainer: maxwellkeeble.

Purpose: attach structured "who to contact" data to any fieldable entity (content type, taxonomy term, etc.)
instead of free text. Which of the seven sub-elements are collected (widget) and displayed (formatter) is
configurable per field.

## Field type — `ContactInfoField` (`src/Plugin/Field/FieldType/ContactInfoField.php`)

- `@FieldType id = "contact_info_field"`, label "Contact info", `default_widget`/`default_formatter =
  contact_info_field`. (The class docblock text says "dice"/"Collects name, email and phone." — leftover
  from a scaffold; the machine name is `contact_info_field`.)
- `schema()` columns: `name` varchar(255), `email` varchar(`Email::EMAIL_MAX_LENGTH` = 254), `url`
  varchar(255), `phone` varchar(50), `notes` blob(big), `position` varchar(255), `uid` int unsigned
  default 0.
- `propertyDefinitions()`: `name` string, `email` email, `url` uri, `phone` string, `notes` string,
  `uid` integer, `position` string — all optional.
- `isEmpty()` returns true only when **`name`** is empty (an entry with just an email/phone but no name
  is treated as empty and dropped on save).

## Widget — `ContactInfoFieldWidget` (`.../FieldWidget/ContactInfoFieldWidget.php`)

- `@FieldWidget id = "contact_info_field"`, label "Contact info widget".
- Const `elements` maps the 7 sub-fields to render elements: `name` textfield, `position` textfield,
  `email` email, `phone` textfield, `url` uri, `notes` textarea, `uid` `entity_autocomplete`
  (`#target_type = user`, `include_anonymous = FALSE`).
- Per-element `#show_by_default`: **name, email, phone = TRUE**; position, url, notes, uid = FALSE.
- `defaultSettings()` / `settingsForm()` / `settingsSummary()`: one `show_<id>` checkbox per sub-element;
  `formElement()` renders only the enabled sub-elements, seeding each `#default_value` from the stored
  item. When field cardinality is 1 the item is wrapped in a `fieldset` with class `container-inline`.

## Formatters (all use `ContactInfoFormatterTrait`)

`ContactInfoFormatterTrait::getItemValues($item)` builds the labeled display array used by every
formatter: `Name`, `Position`, `E-mail` (rendered as a `<a href="mailto:…">` link), `Phone`,
`User account` (the referenced user's `toLink()` when `uid` set), `Link` (the `url` rendered as an
`<a href="…">` link), `Notes`.

1. **`ContactInfoFieldFormatter`** — `@FieldFormatter id = "contact_info_field"`, "One contact per line".
   Setting `seperator` (default `•`). Per item: `array_filter()` the values and `implode()` them with the
   separator into `#markup`.
2. **`ContactInfoTableFieldFormatter`** — id `contact_info_field_table`, "Table of contacts". Renders a
   `#type => table`, one row per item, and drops columns that are empty across all rows. No settings.
3. **`ContactInfoSingleValueFormatter`** — id `contact_info_single_field`, "Single field value of a
   specific contact". Setting `field` (select: Name/Position/E-mail/Phone/User account/Link/Notes);
   outputs only that one value per item.

## Config

`config/schema/contact_info_field.schema.yml` defines `field.widget.settings.contact_info_field` (the
`show_name`, `show_position`, `show_email`, `show_phone`, `show_url`, `show_notes`, `show_uid` booleans).
No formatter-settings schema is shipped. No default config, no permissions, no install hooks.

## Setup

Enable, then use core Field UI: add a **Contact Info** field to an entity, choose the enabled sub-elements
in Manage form display, and pick one of the three formatters in Manage display. See
[usage.md](../usage.md) and [human-docs](../human-docs/index.md).
