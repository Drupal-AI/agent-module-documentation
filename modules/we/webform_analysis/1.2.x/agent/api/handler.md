<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Analysis — the `WebformAnalysis` handler

Class `Drupal\webform_analysis\WebformAnalysis` (interface `WebformAnalysisInterface`). It is **not a
container service**; instantiate it with a webform (or a source entity) directly:

```php
use Drupal\webform_analysis\WebformAnalysis;
$webform = \Drupal::entityTypeManager()->getStorage('webform')->load('contact');
$analysis = new WebformAnalysis($webform);
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
$flat   = $analysis->getElements();                     // flattened elements with values
```

`getComponentValuesCount()` queries the `webform_submission_data` table
(`SELECT value, COUNT(value) … WHERE webform_id = … AND name = component`), constrained by
`in_draft` (`ws.in_draft <= 0/1`) and the start/end timestamps against `ws.changed`, grouped by
value; numeric values are cast and sorted. This is the core data method the Analysis tab, the block,
and any custom code use.
