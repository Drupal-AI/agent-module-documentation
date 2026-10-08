Audit analyzer that scores server/environment compatibility: PHP and database versions, PHP config and core requirements.

---

audit_status registers the `status` AuditAnalyzer plugin (StatusAnalyzer). It reports system information and scores the PHP version, key PHP ini settings (memory_limit, disabled functions, allow_url_fopen, etc.), the database engine version (queried via `SHOW VARIABLES` with a bound placeholder), database configuration, and Drupal core's own requirements/status report. Where the environment permits, it reads the running web-server version via static `shell_exec` probes (`nginx -v`, `apache2 -v`), gracefully reporting 'unknown' when `shell_exec` is disabled. Ships no config of its own.

---

- Check the PHP version against Drupal's supported/recommended range.
- Review key PHP ini settings (memory_limit, max_execution_time, disabled functions).
- Detect the database engine and version and whether it meets core requirements.
- Summarize Drupal core's own status-report warnings/errors as a scored section.
- Confirm the environment meets minimum system requirements before an upgrade.
- Identify a too-low memory_limit that will cause production failures.
- Report the running web-server (nginx/apache) version when detectable.
- Provide a quick environment snapshot when onboarding a new site.
- Verify allow_url_fopen and other flags needed by contrib/composer.
- Produce a weighted Status score feeding the overall Project Score.
- Run headless via `drush audit:run status --format=json`.
- Compare server baselines across a portfolio via DruScan.
- Flag an end-of-life PHP or database version needing an upgrade.
- Give ops teams an at-a-glance compatibility report without shell access.
- Degrade gracefully where `shell_exec` is disabled by `disable_functions`.
