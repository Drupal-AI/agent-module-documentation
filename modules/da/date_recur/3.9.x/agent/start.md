<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# date_recur — agent index

Field type `date_recur`: a `datetime_range` field plus an RFC 5545 **RRULE**, a timezone,
and a derived `infinite` flag. On save, each item's rule is expanded into a per-field
**occurrence table** for querying/Views. Default widget `date_recur_basic_widget`, default
formatter `date_recur_basic_formatter`. Human-readable text comes from **interpreter**
plugins configured as `date_recur_interpreter` config entities.

- **Add / configure the field** (parts grid, frequencies, precreate, formatter, interpreters,
  Drush) → [configure/field-settings.md](configure/field-settings.md)
- **Interpreter plugin type** (write one, the shipped `rl` plugin, config entities) →
  [plugins/interpreters.md](plugins/interpreters.md)
- **Programmatic API** (`DateRecurHelper`, field item accessors, events) →
  [api/helper.md](api/helper.md)

Facts: config UI route `entity.date_recur_interpreter.collection`
(/admin/config/regional/recurring-date-interpreters); permission `date_recur manage
interpreters`; interpreter manager service `plugin.manager.date_recur_interpreter`; helper
service class `Drupal\date_recur\DateRecurHelper`. No Drush commands. Submodule
`date_recur_subfield` (a subclassed field type) is documented separately.
