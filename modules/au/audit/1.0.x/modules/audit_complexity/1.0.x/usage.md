[DEV ONLY] Scores code complexity (LOC, cyclomatic complexity, maintainability) and Drupal anti-patterns via phploc.

---

Experimental, dev-only analyzer `complexity` (`ComplexityAnalyzer`, weight 2). It shells out to the `phploc` binary (Symfony Process, array argv) over the configured `scan_directories` to compute complexity hotspots, a maintainability index, and detailed code metrics, and it statically detects Drupal anti-patterns (service locators, deep arrays, hardcoded IDs, direct DB queries). `checkRequirements()` returns actionable warnings when phploc is missing or incompatible (recommends the maintained fork `cmgmyr/phploc`). Not recommended for production.

---

- Identify the most complex functions (cyclomatic complexity hotspots) in custom code.
- Track a maintainability index per module/theme to prioritize refactoring.
- Detect Drupal anti-patterns: service locators, deeply nested arrays, hardcoded IDs, direct DB queries.
- Tune thresholds: `ccn_warning_threshold` (10), `ccn_error_threshold` (20), `deep_array_threshold` (5).
- Allow `\Drupal::` calls in procedural .module/.install files via `allow_service_locators_in_procedural`.
- Exclude or include test files with `include_tests`.
- Cap the hotspot list with `max_hotspots_display` (20).
- Filter findings to one module: `drush audit:run complexity --filter="module:mymodule"`.
- Requires phploc (`composer require --dev cmgmyr/phploc`); shows a requirements warning otherwise.
- Install only in dev/staging — it is resource-intensive.
