# Programmatic API

## Services
| Service id | Class | Purpose |
|---|---|---|
| `security_review` | `SecurityReview` | Central config/state helper: run checks, manage untrusted roles, skipping, logging, last-run. |
| `security_review.data` | `SecurityReviewData` | Site data helpers used by checks (server user/groups, permissions, kernel paths). |
| `plugin.manager.security_review.security_check` | `SecurityCheckPluginManager` | Discover/instantiate check plugins. |

## SecurityReview (service `security_review`)
Key methods:
- `runChecks(SecurityCheckInterface[] $checks, bool $cli = FALSE): void` — run (skips ones marked skipped).
- `storeResults(CheckResult[] $results): void`
- `getUntrustedRoles(): string[]` / `setUntrustedRoles(array $ids): void`
- `getSkipped(): array` / `isCheckSkipped(string $id): array` / `skip(string $id): void` / `enable(string $id): void` / `setSkipped(array): void`
- `getCheckSettings(string $id): array` / `setCheckSettings(string $id, array $values): void`
- `isLogging(): bool` / `setLogging(bool $on, bool $temporary = FALSE): void`
- `getLastRun(): int` / `setLastRun(int $ts): void`
- `cleanStorage()`, `setServerData()` (called on install/cron/uninstall bookkeeping).

## Plugin manager (`plugin.manager.security_review.security_check`)
- `getChecks(): SecurityCheckInterface[]` — all check instances, sorted (Security-Review namespace first, then by namespace/title).
- `getCheckById(string $id): ?SecurityCheckInterface`
- `getCheck(string $namespace, string $title): ?SecurityCheckInterface`
- `getDefinitions()` (inherited) — raw plugin defs.

## Run a check in code
```php
$manager = \Drupal::service('plugin.manager.security_review.security_check');
$review  = \Drupal::service('security_review');

$check = $manager->getCheckById('error_reporting');
$review->runChecks([$check], TRUE);

$result = $check->lastResult();          // ['result' => int, 'findings' => [...], 'time' => int, ...]
if ($result['result'] === \Drupal\security_review\CheckResult::FAIL) {
  // act on it
}
```

## CheckResult constants
`CheckResult::SUCCESS` (0), `FAIL` (1), `WARN` (2), `INFO` (3). A check's `lastResult()` returns the stored state array; the immutable `CheckResult` object carries `result()`, `findings()`, `time()`, `check()`.

Results are stored in **state** (`security_review.check.<id>.*`), not config. The module also exposes a Status Report entry (`hook_requirements`) that warns when any non-skipped check has failed or the checklist has never run.
