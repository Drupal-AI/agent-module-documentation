<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Timestamp to Date (views_timestamp_to_date) — agent index

Adds one **Global Views field** ("Global: Timestamp to Date") that reads another field's raw
**Unix timestamp** value and renders it as a **formatted date** string. It is display-only — it
runs no query of its own and does not change storage. Intended for views over raw DB tables (e.g.
Views Database Connector) where an integer timestamp column would otherwise render as a number.

- Dependency: `drupal:views` only. Core: `^8.8 || ^9 || ^10 || ^11`.
- No settings page (`configure` is null) — you configure it per-field inside the Views UI.
- No permissions, no drush commands, does not define a plugin type. Ships `config/schema` only.

Solution docs:
- **Add/format the "Timestamp to Date" field in a view** → [views/timestamp_to_date_field.md](views/timestamp_to_date_field.md)

Key facts (real machine names):
- Views data: `hook_views_data()` in `views_timestamp_to_date.module` registers table `views_timestamp_to_date` (group `Global`, `#global` join → available in every view) with field `field_views_timestamp_to_date` (title "Timestamp to Date").
- Field plugin: `Drupal\views_timestamp_to_date\Plugin\views\field\TimestampToDate`, annotation `@ViewsField("field_views_timestamp_to_date")`, **extends** core `Drupal\views\Plugin\views\field\Date`.
- Option added by this module: `timestamp_field` (which sibling field in the display holds the timestamp). All date-format options (`date_format`, `custom_date_format`, `timezone`) are inherited from the core Date handler.
- Config schema: `views.field.views_timestamp_to_date` (type `views_field`) maps `timestamp_field: string`.
- Services injected: `date.formatter`, `entity_type.manager`→`date_format` storage, `datetime.time`.
