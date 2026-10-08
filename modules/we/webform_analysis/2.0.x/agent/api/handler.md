<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — the `WebformAnalysis` handler

Class `Drupal\webform_analysis\WebformAnalysis` (interface `WebformAnalysisInterface`). It is **not a
container service**; instantiate it with a webform (or a source entity) directly. In 2.0.x the
constructor also accepts an optional entity-type manager as the third argument (it falls back to
`\Drupal::entityTypeManager()` for backward compatibility):

```php
use Drupal\webform_analysis\WebformAnalysis;
$webform = \Drupal::entityTypeManager()->getStorage('webform')->load('contact');
$analysis = new WebformAnalysis($webform);
// or: new WebformAnalysis($entity, $field_name, $entity_type_manager);
```

If constructed with a non-webform entity, it resolves the webform + source entity via the
`webform.request` service (`getWebformEntities()`) — this is how the node submodule reuses it.

## Configuration accessors (read/write third-party settings)

```php
$analysis->setComponents(['subject']);   $analysis->getComponents();      // element keys (array)
$analysis->setChartType('PieChart');     $analysis->getChartType();       // ''|PieChart|ColumnChart
$analysis->setStartDate($timestamp);     $analysis->getStartDate();       // DrupalDateTime|null
$analysis->setEndDate($timestamp);       $analysis->getEndDate();
$analysis->setInDraft(FALSE);            $analysis->getInDraft();
$webform->save();                        // setters mutate the webform; save to persist
```

`setStartDate()`/`setEndDate()` take an int timestamp; the getters return a `DrupalDateTime`
(via `DrupalDateTime::createFromTimestamp()`) or NULL when unset.

## Computing statistics

```php
// Value => count for one element, honouring in_draft + start/end date filters.
$counts = $analysis->getComponentValuesCount('subject');

// Rows [[label, count], ...] with human labels (checkbox Yes/No, term/entity refs, option labels).
$rows = $analysis->getComponentRows('subject', $header = [], $valueLabelWithCount = FALSE);

$title  = $analysis->getComponentTitle('subject');      // element #title or the key
$labels = WebformAnalysis::getChartTypeOptions();       // static: the 3 chart choices
$flat   = $analysis->getElements();                     // flattened elements that have a value
```

`getComponentValuesCount()` builds a query with the DB API (parameterized conditions, no string
concat): `SELECT value, COUNT(value) AS quantity FROM webform_submission_data wsd
LEFT JOIN webform_submission ws ON wsd.sid = ws.sid WHERE wsd.webform_id = … AND ws.in_draft <= 0/1
AND name = :component`, plus `entity_type`/`entity_id` conditions when a source entity is set and
`ws.changed >= start` / `ws.changed <= end` when dates are set, `GROUP BY wsd.value`. Numeric values
are cast (`castNumeric()`) and the result `ksort()`-ed when all values are numeric.

`getComponentRows()` reorders values to the element's `#options` order when present and maps each
value to a display label by element `#type`:
- `checkbox` → `Yes`/`No`;
- `webform_term_select` / `webform_term_checkboxes` → taxonomy-term `label()` (loaded via the
  entity-type manager);
- `webform_entity_radios` / `webform_entity_select` / `webform_entity_checkboxes` → referenced
  entity `label()` using the element's `#target_type`;
- default → the element `#options[value]` label, else the raw value.
With `$value_label_with_count = TRUE` the count is appended to the label (`"label : N"`), used by the
pie chart. Rows are cast to `(string)` labels + int counts; an optional `$header` is prepended.

These are the core data methods the Analysis tab, the block, and any custom code use. The render
wrapper is `WebformAnalysisChart` (`build()` produces the render array; pie charts add `pieHole`
when there are >2 slices; chart data is attached under `drupalSettings.webformcharts`).
