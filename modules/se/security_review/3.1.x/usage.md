Security Review automates checking many of the configuration mistakes that lead to an insecure Drupal site, running a checklist of security checks and reporting pass/fail/warning results in the admin UI, on the status report, and via Drush.

---

Security Review provides a checklist of ~20 plugin-based security checks (file permissions, text/input formats, PHP execution in the files directory, error reporting, private files location, database query errors, failed logins, allowed upload extensions, dangerous permissions granted to untrusted roles, trusted host settings, temporary files, views access, HTTP security headers, admin user naming, and more). You mark which roles are "untrusted" (anonymous/authenticated by default) since most checks only care whether a resource is reachable by untrusted users. Run the checklist from Reports → Security Review, or headlessly with `drush secrev` for CI pipelines. Each check yields a result integer (success/fail/warning/info) plus findings that are stored in Drupal state and rendered with per-check help and evaluation detail. Checks can be individually skipped ("hushed") once they have been run, and certain checks let you hush specific findings (individual files, views, upload extensions, fields, or headers) through the settings form. The module also surfaces a Status Report (`hook_requirements`) entry warning when checks have failed or never been run, and can optionally log every check run to watchdog. It is extensible: any module can add its own check by defining a `SecurityCheck` plugin, and several internal lists (unsafe tags, unsafe extensions, ignored files, temporary files) are alterable. Note the module raises awareness of issues — it does not itself fix or harden anything; you act on the findings manually.

---

- Run a one-off security audit of a Drupal site's configuration before launch.
- Add automated security checks to CI/CD via `drush secrev` (non-zero exit when a check fails).
- Detect when error reporting is writing errors to the screen (information disclosure).
- Verify the private files directory is located outside the web root.
- Check that PHP cannot be executed from the public files directory.
- Audit which text/input formats are usable by untrusted roles and whether they allow unsafe HTML tags.
- Flag dangerous permissions (e.g. administer-level) granted to untrusted roles.
- Detect overly permissive file/directory permissions on the Drupal install.
- Verify `trusted_host_patterns` is configured in settings.php.
- Check allowed upload file extensions for dangerous types.
- Monitor for excessive failed login attempts.
- Detect database query errors that may indicate SQL injection probing.
- Check for a leftover admin user literally named "admin".
- Audit Views for access controls left open to untrusted users.
- Check that recommended HTTP security headers are present.
- Confirm cron has run recently (`last_cron_run` check).
- Verify the Composer vendor directory is not web-accessible.
- Detect temporary files left in the file system.
- Warn site admins from the Status Report when security checks are failing or have never run.
- Log each security check run to watchdog for audit trails.
- Mark specific roles as untrusted to tune what the checklist evaluates.
- Skip (hush) checks that don't apply to a given site so they stop failing the run.
- Hush individual findings (specific files, views, fields, extensions, or headers) without disabling a whole check.
- Extend the checklist with a custom `SecurityCheck` plugin for project-specific policies.
- Alter built-in lists (unsafe tags/extensions, ignored files) via `hook_..._alter` for site-specific needs.
- Run only a subset of checks with `drush secrev --check=...` or exclude some with `--skip=...`.
- Store the latest results with `drush secrev --store` and re-print them later with `--lastrun`.
