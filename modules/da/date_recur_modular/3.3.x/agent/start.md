<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Recur Modular — agent index

Ships alternative **field widgets** for the `date_recur` field type (from the
Recurring Dates Field module). No admin config UI of its own — you configure it by
choosing one of its widgets on an entity **form display**. Requires `date_recur`.

Widgets provided (all `field_types = {date_recur}` only):
- `date_recur_modular_alpha` — "Modular: Alpha" (states+CSS; non-recurring/weekly/monthly)
- `date_recur_modular_oscar` — "Modular: Oscar" (opening-hours; single-day range + all-day toggle)
- `date_recur_modular_sierra` — "Modular: Sierra" (AJAX/modal, Google-Calendar-style; uses an interpreter)

Docs:
- [Configure a field to use a modular widget](configure/date_recur_modular.md) — set the widget on a form display (UI, config, or code), widget settings, permission.
- [Widgets & the framework](plugins/date_recur_modular.md) — the three widget plugins, their settings, and how to build your own.
