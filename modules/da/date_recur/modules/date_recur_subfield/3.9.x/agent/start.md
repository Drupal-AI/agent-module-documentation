<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# date_recur_subfield — agent index

Testing-package **example** submodule of [date_recur](../../../../3.9.x/agent/start.md). It
defines field type `date_recur_sub` by subclassing `DateRecurItem`, adding one extra stored
`color` column, and re-registers the parent's widgets/formatters for it. Not for production —
it is the reference pattern for extending the recurring-date field.

- **How the field type is subclassed** (extra column, info_alter hooks, schema reuse) →
  [api/subclass.md](api/subclass.md)

Facts: field type id `date_recur_sub`
(`Drupal\date_recur_subfield\Plugin\Field\FieldType\DateRecurSubItem`); default widget
`date_recur_basic_widget`, default formatter `date_recur_basic_formatter` (inherited);
depends on `date_recur`; no config UI, permissions, or Drush. All recurrence behaviour is
inherited from the parent — see the parent docs for the field/API surface.
