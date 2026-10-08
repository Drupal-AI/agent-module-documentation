<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Date Recur Sub Field is a `Testing`-package example submodule of date_recur that defines a `date_recur_sub` field type by subclassing the main `date_recur` field, adding one extra stored `color` column.

---

The submodule exists to demonstrate (and test) how to extend the `date_recur` field type. Its `DateRecurSubItem` extends `DateRecurItem`, adding a `color` property/column (varchar 16) on top of all the recurring-date storage and behaviour it inherits. Two `hook_field_*_info_alter()` implementations in `date_recur_subfield.module` re-register every date_recur widget and formatter so they also accept the new `date_recur_sub` field type. Its config schema simply reuses the parent's value/storage/field-settings types. Because it ships in `tests/modules` and is package `Testing`, it is not intended for production use; it is the reference pattern for anyone building their own subclassed recurring-date field.

---

- Learn how to subclass the `date_recur` field type by reading `DateRecurSubItem`.
- Add extra stored columns (here a `color`) alongside the inherited recurrence data.
- See how `propertyDefinitions()` is extended to add a new typed-data property.
- See how `schema()` is extended to add a new database column to a field type.
- Reuse the `date_recur` widget for a custom field type via `hook_field_widget_info_alter()`.
- Reuse the `date_recur` formatters for a custom field type via `hook_field_formatter_info_alter()`.
- Reuse the parent's config schema by referencing `field.value.date_recur` etc. from a subclass schema.
- Provide a test fixture field type (`date_recur_sub`) for date_recur's own kernel/functional tests.
- Copy the pattern to attach domain metadata (category, calendar, resource id) to a recurring-date field.
- Attach a per-occurrence display colour to calendar events.
- Verify that occurrence generation still works on a subclassed field.
- Verify that the RRULE parts validation still applies to a subclassed field.
- Confirm inherited default widget/formatter assignment for a new field type.
- Understand what you must and must not re-declare when extending a field type plugin.
- Use as a scaffold for a production module that needs a specialised recurring-date field.
- Test that inherited storage settings (`rrule_max_length`, `datetime_type`) carry over.
- Test that inherited field settings (`precreate`, `parts`) carry over.
- Demonstrate that occurrence tables are created for subclassed field types too.
