<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Webform Analysis

There is **no global settings page**. Analysis is configured per webform on its Analysis tab:
`/admin/structure/webform/manage/{webform}/results/analysis`
(route `entity.webform.results_analysis`, entity form `webform.analysis`). Access is granted by
webform's own results access (`view any webform submission` / `webform.submission_view_any`), not a
permission defined by this module.

## Where settings are stored

As **third-party settings on the webform config entity** (`webform.webform.{id}`), namespace
`webform_analysis`. Schema: `webform.settings.third_party.webform_analysis`.

| Key | Type | Meaning |
|---|---|---|
| `components` | sequence of strings | The webform element keys to analyse. |
| `chart_type` | string (nullable) | `''` = Table, `PieChart`, or `ColumnChart`. |
| `start_date` | integer (nullable) | Only count submissions changed on/after this UNIX timestamp. |
| `end_date` | integer (nullable) | Only count submissions changed on/before this UNIX timestamp. |
| `in_draft` | boolean | Include draft submissions when TRUE. |

Chart choices come from `WebformAnalysis::getChartTypeOptions()`:
`['' => Table, 'PieChart' => Pie Chart, 'ColumnChart' => Column Chart]`.

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
  hook, using the `webform_charts` library (Google Charts from gstatic) for pie/column.
- The **`webform_analysis_block`** Block plugin embeds a component's chart/table on any page
  (see plugins/block.md).

No config schema beyond the third-party-settings mapping; no Drush commands.
