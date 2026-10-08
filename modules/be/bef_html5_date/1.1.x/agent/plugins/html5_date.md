<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin: HTML5 Date widget (`bef_html5_date`)

Single BEF filter-widget plugin. File: `src/Plugin/better_exposed_filters/filter/Html5Date.php`.
Class `Html5Date extends FilterWidgetBase` (from `better_exposed_filters`).

## Registration
Annotation `@BetterExposedFiltersFilterWidget(id = "bef_html5_date", label = @Translation("HTML5 Date"))`.
BEF discovers it under the `Plugin/better_exposed_filters/filter` namespace; no `*.services.yml` or
plugin-type definition is needed (the plugin type is owned by Better Exposed Filters).

## When it is offered — `isApplicable(mixed $filter = NULL, array $filter_options = []): bool`
Returns TRUE only when **both**:
- the filter is a `Drupal\views\Plugin\views\filter\Date` (`is_a(...)`) **or** the filter has a
  non-empty `$filter->date_handler`, **and**
- the filter is not a grouped filter (`!$filter->isAGroup()`).

So the "HTML5 Date" widget appears in the BEF widget dropdown only for date-type exposed filters that
are not exposed as a group.

## What it does — `exposedFormAlter(array &$form, FormStateInterface $form_state): void`
1. Resolves the exposed element by `$this->getExposedFilterFieldId()`. If `$form[$field_id]` is absent
   but a `${field_id}_wrapper` exists (the wrapper core added in drupal.org issue #2625136), it targets
   `$form[$wrapper_id][$field_id]` instead.
2. Calls `parent::exposedFormAlter()` (base BEF widget behavior).
3. Detects multi-value shape: if the element has any of the keys `min`, `max`, `value`, it rewrites each
   present subfield; otherwise it rewrites the element itself. For each target it sets:
   - `#type` = `date`
   - `#attributes['type']` = `date`
   - `#attributes['class'][]` = `bef-html5-date`

This turns the exposed input into a native HTML5 `<input type="date">`. The `bef-html5-date` class is a
theming hook. No values are read from or written back to the request here — only the render element's
type/attributes are changed; the filter's operator and value processing are untouched.

## Enable and use
1. `composer require drupal/bef_html5_date` (pulls `better_exposed_filters ^6 || ^7`).
2. `drush en bef_html5_date -y`.
3. Edit a View, expose a **date** filter, and in the filter's **Exposed form → Better Exposed Filters**
   settings set that filter's widget to **HTML5 Date**.
4. Save the View. The exposed date field (or its min/max inputs for ranged filters) now renders as a
   native date picker.

## Notes
- No configuration, permissions, routes, or config schema are provided by this module; there is nothing
  to export or set at the site level. The widget choice is stored in the View's BEF configuration.
- Widget-only: does not change results returned by the View, and does not alter access — the View's
  access plugin and the filter's own value handling remain authoritative.
