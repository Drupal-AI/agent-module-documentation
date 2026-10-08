# The `xray_audit_insight` plugin type

Add a Status-Report warning derived from an Xray Audit task operation.

| | |
|---|---|
| Manager | `plugin_manager.xray_audit_insight` |
| Discovery dir | `src/Plugin/insights/` |
| Discovery style | **Annotation** `@XrayAuditInsightPlugin` (`src/Annotation/XrayAuditInsightPlugin.php`) |
| Interface | `XrayAuditInsightPluginInterface` |
| Base class | `XrayAuditInsightPluginBase` |
| Alter hook | `hook_xray_audit_insight_info(&$definitions)` |

Annotation properties: `id`, `label`, `description`, `sort`.

## How an insight works

An insight points at a parent task plugin + operation (`$taskPluginId`, `$operation`), fetches its
data, compares against a threshold, and returns Status-Report rows. The runtime hook
(`xray_audit_insight_requirements`) calls `isActive()` then `getInsightsForDrupalReport()` on each.

```php
namespace Drupal\my_module\Plugin\insights;

use Drupal\xray_audit_insight\Plugin\XrayAuditInsightPluginBase;
use Drupal\xray_audit\Plugin\XrayAuditTaskPluginInterface;

/**
 * @XrayAuditInsightPlugin (
 *   id = "my_insight",
 *   label = @Translation("My insight"),
 *   description = @Translation("…"),
 *   sort = 10
 * )
 */
class MyInsight extends XrayAuditInsightPluginBase {

  protected $taskPluginId = 'database_general';
  protected $operation = 'database_summary';

  public function getInsights(): array {
    // Return keyed booleans/values used by getInsightsForDrupalReport().
    return ['my_insight' => $this->somethingIsWrong()];
  }

  public function getInsightsForDrupalReport(): array {
    $flag = $this->getInsights()['my_insight'];
    return [
      'my_insight' => $this->buildInsightForDrupalReport(
        $this->label(),
        $flag ? $this->t('Problem found. Check the report.') : $this->t('OK'),
        '',
        $flag ? REQUIREMENT_WARNING : NULL,
      ),
    ];
  }
}
```

## Helpers on the base class

- `getInstancedPlugin($taskPluginId, $operation)` / access to `getDataOperationResult()` — pull the
  parent report's data.
- `getPathReport($taskPluginId, $operation)` — build the link to the underlying report.
- `buildInsightForDrupalReport($title, $value, $description, $severity)` — format a `hook_requirements` row.
- `buildInsightForSettings($config)` / `submitInsightSettings($form_state, $config)` — contribute the
  plugin's own toggle/thresholds to the shared settings form.
- `isActive()` — whether the insight runs (respects `excluded_insights`).

See the shipped `Plugin/insights/*` (e.g. `XrayAuditDatabase`, `XrayAuditNodeRevision`,
`XrayAuditInternalPageCache`, `XrayAuditViewsNotCached`) for complete examples.
