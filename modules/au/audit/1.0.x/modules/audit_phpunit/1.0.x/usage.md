DEV-only audit analyzer that inventories PHPUnit test structure/coverage for custom modules and optionally executes their unit tests.

---

audit_phpunit registers the `phpunit` AuditAnalyzer plugin (PhpunitAnalyzer). It scans custom modules for `tests/src/Unit`, `Kernel` and `Functional` test classes, scoring test health/coverage; when a phpunit binary (and PCOV/Xdebug) are available it can execute the Unit suite via Symfony `Process` (array-form, run in the config directory) and parse the JUnit/Clover output for pass/fail counts and coverage percentages. Kernel and Functional tests are listed but not executed. Configurable coverage thresholds, execution timeout, a phpunit config path and a module exclusion list. Marked experimental / [DEV ONLY].

---

- Inventory which custom modules ship Unit, Kernel and Functional tests.
- Score overall test coverage/health across the custom code base.
- Execute the Unit test suite from the audit UI when phpunit is installed.
- Measure code coverage via PCOV/Xdebug and compare against configurable thresholds.
- Flag modules below the `coverage_error_threshold` (default 30%) or warning threshold (50%).
- Point at a specific `phpunit_config` (phpunit.xml) when the default is not detected.
- Bound long runs with the `timeout` setting (default 120s).
- Exclude specific modules from analysis via `exclude_modules`.
- Cap displayed failures with `max_failures_display`.
- Identify modules with zero tests as refactoring/QA priorities.
- Disable coverage collection (`enable_coverage`) for a faster structure-only pass.
- Run headless via `drush audit:run phpunit` for a CI snapshot.
- Use test coverage as a maintainability indicator when taking over a project.
- Feed a weighted testing score into the overall Project Score.
- Distinguish executed Unit results from merely-listed Kernel/Functional suites.
