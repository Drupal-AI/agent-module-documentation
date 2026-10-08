<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Webform Analysis

There is **no global settings page**. Analysis is configured per webform on its Analysis tab:
`/admin/structure/webform/manage/{webform}/results/analysis`
(route `entity.webform.results_analysis`, entity form `webform.analysis` →
`Drupal\webform_analysis\Form\WebformAnalysisForm`). The tab and form handler are attached to the
`webform` entity type in `EntityTypeInfo::entityTypeAlter()` via `hook_entity_type_build`
(link template `results_analysis`); the local task is declared in
`webform_analysis.links.task.yml` under `entity.webform.results`.

## Access

The route requires `_entity_access: webform.submission_view_any` **and** custom access
`\Drupal\webform\Access\WebformEntityAccess::checkResultsAccess` — i.e. webform's own
`view any webform submission` / per-webform results access, not a permission defined by this module.
The "Analysis" entity operation (`EntityTypeInfo::entityOperation()`) is likewise only added when the
current user `hasPermission('view any webform submission')`.

## Where settings are stored

As **third-party settings on the webform config entity** (`webform.webform.{id}`), namespace
`webform_analysis`. Schema: `webform.settings.third_party.webform_analysis` (in
`config/schema/webform_analysis.schema.yml`).

| Key | Type | Meaning |
|---|---|---|
| `components` | sequence of strings | The webform element keys to analyse. |
| `chart_type` | string (nullable) | `''` = Table, `PieChart`, or `ColumnChart`. |
| `start_date` | integer (nullable) | Only count submissions whose `changed` is on/after this UNIX timestamp. |
| `end_date` | integer (nullable) | Only count submissions whose `changed` is on/before this UNIX timestamp. |
| `in_draft` | boolean | Include draft submissions when TRUE (query uses `ws.in_draft <= 0/1`). |

The form saves via `WebformAnalysis` setters then `$webform->save()`; start/end date `datetime`
values are converted with `strtotime()` before being stored as integer timestamps.

Chart choices come from `WebformAnalysis::getChartTypeOptions()`:
`['' => Table, 'PieChart' => Pie chart, 'ColumnChart' => Column chart]`.

The schema also defines `block.settings.webform_analysis_block` (`entity_id`, `component`,
`chart_type`) for the block plugin — see plugins/block.md.

## Read / write with drush

Read a webform's analysis settings:
```bash
drush php:eval '$w=\Drupal::entityTypeManager()->getStorage("webform")->load("contact");
  print json_encode($w->getThirdPartySettings("webform_analysis"));'
```
Set components + chart type (this is exactly what the Analysis form saves):
```bash
drush php:eval '$w=\Drupal::entityTypeManager()->getStorage("webform")->load("contact");
  $w->setThirdPartySetting("webform_analysis","components",["subject","message"]);
  $w->setThirdPartySetting("webform_analysis","chart_type","PieChart");
  $w->setThirdPartySetting("webform_analysis","in_draft",FALSE);
  $w->save();'
```
Or via the handler helper (same storage):
```php
use Drupal\webform_analysis\WebformAnalysis;
$a = new WebformAnalysis($webform);
$a->setComponents(['subject']);
$a->setChartType('ColumnChart');
$a->setInDraft(FALSE);           // setStartDate($ts) / setEndDate($ts) also available
// setters call $webform->setThirdPartySetting(...); call $webform->save() after.
```

Remove analysis config (restore baseline):
```bash
drush php:eval '$w=\Drupal::entityTypeManager()->getStorage("webform")->load("contact");
  $w->unsetThirdPartySetting("webform_analysis","components");
  $w->unsetThirdPartySetting("webform_analysis","chart_type"); $w->save();'
```

## Rendering surfaces

- The **Analysis tab** renders each configured component via the `webform_analysis_component` theme
  hook (`templates/webform-analysis-component.html.twig`). The render array is assembled by
  `WebformAnalysisChart::build()`: tables render through `#theme => table`; pie/column charts pass
  their rows into `drupalSettings.webformcharts` and are drawn client-side by the `webform_charts`
  library (Google Charts from gstatic, `js/webform_analysis.charts.js`). Chart output sets
  `#cache => ['max-age' => 0]`.
- The **`webform_analysis_block`** Block plugin embeds a component's chart/table on any page
  (see plugins/block.md).

## Update path

`webform_analysis.install` ships `webform_analysis_update_8101()`, a batched update that migrates
legacy `analysis_components` / `analysis_chart_type` webform settings into the `webform_analysis`
third-party-settings namespace. Relevant only when upgrading old sites; no schema of its own beyond
the third-party mapping, and no Drush commands.
