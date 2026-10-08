# Plugin type: SecurityCheck

Security Review's checklist is built from `SecurityCheck` plugins. Any module can add one.

- **Plugin manager service:** `plugin.manager.security_review.security_check` (`SecurityCheckPluginManager`).
- **Discovery dir:** `Plugin/SecurityCheck/` in any module.
- **Attribute:** `Drupal\security_review\Attribute\SecurityCheck` (legacy annotation `Annotation\SecurityCheck` also supported).
- **Base class:** `Drupal\security_review\SecurityCheckBase` (implements `SecurityCheckInterface`, `ContainerFactoryPluginInterface`).
- **Alter hook for definitions:** `hook_security_review_check_info_alter()`.

## Attribute properties
```php
#[SecurityCheck(
  id: 'my_check',                                  // plugin id (also the check machine id)
  title: new TranslatableMarkup('My check'),
  description: new TranslatableMarkup('What it inspects.'),
  namespace: new TranslatableMarkup('My Module'),  // grouping; built-ins use 'Security Review'
  success_message: new TranslatableMarkup('All good.'),
  failure_message: new TranslatableMarkup('Problem found.'),  // optional
  info_message: new TranslatableMarkup('...'),                // optional
  warning_message: new TranslatableMarkup('...'),             // optional
  help: [new TranslatableMarkup('Why this check exists.')],   // optional render/text array
)]
```

## Minimal implementation
Extend `SecurityCheckBase` and implement `doRun()`; call `$this->createResult()` with a `CheckResult` status constant and a findings array.

```php
namespace Drupal\my_module\Plugin\SecurityCheck;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\security_review\Attribute\SecurityCheck;
use Drupal\security_review\CheckResult;
use Drupal\security_review\SecurityCheckBase;

#[SecurityCheck(
  id: 'my_check',
  title: new TranslatableMarkup('My check'),
  description: new TranslatableMarkup('Checks a thing.'),
  namespace: new TranslatableMarkup('My Module'),
  success_message: new TranslatableMarkup('OK.'),
  failure_message: new TranslatableMarkup('Not OK.'),
)]
class MyCheck extends SecurityCheckBase {

  public function doRun(bool $cli = FALSE): void {
    $bad = /* inspect the site */ FALSE;
    $this->createResult($bad ? CheckResult::FAIL : CheckResult::SUCCESS, ['detail' => '...']);
  }

  // Optional: render/return findings detail (array for UI, string when $returnString for Drush).
  public function getDetails(array $findings, array $hushed = [], bool $returnString = FALSE): array|string {
    return $returnString ? '' : [];
  }
}
```

- Need extra services? Override `create()` (see `SecurityCheckBase::create`, which injects `state`, `security_review`, `security_review.data`) and pull more from the container.
- Result status constants: `CheckResult::SUCCESS` (0), `FAIL` (1), `WARN` (2), `INFO` (3).
- `run(bool $cli, &$sandbox): float` returns 1 when done; return a float `<1` to be re-invoked (batchable long checks).
- Per-check settings on the settings form: implement `buildConfigurationForm()` / `submitConfigurationForm()` and declare schema `security_review.check_settings.<id>`.
- Custom checks are addressable in Drush as `--check=my_module:my_check` (module must be enabled).

See built-in examples under `security_review/src/Plugin/SecurityCheck/` (e.g. `ErrorReporting`, `FilePermissions`, `TrustedHosts`).
