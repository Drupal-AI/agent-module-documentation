<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DblogOperation plugin type & rendering pipeline

## Install / enable
`drush en dblog_api` (pulls in core `dblog`). Rebuild caches so the Views-data alter takes effect: `drush cr`. No configuration follows — the module has no settings.

## The plugin type
Defined by `src/DblogOperationManager.php` (`DefaultPluginManager` subclass):
- Discovery namespace: `Plugin/DblogOperation`.
- Interface: `Drupal\dblog_api\DblogOperationInterface`.
- Annotation: `Drupal\dblog_api\Annotation\DblogOperation` (single field: `id`).
- Alter hook: `dblog_api_operation` (definitions alterable via `hook_dblog_api_operation_alter()`).
- Cache: bin from `cache.default`, key `dblog_api_operation`.
- Service id: `plugin.manager.dblog_api_operation`.

Base class `src/DblogOperationBase.php` extends core `PluginBase` and adds nothing — implement the interface yourself (it does not implement it for you).

### Interface contract (`DblogOperationInterface`)
- `shouldDisplay(ResultRow $dblogRow): bool` — return TRUE to contribute an operation for this row. Inspect `$dblogRow` fields (e.g. `type`/channel, `severity`, `wid`, `link`) to gate per row.
- `displayOperation(ResultRow $dblogRow): array` — return a render array appended to the row's operations column. Only called when `shouldDisplay()` returned TRUE.

Both methods receive the Views `\Drupal\views\ResultRow` for the `watchdog` row currently rendering.

## Rendering pipeline
1. `dblog_api.views.inc` implements `hook_views_data_alter()` (legacy shim delegating to `Drupal\dblog_api\Hook\DblogApiViewsHooks::viewsDataAlter()`, the OOP hook via the `#[Hook('views_data_alter')]` attribute + `autowire` service). It sets `$data['watchdog']['link']['field']['id'] = 'dblog_api_operations'`, replacing core's `dblog_operations` field handler on the `watchdog` table's `link` field.
2. `src/Plugin/views/field/DblogApiOperations.php` (annotated `@ViewsField("dblog_api_operations")`, extends core `Drupal\dblog\Plugin\views\field\DblogOperations`) overrides `render(ResultRow $values)`:
   - Puts core's original output (the "view" detail link) at `$output['dblog_view']['#markup'] = parent::render($values);`.
   - Loops every definition from `$this->dblogOperationsManager->getDefinitions()`, creates each instance, and if `$plugin->shouldDisplay($values)` is TRUE, assigns `$output[$pluginId] = $plugin->displayOperation($values)`.
   - Returns the combined render array. The manager is injected in `create()` from `plugin.manager.dblog_api_operation`.

Result: every registered plugin can add its own markup to each log row's operations cell on the `admin/reports/dblog` overview (a `watchdog`-based View), alongside core's "view" link.

## Example plugin (from the shipped test module)
`tests/modules/dblog_api_test/src/Plugin/DblogOperation/TestDblogOperationOne.php`:

```php
/**
 * @DblogOperation(
 *   id = "dblog_api_test_test_1",
 * )
 */
class TestDblogOperationOne extends DblogOperationBase implements DblogOperationInterface {
  public function displayOperation(ResultRow $dblogRow): array {
    return ['#markup' => ' ' . $this->t('dblog_api_test_test_1') . ' '];
  }
  public function shouldDisplay(ResultRow $dblogRow): bool {
    return TRUE;
  }
}
```

Place your plugin at `src/Plugin/DblogOperation/<Name>.php` in your own module, give it a unique `id`, extend `DblogOperationBase`, implement `DblogOperationInterface`, and return sanitized render arrays from `displayOperation()`.

## Notes / caveats
- The overview screen shows a Views `watchdog` table; the message-detail screen (`admin/reports/event/%`) is not a View, so operations added here appear on the overview listing.
- Escape/sanitize anything you place in the render array yourself (use `#markup` with safe strings, `#url`/`Link`, or `#plain_text`) — the handler renders plugin output as-is.
- The project's functional test (`tests/src/Functional/DblogApiTest.php`) marks the operations-column assertions skipped with "Production code not yet implemented"; the plugin manager, Views handler, and hook are present and wired as described above.
