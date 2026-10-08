DEV-only audit analyzer that runs PHPStan static analysis over custom code and classifies type errors, deprecations and undefined references.

---

audit_phpstan registers the `phpstan` AuditAnalyzer plugin (PhpstanAnalyzer). It auto-detects the `phpstan` binary and recommended extensions (e.g. mglaman/phpstan-drupal), writes a generated `.neon` config, and runs PHPStan via Symfony `Process` (array-form) over the `audit.settings` scan directories at the configured `level`. Results are bucketed into type errors, deprecation warnings and undefined references, each scored; it also reports the PHPStan environment and any project-level `phpstan.neon`/baseline. Configurable memory limit, ignore patterns, Drupal entity-mapping toggles and an error-type allow-list (`active_types`). Marked experimental / [DEV ONLY].

---

- Run PHPStan static analysis on custom modules/themes from the audit UI.
- Detect type errors, undefined method/property references and dead code paths.
- Track calls to deprecated Drupal APIs ahead of a major-version upgrade.
- Choose an analysis rule `level` (0-9) to match your code's maturity.
- Raise `memory_limit` for large codebases (default 512M).
- Skip deprecation, PHPDoc-type or entity-mapping checks via the `skip_*` toggles.
- Provide `custom_entity_mapping` so PHPStan understands your content-entity classes.
- Suppress known false positives with `ignore_errors` and report unmatched ignores.
- Restrict scoring to selected error types via `active_types`.
- Cap displayed errors with `max_errors_display`.
- Detect a project-level `phpstan.neon` and count baseline entries.
- Confirm mglaman/phpstan-drupal and other recommended extensions are installed.
- Use as an upgrade-readiness gate for AI-generated code.
- Run headless via `drush audit:run phpstan --filter="module:audit"` in CI.
- Feed a weighted static-analysis score into the overall Project Score.
