<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BEF HTML5 Date plugin (bef_html5_date) — agent index

A **Better Exposed Filters** (BEF) widget plugin that renders a Views exposed **date** filter as a
native HTML5 date input (`<input type="date">`) instead of a text field.

- **Depends on:** `better_exposed_filters` (`^6 || ^7`). Core `^9.3 || ^10 || ^11`. Package: Views.
- **Provides:** one BEF filter-widget plugin — `id: bef_html5_date`, label "HTML5 Date"
  (`@BetterExposedFiltersFilterWidget` annotation).
- **Provides no** routes, permissions, services, hooks, config objects, config schema, settings form,
  install/update hooks, libraries, or submodules. `.info.yml` + one PHP class is the whole module.
- **Class:** `Drupal\bef_html5_date\Plugin\better_exposed_filters\filter\Html5Date`
  extends `FilterWidgetBase`
  (`src/Plugin/better_exposed_filters/filter/Html5Date.php`).

Behavior: shapes the exposed **filter widget only** — it does not alter query results or access; the
View's own access and the filter's value handling still apply. Selected per-filter in the BEF settings
when editing a View; no site-level configuration.

## Solution docs
- [Plugin: HTML5 Date widget](plugins/html5_date.md) — how the plugin registers, when it is offered
  (`isApplicable`), how `exposedFormAlter` rewrites the element, and how to enable/use it.
