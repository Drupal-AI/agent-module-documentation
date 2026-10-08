<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AuditAnalyzer plugin type

Every audit check is an `AuditAnalyzer` plugin. The base `audit` module defines the type; submodules
provide instances under their `src/Plugin/AuditAnalyzer/`.

## Discovery

- Attribute: `Drupal\audit\Attribute\AuditAnalyzer` (`#[\Attribute(TARGET_CLASS)]`, extends core
  `Plugin`). Fields: `id` (string, required), `label`, `description`, `menu_title` (all
  `TranslatableMarkup`), `output_directory` (string|null), `weight` (int, default 3 — the default
  Project-Score multiplier, 0–5).
- Manager: `AuditAnalyzerPluginManager` (`plugin.manager.audit_analyzer`, `parent:
  default_plugin_manager`) scans `Plugin/AuditAnalyzer`, interface `AuditAnalyzerInterface`,
  attribute `AuditAnalyzer`, alter hook `audit_analyzer_info`, cache key `audit_analyzer_plugins`.

## Interface (`AuditAnalyzerInterface`) / base (`AuditAnalyzerBase`)

Base extends `PluginBase implements AuditAnalyzerInterface, ContainerFactoryPluginInterface`. Its
`create()` injects `audit.component_builder` into `$this->ui`; subclasses override `create()` to add
`configFactory`/`moduleHandler`/`entityTypeManager`/`database` (declared protected on the base).

Required to implement:
- `analyze(): array` — returns `['_files' => [...sections...], 'score' => ['factors' => [...]]]`.
- `getAuditChecks(): array` — check definitions keyed by check id; each has `label`, `description`,
  `affects_score` (bool), `weight`, `file_key`, `score_factor_key`, `file_types`, optional
  `extra_file_keys`.
- `buildCheckContent(string $check_id, array $data): array` — render array for one section.

Optional (base has defaults):
- `buildConfigurationForm(array $config): array` — settings-page fields (default `[]`).
- `processConfigurationValue(string $key, mixed $value): mixed` — transform before save.
- `checkRequirements(): array` — return warning strings when an external tool is missing (used by
  the dev-only analyzers: phpcs/phpstan/phpunit/complexity/duplication).
- `label()`, `description()`, `getOutputDirectory()` — read from the plugin definition.

## Result shape

- `analyze()` output: `_files[section] = createResult($items, $errors, $warnings, $notices)` where
  each `$item = createResultItem($severity, $code, $message, $details)`. `score.factors[key] =
  ['score' => 0-100, 'weight' => int, 'label' => ..., 'description' => ...]`.
- `AuditAnalyzerBase::buildDetailedResults()` iterates `getAuditChecks()`, calls
  `buildCheckContent()` per section, sorts (scored sections first, then by severity), and wraps each
  in `$this->ui->section(...)` with a score circle + counter badges.
- Sections with `affects_score: TRUE` render faceted issue lists
  (`$this->ui->buildIssueListFromResults(...)`); informational sections use tables
  (`$this->ui->table/header/row/cell`). Always include `tags` in issue items for filtering.

## Score flow

`AuditRunner::runAnalyzer()` calls `analyze()`, normalizes to an AI-optimized structure (findings +
weighted `total`/`grade`), and — for scored runs — persists the score via `AuditScoreStorage`
(State keys `audit.score.<id>`, index `audit.scores.index`). The weighted **Project Score**
(`audit.project_score`) is recalculated from all stored scores using per-analyzer `multipliers`
config (falling back to the attribute `weight`); multiplier 0 excludes an analyzer.

## Path helpers (file-based analyzers)

`AuditAnalyzerBase` provides `extractModuleOrThemeFromPath()`, `extractModuleTypeFromPath()`
(custom/contrib), and `buildModuleCustomData()` so code analyzers tag each finding with its
module/theme machine name — used by the Drush `--filter="module:<name>"` and the UI facets.

## Minimal example

```php
#[AuditAnalyzer(id: 'example', label: new TranslatableMarkup('Example'), weight: 3)]
final class ExampleAnalyzer extends AuditAnalyzerBase {
  public function analyze(): array {
    $items = [$this->createResultItem('warning', 'EX_CODE', 'Message', ['identifier' => 'x'])];
    return [
      '_files' => ['main' => $this->createResult($items, 0, 1, 0)],
      'score' => ['factors' => ['main' => ['score' => 80, 'weight' => 100, 'label' => 'Main']]],
    ];
  }
  public function getAuditChecks(): array {
    return ['main' => ['label' => $this->t('Main'), 'affects_score' => TRUE, 'weight' => 100,
      'file_key' => 'main', 'score_factor_key' => 'main']];
  }
  public function buildCheckContent(string $check_id, array $data): array {
    return $this->ui->buildIssueListFromResults($data['_files']['main']['results'] ?? [], 'OK', fn($i, $ui) => [
      'severity' => $ui->normalizeSeverity($i['severity']), 'code' => $i['code'],
      'label' => $i['message'], 'tags' => ['example'],
    ]);
  }
}
```

The submodule `.info.yml` must declare `dependencies: [audit:audit]`. Optional per-analyzer settings
live in `config/install/<module>.settings.yml` + `config/schema/...`; the base settings form picks up
`buildConfigurationForm()` output automatically.
