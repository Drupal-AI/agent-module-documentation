<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Date Recur adds a `date_recur` field type that stores a start/end datetime plus an RFC 5545 (iCalendar) RRULE, so a single field value expands into a series of recurring occurrences.

---

Date Recur extends core's `datetime_range` field with an `rrule` column (the repeat rule), a `timezone`, and a derived `infinite` flag, backed by the `rlanvin/php-rrule` library. On save it expands each item's rule into concrete occurrences and writes them to a per-field occurrence table (`{entity}__{field}_occurrence`) so occurrences can be queried, filtered, and displayed in Views. Editors enter the rule with the "Simple Recurring Date" widget (start/end date plus a raw RRULE textarea); the "Date recur basic" formatter shows the next N occurrences and a human-readable interpretation. Which RRULE frequencies (DAILY, WEEKLY, MONTHLY, YEARLY, …) and parts (INTERVAL, BYDAY, COUNT, UNTIL, …) an editor may use is constrained per field through the field settings "parts" grid, and validated by the `DateRecurRrule` / `DateRecurRuleParts` constraints. Human-readable text is produced by pluggable **interpreter** plugins (`date_recur_interpreter`), configured as `date_recur_interpreter` config entities at Admin › Configuration › Regional › Recurring date interpreters; the module ships one RL interpreter (`rl`) and an optional `default_interpreter`. Three events (`FIELD_VALUE_SAVE`, `FIELD_ENTITY_DELETE`, `FIELD_REVISION_DELETE`) let other code react to occurrence writes. Programmatic access to a rule is via the `DateRecurHelper` value object (`getOccurrences()`, `generateOccurrences()`, `isInfinite()`, `getRules()`, `getExcluded()`).

---

- Store an event's schedule as a recurring datetime field on a Content type instead of one node per occurrence.
- Model "every Tuesday and Thursday at 18:00" or "the first Monday of each month" with a single RRULE value.
- Build a calendar/agenda listing by exposing generated occurrences to Views via the occurrence table.
- Restrict editors to only weekly recurrences (hide DAILY/HOURLY/YEARLY) using the field settings parts grid.
- Allow only simple repeats by enabling just the INTERVAL and COUNT parts for a frequency.
- Limit how far infinite rules are pre-generated into the occurrence cache with the "precreate" interval setting.
- Cap the stored RRULE string length with the storage-level `rrule_max_length` setting.
- Show "the next 5 occurrences" of a repeating event with the Date recur basic formatter.
- Display a plain-English summary ("Weekly on Monday, until 31 December") via an interpreter plugin.
- Localize recurrence descriptions by configuring an interpreter per language.
- Provide a default RRULE and default timezone for a field so new content starts from a template.
- Compute the concrete occurrences of a rule in custom code with `DateRecurHelper::getOccurrences()`.
- Iterate an infinite rule lazily with `generateOccurrences()` (a Generator) without exhausting memory.
- Detect whether a stored rule is infinite (`isInfinite()`) before rendering or querying it.
- React to occurrence writes by subscribing to the `date_recur_field_value_save` event (e.g. sync to an external calendar).
- Clean up related data when an entity or revision with a recur field is deleted, via the delete events.
- Filter Views results by occurrence date using the `date_recur_occurrences_filter` Views filter.
- Add a Views field that renders occurrence dates with `date_recur_date`.
- Handle timezone-correct recurrence (rules stored with an explicit timezone column) for DST-safe repeats.
- Support EXDATE / excluded occurrences and read them back with `getExcluded()`.
- Write a custom interpreter plugin to phrase recurrences in a house style or an unsupported language.
- Enforce, per field, that only RFC-5545-compatible frequency/part combinations are saved.
- Subclass the field type to add extra stored columns (see the `date_recur_subfield` submodule adding a `color`).
- Precompute occurrences for reporting/export by reading the per-field occurrence table.
- Offer a "repeats" toggle on a booking or class-schedule content type.
