# Plugin types: checks & checklists

Two annotation-based plugin types (both extend `DefaultPluginManager`):

| Plugin type id | Manager service | Directory | Interface | Annotation |
|---|---|---|---|---|
| `site_audit_checklist` (a "report") | `plugin.manager.site_audit_checklist` | `Plugin/SiteAuditChecklist/` | `SiteAuditChecklistInterface` | `@SiteAuditChecklist` |
| `site_audit_check` | `plugin.manager.site_audit_check` | `Plugin/SiteAuditCheck/` | `SiteAuditCheckInterface` | `@SiteAuditCheck` |

Alter hooks: `hook_site_audit_site_audit_checklist_info()` and `hook_site_audit_site_audit_check_info()`.

## A checklist (report)

A checklist is essentially a container; most shipped ones are one-liners. Its constructor discovers
all checks whose annotation `checklist` matches its id, sorts them by `weight` (then id), runs each,
and rolls up a percentage score (a check may `shouldAbort()` to stop the rest).

```php
namespace Drupal\mymodule\Plugin\SiteAuditChecklist;

use Drupal\site_audit\Plugin\SiteAuditChecklistBase;

/**
 * @SiteAuditChecklist(
 *   id = "my_report",
 *   name = @Translation("My Report"),
 *   description = @Translation("Checks my things")
 * )
 */
class MyReport extends SiteAuditChecklistBase {}
```

## A check

Extend `SiteAuditCheckBase` (constructor is injected with `@database` and `@logger.factory`). The
annotation's **`checklist`** property names the report the check belongs to (use an existing report id
like `cache`, or your own). Implement `calculateScore()` returning one of the score constants and the
`getResult*()` messages.

```php
namespace Drupal\mymodule\Plugin\SiteAuditCheck;

use Drupal\site_audit\Plugin\SiteAuditCheckBase;

/**
 * @SiteAuditCheck(
 *   id = "my_check",
 *   name = @Translation("My Check"),
 *   description = @Translation("Checks one thing"),
 *   checklist = "cache"
 * )
 */
class MyCheck extends SiteAuditCheckBase {
  public function calculateScore() {
    return self::AUDIT_CHECK_SCORE_PASS; // PASS=2, WARN=1, FAIL=0, INFO=3
  }
  public function getResultPass() { return $this->t('All good.'); }
  public function getResultWarn() { return $this->t('Could be better.'); }
  public function getResultFail() { return $this->t('Problem found.'); }
  public function getResultInfo() { return $this->t('FYI.'); }
  public function getAction() { return $this->t('Do this to fix it.'); }
}
```

Score constants (on `SiteAuditCheckBase`): `AUDIT_CHECK_SCORE_INFO=3`, `_PASS=2`, `_WARN=1`, `_FAIL=0`.
Useful base features: `$this->abort` (skip remaining checks), `$this->registry` (pass data between
checks in a report), `$this->options` (run options such as `html`, `detail`).

## Shipped reports (checklist ids)

`best_practices`, `block`, `cache`, `codebase`, `content`, `cron`, `database`, `extensions`,
`security`, `status`, `users`, `views`, `watchdog`. List everything with `drush audit-list`.
