# Xray Audit plugin types — add a report

Two plugin types drive every report.

| Plugin type | Manager service | Discovery dir | Attribute (and legacy annotation) | Base / interface |
|---|---|---|---|---|
| `xray_audit_group` | `plugin_manager.xray_audit_group` | `src/Plugin/xray_audit/groups/` | `#[XrayAuditGroupPlugin]` / `@XrayAuditGroupPlugin` | `XrayAuditGroupPluginBase` / `…Interface` |
| `xray_audit_task` | `plugin_manager.xray_audit_task` | `src/Plugin/xray_audit/tasks/` | `#[XrayAuditTaskPlugin]` / `@XrayAuditTaskPlugin` | `XrayAuditTaskPluginBase` / `…Interface` |

Both managers extend `DefaultPluginManager` and support **either** the PHP attribute (preferred)
or the old Doctrine annotation (existing core plugins still use `@XrayAuditTaskPlugin (...)`
annotations). The `xray_audit.plugin_repository` service discovers, sorts, caches and instantiates
them; `Routing/RouteSubscriber` + `hook_local_tasks_alter` turn task *operations* into routes/tabs.

## Group plugin

A group is just a report category shown on the home page. Minimal implementation:

```php
namespace Drupal\my_module\Plugin\xray_audit\groups;

use Drupal\xray_audit\Plugin\XrayAuditGroupPluginBase;
use Drupal\xray_audit\Attribute\XrayAuditGroupPlugin;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[XrayAuditGroupPlugin(
  id: 'my_group',
  label: new TranslatableMarkup('My group'),
  description: new TranslatableMarkup('Custom reports.'),
  sort: 50,
)]
class MyGroupPlugin extends XrayAuditGroupPluginBase {}
```

Group attribute properties: `id`, `label`, `description`, `sort`, `deriver`. Core group ids:
`database`, `package`, `site_structure`, `content_model`, `content_metric`, `forms`,
`content_display`, `layout`, `content_access_control`.

## Task plugin

A task computes one or more *operations* (each a report table) and renders them. Implement
`getDataOperationResult($operation)` (return raw data) and `buildDataRenderArray($data, $operation)`
(return a render array); extend `XrayAuditTaskPluginBase`.

```php
namespace Drupal\my_module\Plugin\xray_audit\tasks;

use Drupal\xray_audit\Plugin\XrayAuditTaskPluginBase;
use Drupal\xray_audit\Attribute\XrayAuditTaskPlugin;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[XrayAuditTaskPlugin(
  id: 'my_report',
  group: 'content_metric',
  label: new TranslatableMarkup('My report'),
  description: new TranslatableMarkup('…'),
  sort: 10,
  operations: [
    'my_op' => ['label' => 'My op', 'description' => '…', 'download' => TRUE],
  ],
  local_task: 1,
  dependencies: ['node'],
)]
class MyReportPlugin extends XrayAuditTaskPluginBase {
  public function getDataOperationResult(string $operation = ''): array {
    return match ($operation) {
      'my_op' => $this->computeRows(),
      default => [],
    };
  }
  public function buildDataRenderArray(array $data, string $operation = '') {
    return ['#theme' => 'table', '#header' => [...], '#rows' => $data];
  }
}
```

### Task attribute properties (`Attribute/XrayAuditTaskPlugin`)

| Property | Meaning |
|---|---|
| `id` | Plugin id. |
| `group` | Group id this task belongs to (must match a group plugin). |
| `label` / `description` | Human strings. |
| `sort` | Position within the group. |
| `operations` | Map of `operation_id => ['label','description','download'(bool),'not_show'(bool)…]`. Each operation becomes a report/tab; `download: TRUE` includes it in CSV/ZIP export. |
| `batches` | Method names for batch-processed operations (heavy reports). |
| `install` / `uninstall` | Method run on module install/uninstall (e.g. create/drop a temp table). |
| `local_task` | `1` ⇒ expose operations as local-task tabs. |
| `dependencies` | Module names required for the task to be available (`isOperationAvailable()` / `OperationAccessCheck` enforce this). |
| `deriver` | Optional deriver class. |

### What the base class gives you

`XrayAuditTaskPluginBase` (constructor-injected): `entityTypeManager`, `database`,
`languageManager`, `pluginRepository`, `csvDownloadManager`, `configFactory`, `moduleHandler`,
and the `xray_audit.settings` config. It also `use`s `XrayAuditTaskCsvDownloadTrait` — implement
`prepareCsvHeaders()` / `prepareCsvData()` and call `processCsvDownload($operation, $data, $builds)`
inside `buildDataRenderArray()` to make a report exportable (see the `themes` task for a complete
example). `getHeaders()` supplies the on-screen table headers.

## Insight plugins

The **xray_audit_insight** submodule defines a *third* plugin type (`xray_audit_insight`,
manager `plugin_manager.xray_audit_insight`, dir `Plugin/insights`, annotation
`@XrayAuditInsightPlugin`) that reuses task results to raise Status-Report warnings. See the
submodule docs: [../../../modules/xray_audit_insight/3.0.x/agent/plugins/plugins.md](../../../modules/xray_audit_insight/3.0.x/agent/plugins/plugins.md).
