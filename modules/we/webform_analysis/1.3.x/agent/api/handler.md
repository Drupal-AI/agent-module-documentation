<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — the `WebformAnalysis` handler

Class `Drupal\webform_analysis\WebformAnalysis` (interface `WebformAnalysisInterface`). It is **not a
container service**; instantiate it with a webform (or a source entity) directly:

```php
use Drupal\webform_analysis\WebformAnalysis;
$webform = \Drupal::entityTypeManager()->getStorage('webform')->load('contact');
$analysis = new WebformAnalysis($webform);
// Optional signature: new WebformAnalysis($entity, $field_name = NULL, $entity_type_manager = NULL)
```

If constructed with a non-webform entity, it resolves the webform + source entity via the
`webform.request` service (this is how the node submodule reuses it).

## Configuration accessors (read/write third-party settings)

```php
$analysis->setComponents(['subject']);   $analysis->getComponents();      // element keys
$analysis->setChartType('PieChart');     $analysis->getChartType();       // ''|PieChart|ColumnChart
$analysis->setStartDate($timestamp);     $analysis->getStartDate();       // DrupalDateTime|null
$analysis->setEndDate($timestamp);       $analysis->getEndDate();
$analysis->setInDraft(FALSE);            $analysis->getInDraft();
$webform->save();                        // setters mutate the webform; save to persist
```

## Computing statistics

```php
// Value => count for one element, honouring in_draft + start/end date filters.
$counts = $analysis->getComponentValuesCount('subject');

// Rows [[label, count], ...] with human labels (checkbox Yes/No, entity/term refs, option labels).
$rows = $analysis->getComponentRows('subject', $header = [], $valueLabelWithCount = FALSE);

$title  = $analysis->getComponentTitle('subject');      // element #title or key
$labels = WebformAnalysis::getChartTypeOptions();       // static: the 3 chart choices
$flat   = $analysis->getElements();                     // getElementsInitializedFlattenedAndHasValue()
```

`getComponentValuesCount()` builds a query on the `webform_submission_data` table
(`SELECT value, COUNT(value) AS quantity … LEFT JOIN webform_submission ws … WHERE wsd.webform_id = …
AND name = component`), constrained by `in_draft` (`ws.in_draft <= 0/1`) and the start/end timestamps
against `ws.changed`, grouped by `wsd.value`; numeric values are cast (`castNumeric()`/`isInt()`) and
`ksort`-ed when all values are numeric. All conditions are parameterized via the query builder.

`getComponentRows()` maps each value to a human label by element `#type`: `checkbox` → Yes/No;
`webform_term_select`/`webform_term_checkboxes` → taxonomy term label; `webform_entity_*` → referenced
entity label (via `#target_type`); otherwise the `#options` label or the raw value. When the element
defines `#options`, rows are reordered to match that original option order. Optionally appends
` : {count}` to each label when `$value_label_with_count` is TRUE (used by the pie chart).

These are the core data methods the Analysis tab (`WebformAnalysisChart::build()`), the block, and any
custom code use. `WebformAnalysisChart` turns the rows into either a `#theme => table` render array or
a `drupalSettings.webformcharts` payload consumed by `js/webform_analysis.charts.js` (Google Charts).
