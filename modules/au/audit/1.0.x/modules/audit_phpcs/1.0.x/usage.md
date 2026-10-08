DEV-only audit analyzer that runs PHP_CodeSniffer (Drupal + DrupalPractice) over the configured scan directories.

---

audit_phpcs registers the `phpcs` AuditAnalyzer plugin (PhpcsAnalyzer). It auto-detects the `phpcs`/`phpcbf` binaries (config override, composer `config.bin-dir`, `vendor/bin`, `bin/`), verifies the Drupal and DrupalPractice standards are installed and PHPCS-version-compatible, then runs PHPCS with `--report=json` across the `audit.settings` scan directories via Symfony `Process` (array-form command — no shell). Violations are counted, grouped by file and by sniff, scored with a penalty multiplier, and rendered as a faceted issue list; it also detects a project-level `phpcs.xml`/`phpcs.xml.dist` and reports whether it references the Drupal rulesets. Marked experimental / [DEV ONLY]; not for production.

---

- Run Drupal + DrupalPractice coding-standards checks against custom modules/themes from the admin UI.
- Gate AI-generated or contributed code against Drupal.org coding standards before commit.
- Auto-detect the phpcs/phpcbf binaries or pin them via `phpcs_binary_path`/`phpcbf_binary_path`.
- Tune strictness with `min_severity` (1 strict … 10 critical-only).
- Exclude noisy sniffs (DocComment, FunctionComment, LineLength, etc.) via `excluded_sniffs`.
- Speed up large scans with `--parallel` (`parallel` setting) and result caching (`use_cache`).
- Cap UI output with `max_violations_display` and control report width.
- Show or hide sniff codes (`show_sniff_codes`) to aid exclusion configuration.
- See a per-file and per-sniff breakdown of the top violations.
- Detect whether the repo ships a `phpcs.xml` quality gate referencing Drupal/DrupalPractice.
- Report phpcbf availability so teams know if auto-fix is possible.
- Surface actionable install instructions when coder/standards are missing or incompatible.
- Run headless with `drush audit:run phpcs --filter="module:mymodule"` in CI.
- Produce a weighted coding-standards score feeding the overall Project Score.
- Diagnose incompatible drupal/coder vs PHP_CodeSniffer versions with an upgrade command.
