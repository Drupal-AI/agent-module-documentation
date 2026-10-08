<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widget configuration & schema

The module owns **no config objects** (`config/install` is absent) and has **no settings route** (`configure` is
null). Its only configuration is the per-facet widget settings, saved by Facets inside each facet's own config
entity and validated by the schema in `config/schema/facets_range_datepicker_widget.schema.yml`.

## Config schema

- `facet.widget.config.datepicker` (type `facet.widget.datepicker`) — for the `datepicker` widget:
  - `facet_min_label` (`label`, translatable) — "Date Label".
  - `labels_hidden` (`boolean`) — "Add visually-hidden class to Facet Labels".
- `facet.widget.config.range_datepicker` (type `facet.widget.range_datepicker`) — for the `range_datepicker`
  widget:
  - `facet_min_label` (`label`, translatable) — "Minimum Date Label".
  - `facet_max_label` (`label`, translatable) — "Maximum Date Label".
  - `labels_hidden` (`boolean`).

Defaults come from each widget's `defaultConfiguration()` (see [../plugins/widgets.md](../plugins/widgets.md)):
`datepicker` → `facet_min_label = 'Select Date'`, `labels_hidden = 0`; `range_datepicker` →
`facet_min_label = 'Initial Date'`, `facet_max_label = 'Closing Date'`.

## Where these are edited

The settings are exposed through each widget's `buildConfigurationForm()`, which is rendered **inside the Facets
facet-edit form** (Configuration → Search and metadata → Facets → edit a facet). This module declares no route or
form of its own, so access is controlled by the Facets admin permissions on that page. Each config form also shows
a warning reminding the admin to enable the matching processor (`datepicker` / `range_datepicker`).

## Operating checklist

1. The facet source field must be a supported date/timestamp type: `datetime`/`created`/`changed` for the
   single-day picker, `datetime`/`created`/`updated` for the range picker (from each processor's
   `supportsFacet()`).
2. Select the **Datepicker** or **Range Datepicker** widget on the facet.
3. Enable the matching **processor** (mandatory — the widget's `isPropertyRequired()` requires it).
4. Optionally set the label text and toggle `labels_hidden`.
