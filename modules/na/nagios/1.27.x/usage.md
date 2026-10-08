<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nagios Monitoring exposes a plain-text status page that Nagios, Icinga, or any HTTP monitor can poll to check a Drupal site's health (cron, watchdog errors, pending updates, requirements), plus Drush commands for the same checks.

---

The module registers a dynamic status-page route (default path `/nagios`) whose controller (`StatuspageController`) returns a single-line, `text/plain` health summary in the format the bundled `nagios-plugin/check_drupal` script parses. The endpoint is **disabled by default** (`nagios.settings` → `statuspage.enabled: false`) and must be turned on; access is authorized when the request's HTTP User-Agent equals the configured `nagios.ua` (default `Nagios`), or a `?unique_id=` GET parameter matches it (when `statuspage.getparam` is on), or the current user has `administer site configuration` — otherwise it returns an `UNKNOWN`/"Unauthorized" line. The page aggregates results from every module implementing `hook_nagios()` plus the module's own built-in checks (`function.cron`, `function.watchdog`, `function.maintenance`, `function.requirements`), each returning an OK/Warning/Critical/Unknown state whose numeric codes are configurable. You can restrict output to one module by requesting `/nagios/<module>/<id>`. Settings live at `/admin/config/system/nagios` (permission `administer site configuration`), with a second "Ignored modules" form (permission `administer nagios ignore`) to exclude modules from update reporting. Config also controls `min_report_severity`, cron duration thresholds, and whether experimental/deprecated modules and themes raise warnings. Drush commands `nagios`, `nagios-list`, and `nagios-updates` (via `NagiosCommands`) run the same checks from the CLI/cron and exit with the Nagios severity code. Other modules extend it by implementing `hook_nagios()` (do the check) and `hook_nagios_info()` (add a toggle on the settings page).

---

- Expose a `/nagios` status page for a Nagios or Icinga server to poll a Drupal site's health.
- Alert operations when cron has not run within the configured duration.
- Warn when new errors appear in the watchdog (dblog) log.
- Report Critical when the site is in maintenance mode.
- Surface failing core "Status report" requirements as monitoring alerts.
- Detect pending module/theme security or feature updates via `nagios-updates`.
- Authorize monitoring requests by a shared User-Agent string instead of a login.
- Use a `?unique_id=` GET token for monitors that cannot set a custom User-Agent.
- Run health checks from cron with `drush nagios` and act on its exit code.
- List all available checks with `drush nagios-list`.
- Restrict the status output to a single module via `/nagios/<module>`.
- Add a custom application health check by implementing `hook_nagios()`.
- Give a custom check an on/off toggle on the settings page with `hook_nagios_info()`.
- Exclude noisy or third-party modules from update reporting on the "Ignored modules" form.
- Tune alert thresholds by remapping the OK/Warning/Critical/Unknown status codes.
- Set `min_report_severity` so only problems at/above a level are reported.
- Warn about installed experimental modules or deprecated modules/themes.
- Monitor a fleet of Drupal sites from one Nagios/Icinga instance using the bundled check_drupal plugin.
- Integrate Drupal health into an existing NRPE / remote plugin setup.
- Keep the endpoint private by leaving it disabled and enabling only for known monitors.
- Filter which watchdog channels count toward alerts (e.g. ignore "access denied").
- Gate access to the "Ignored modules" configuration with the `administer nagios ignore` permission.
- Feed the plain-text output into a custom uptime dashboard or scraper.
- Check a specific hook-provided identifier by requesting `/nagios/<module>/<id>`.
- Return performance ('perf') data points alongside state checks for later processing.
