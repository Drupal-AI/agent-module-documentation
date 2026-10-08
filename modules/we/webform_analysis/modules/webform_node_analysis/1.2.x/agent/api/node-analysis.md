<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Node Analysis — routes, tasks, storage

## Route

`entity.node.webform.results_analysis` → `/node/{node}/webform/results/analysis/{field_name}`
- `_entity_form: node.webform_analysis` (reuses `Drupal\webform_analysis\Form\WebformAnalysisForm`).
- Access: `_entity_access: node.view` **plus** custom
  `WebformNodeAnalysisAccess::checkWebformNodeAnalysisAccess`, which calls webform's
  `WebformNodeAccess::checkWebformResultsAccess` and then requires the node to actually have
  `{field_name}` (else forbidden). Effectively needs `view any webform submission`-style access.

The route/link template + `node.webform_analysis` form handler are attached to the **node** entity
type in `EntityTypeInfo::entityTypeAlter()` via `hook_entity_type_build`.

## Local task (tabs) — derived per field

`Plugin/Derivative/WebformNodeAnalysisLocalTask` scans `field_config` for node fields of type
`webform` and creates one local task per field:
`entity.node.webform.results_analysis.{field_name}` (title "Analysis @field-label",
parent `entity.node.webform.results`). So a node bundle needs at least one **webform field**
(provided by `webform_node`) for any Analysis tab to appear. `hook_entity_operation` adds the same
as a node operation when the user has `view any webform submission`.

## Block

Plugin id `webform_node_analysis_block`
(`Drupal\webform_node_analysis\Plugin\Block\WebformNodeAnalysisBlock`) — embeds a node's webform-field
analysis on any page.

## Where the analysis config is stored (important)

This submodule adds **no new storage**. When you configure analysis for a node's webform field, the
`WebformAnalysis` handler resolves the underlying **webform** (via `webform.request`) and writes the
settings as **third-party settings on that webform config entity**, namespace `webform_analysis`
(keys `components`, `chart_type`, `start_date`, `end_date`, `in_draft`) — exactly the parent module's
storage (see ../../../../1.2.x/agent/configure/results-tab.md). Read/write it the same way:

```php
$w = \Drupal::entityTypeManager()->getStorage('webform')->load($webform_id);
$w->getThirdPartySettings('webform_analysis');
$w->setThirdPartySetting('webform_analysis', 'chart_type', 'ColumnChart');
$w->save();
```

There is no config schema, no settings form, no permission, and no Drush command of the submodule's
own — it is routing/UI glue that surfaces the parent engine per node.
