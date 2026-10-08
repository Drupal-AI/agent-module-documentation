<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: PHP CodeSniffer — the `phpcs` analyzer

`PhpcsAnalyzer` (`src/Plugin/AuditAnalyzer/PhpcsAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'phpcs', output_directory: 'phpcs', weight: 2)]`.

> **Experimental / [DEV ONLY].** Requires external tooling on the server and can be resource-intensive; not recommended for production.

## Install / enable

- Enable: `drush en audit_phpcs` (pulls in audit).
- Requirements (`checkRequirements()`): phpcs (drupal/coder: Drupal + DrupalPractice standards); phpcbf optional for auto-fix
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_phpcs registers the `phpcs` AuditAnalyzer plugin (PhpcsAnalyzer). It auto-detects the `phpcs`/`phpcbf` binaries (config override, composer `config.bin-dir`, `vendor/bin`, `bin/`), verifies the Drupal and DrupalPractice standards are installed and PHPCS-version-compatible, then runs PHPCS with `--report=json` across the `audit.settings` scan directories via Symfony `Process` (array-form command — no shell). Violations are counted, grouped by file and by sniff, scored with a penalty multiplier, and rendered as a faceted issue list; it also detects a project-level `phpcs.xml`/`phpcs.xml.dist` and reports whether it references the Drupal rulesets. Marked experimental / [DEV ONLY]; not for production.

### Scored checks (contribute to the score)
- `coding_standards` — Coding Standards

### Informational checks (no score)
- `analysis_summary` — Analysis Summary
- `project_config` — Project Configuration

## Configuration

Config object **`audit_phpcs.settings`** (defaults in `config/install/audit_phpcs.settings.yml`, schema in `config/schema/audit_phpcs.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `extensions` | `'php,module,inc,install,test,profile,theme,info,txt,yml'` |
| `min_severity` | `5` |
| `ignore_warnings` | `False` |
| `excluded_sniffs` | `{}` |
| `parallel` | `4` |
| `use_cache` | `True` |
| `max_violations_display` | `2000` |
| `report_width` | `120` |
| `show_sniff_codes` | `True` |
| `group_by_file` | `True` |
| `phpcs_binary_path` | `''` |
| `phpcbf_binary_path` | `''` |


## Operating it

- **UI**: `/admin/reports/audit/phpcs` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run phpcs --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters phpcs`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
