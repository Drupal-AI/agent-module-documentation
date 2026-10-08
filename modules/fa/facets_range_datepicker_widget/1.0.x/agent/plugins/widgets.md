<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets widgets: `datepicker` and `range_datepicker`

Files: `src/Plugin/facets/widget/DatepickerWidget.php`, `src/Plugin/facets/widget/RangeDatepickerWidget.php`.
Both extend `Drupal\facets\Widget\WidgetPluginBase`. `RangeDatepickerWidget` extends `DatepickerWidget`.

## `DatepickerWidget` (id `datepicker`)

`@FacetsWidget(id = "datepicker", label = "Datepicker", description = "A widget that shows a datepicker.")`

- `defaultConfiguration()` → `['labels_hidden' => 0, 'facet_min_label' => 'Select Date']` + parent defaults.
- `getQueryType()` → `'range'`.
- `isPropertyRequired($name, $type)` → TRUE when `$name === 'datepicker'` and `$type === 'processors'`, i.e. the
  matching **`datepicker` processor is mandatory** for this widget.
- `build(FacetInterface $facet)`:
  - Returns early (parent build only) if `$facet->getResults()` is empty; otherwise `ksort()`s the results.
  - Computes a default input value from the active item: if `$active[0]['min']` is set,
    `date('Y-m-d', $active[0]['min'])` (a server-formatted date string from the numeric min timestamp).
  - Builds `#items['min']['label']` (a `html_tag` `label`, `#value` = `facet_min_label`) and
    `#items['min']['input']` (a `html_tag` `input`, `type=date`, class `facet-datepicker`,
    `data-type=datepicker-min`, unique id via `Html::getUniqueId($facet->id() . '-min')`).
  - If `labels_hidden == 1`, adds the `visually-hidden` class to the label.
  - Takes the URL of the first result (`array_shift($results)->getUrl()->toString()` — this is the
    placeholder-token URL the processor built) and attaches it to
    `drupalSettings.facets.datepicker[$facet->id()].url`, then attaches the
    `facets_range_datepicker_widget/datepicker` library.
- `buildConfigurationForm()`: adds a warning that the `Datepicker` **processor** must be enabled, a
  `labels_hidden` checkbox, and a `facet_min_label` textfield ("Date Label").

## `RangeDatepickerWidget` (id `range_datepicker`)

`@FacetsWidget(id = "range_datepicker", label = "Range Datepicker", description = "A widget that shows a
datepicker slider.")`

- `defaultConfiguration()` → `['facet_min_label' => 'Initial Date', 'facet_max_label' => 'Closing Date']` + parent
  (inherits `labels_hidden`).
- `getQueryType()` → `'range'`. `isPropertyRequired()` → requires the **`range_datepicker` processor**.
- `build()`: calls the parent build (so the `min` input exists), then overrides the min label with
  `facet_min_label` and adds a second `#items['max']` label + `input` (`data-type=datepicker-max`, unique id
  `Html::getUniqueId($facet->id() . '-max')`). If `labels_hidden == 1`, both labels get `visually-hidden`.
  Re-attaches the placeholder URL to `drupalSettings.facets.datepicker[$facet->id()].url`.
- `buildConfigurationForm()`: parent form + a warning to enable the `Range Datepicker` processor; retitles the
  min label field to "Minimum Date Label" and adds a `facet_max_label` textfield ("Maximum Date Label").

## Notes for operators

- The two picker inputs are native HTML5 `<input type="date">` elements; there is no jQuery UI calendar.
- Labels (`facet_min_label` / `facet_max_label`) are admin-entered per-facet configuration; the `visually-hidden`
  option only hides them visually (kept for assistive tech).
- The widget only renders when the facet has results. The auto-submit behavior lives entirely in the JS library
  (see [../behavior/datepicker-js.md](../behavior/datepicker-js.md)); the placeholder URL it rewrites is produced
  by the processor (see [processors.md](processors.md)).
