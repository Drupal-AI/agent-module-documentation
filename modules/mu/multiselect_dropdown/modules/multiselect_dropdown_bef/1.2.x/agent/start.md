<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiselect Dropdown for BEF — agent index

Submodule: a Better Exposed Filters widget that renders a multi-value Views exposed filter
as the parent module's multiselect dropdown. No config page, no permissions, no Drush.
Depends on `views`, `better_exposed_filters` (>=6/>=7), `multiselect_dropdown`.

- **Enabling the widget on an exposed filter, applicability rules, and every configuration
  option** → [configure/bef-widget.md](configure/bef-widget.md)

Parent module: [../../../../1.2.x/agent/start.md](../../../../1.2.x/agent/start.md)

Key facts:
- Plugin id `multiselect_dropdown` (`@BetterExposedFiltersFilterWidget`), class
  `MultiselectDropdownFilterWidget` extends `FilterWidgetBase`.
- Applicable when `expose.multiple` is true (and, for `TaxonomyIndexTid`, filter `type` ==
  `select`).
- Adds options beyond parent: `label_close/submit/clear`, `modal_type`, `modal_breakpoint`,
  `default_open`, `persist_open`. Attaches `multiselect_dropdown/views`.
