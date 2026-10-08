Upgrade Status scans a Drupal site's installed modules, themes, and environment and reports what must be fixed before a major-version upgrade (e.g. Drupal 10 → 11), flagging deprecated API use, outdated `info.yml` metadata, and environment requirements.

---

Upgrade Status gives site owners a single readiness dashboard at **Reports → Upgrade status** (`/admin/reports/upgrade-status`). It groups all projects into custom and contributed code, checks whether contrib projects have a compatible release available, and runs a static analysis (PHPStan with `phpstan-drupal` and the deprecation rules) over custom and contrib code to detect deprecated Drupal API calls, deprecated Twig, libraries, theme functions, routes, CSS, and `.info.yml` metadata problems. Results are bucketed into "fix now", "fix later", "uncategorized", "ignore", and (with drupal-rector) auto-fixable groups, each pointing at the exact file and line. It also audits the runtime environment — PHP version, database type/version, deprecated core extensions — against the target Drupal version's requirements. Findings can be exported as HTML or ASCII for sharing, and the whole scan can be driven from the CLI via Drush (`upgrade_status:analyze` / `upgrade_status:checkstyle`) for CI pipelines. Two alter hooks let other modules add batch operations (such as running Rector) or reshape the per-project result build. It depends only on core's Update module and its Composer-installed PHPStan toolchain; it changes nothing on the site — it is a read-only analysis tool.

---

- Check whether a site is ready to upgrade from Drupal 10 to Drupal 11.
- Get a single dashboard listing every module/theme and its upgrade status.
- Detect deprecated Drupal API calls in custom code before they break.
- Scan contributed modules for deprecated code and metadata issues.
- See which contrib projects already have a compatible release available.
- Identify which projects have no compatible update yet (blockers).
- Find deprecated Twig syntax and filters in custom templates.
- Detect deprecated `#theme` functions and theme hooks.
- Flag deprecated asset libraries and `libraries.yml` problems.
- Catch deprecated route definitions and controllers.
- Detect deprecated CSS and config schema usage.
- Verify `*.info.yml` files declare a correct `core_version_requirement`.
- Audit the PHP version against the target Drupal core's requirements.
- Check the database engine and version for upgrade compatibility.
- Spot deprecated or removed core modules still enabled on the site.
- Export a full readiness report as HTML to share with stakeholders.
- Export an ASCII report for pasting into tickets or emails.
- Run the whole analysis headlessly in CI with `drush upgrade_status:analyze`.
- Produce checkstyle/codeclimate output for CI gating with `upgrade_status:checkstyle`.
- Re-use previous scan results with `--skip-existing` to speed up repeat runs.
- Limit scans to custom, contrib, or a specific ignore-list of projects.
- Tune scan batch size via the `paths_per_scan` setting for large codebases.
- Integrate drupal-rector to auto-generate patches for fixable deprecations.
- Prioritize remediation using the "fix now" vs "fix later" grouping.
- Track upgrade progress by re-scanning after fixes are applied.
- Estimate the effort of a major upgrade before committing to it.
- Add a custom batch operation to the scan via `hook_upgrade_status_operations_alter()`.
- Alter or annotate per-project results via `hook_upgrade_status_result_alter()`.
