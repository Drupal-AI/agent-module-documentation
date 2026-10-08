<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Dependent Filter — agent index

Adds a **"Global: Dependent filter"** Views filter handler (`views_dependent_filter`) that
shows/hides *other* exposed filters based on a controlling filter's value, using Form API
`#states`. No settings page (`configure: null`), no permissions, no Drush, no config schema of
its own. Everything is configured per-view in the Views UI.

- **The filter handler: what it is, how to place & configure it (controller filter, condition
  mode, controller values, dependent filters, negate), the widget/BEF/Facets support, and the
  view-config shape it writes** → [plugins/dependent-filter.md](plugins/dependent-filter.md)

Key facts:
- The handler does **no query** and takes **no input** — it only wires up visibility.
- Placement matters: put it **after** the controller filter and **before** the dependent
  filter(s). Only earlier filters may be controllers; only later filters may be dependents.
- In `views.view.*` config the handler is a filter with `plugin_id: views_dependent_filter`
  and options `condition`, `controller_filter`, `controller_values`, `dependent_filters`,
  `negate`.
- The deprecated shim submodule `views_dependent_filter` (singular) only exists to migrate the
  old D8 module name — see its own docs; do not enable it for new sites.
