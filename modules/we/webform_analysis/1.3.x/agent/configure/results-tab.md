<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Webform Analysis

There is **no global settings page**. Analysis is configured per webform on its Analysis tab:
`/admin/structure/webform/manage/{webform}/results/analysis`
(route `entity.webform.results_analysis`, entity form `webform.analysis`,
`Drupal\webform_analysis\Form\WebformAnalysisForm`). Access requires the route's
`_entity_access: webform.submission_view_any` plus custom
`\Drupal\webform\Access\WebformEntityAccess::checkResultsAccess` — webform's own results access, not a
permission defined by this module. The route/link template + form handler are attached to the
`webform` entity type in `EntityTypeInfo::entityTypeAlter()` via `hook_entity_type_build`;
`hook_entity_operation` adds an "Analysis" operation for users with `view any webform submission`.

## Where settings are stored

As **third-party settings on the webform config entity** (`webform.webform.{id}`), namespace
`webform_analysis`. Schema: `webform.settings.third_party.webform_analysis`.

| Key | Type | Meaning |
|---|---|---|
| `components` | sequence of strings | The webform element keys to analyse. |
| `chart_type` | string (nullable) | `''` = Table, `PieChart`, or `ColumnChart`. |
| `start_date` | integer (nullable) | Only count submissions with `ws.changed` on/after this UNIX timestamp. |
| `end_date` | integer (nullable) | Only count submissions with `ws.changed` on/before this UNIX timestamp. |
| `in_draft` | boolean | Include draft submissions when TRUE (`ws.in_draft <= 1`). |

Chart choices come from `WebformAnalysis::getChartTypeOptions()`:
`['' => Table, 'PieChart' => Pie chart, 'ColumnChart' => Column chart]`.

The Analysis form (`WebformAnalysisForm`) exposes: a component checkboxes group, a Date range
(start/end datetime, date-only), an "Include draft submissions" checkbox, and a "Charts type" select.
Submitting runs `submitForm()` (writes the settings via the handler) then `save()` (saves the webform).

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

## Update hook

`webform_analysis_update_8101()` migrates legacy `analysis_components` / `analysis_chart_type`
webform settings into the third-party-settings storage described above (batched over all webforms).

## Rendering surfaces

- The **Analysis tab** renders each configured component via the `webform_analysis_component` theme
  hook (a `#theme => table` inside), using the `webform_charts` library (Google Charts loader from
  gstatic) for pie/column. Render cache is disabled (`#cache max-age 0`).
- The **`webform_analysis_block`** Block plugin embeds a component's chart/table on any page
  (see plugins/block.md).

No config schema beyond the third-party-settings mapping (plus `block.settings.webform_analysis_block`);
no Drush commands.
