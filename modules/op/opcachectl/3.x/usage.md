OPcache Control lets Drupal administrators inspect PHP OPcache statistics and configuration and reset the opcode cache from the admin UI or from an external control route for deploy automation.

---

OPcache Control (`opcachectl`) surfaces PHP's Zend OPcache inside Drupal. It replaces core's single "PHP OPcode caching" status-report line with two richer report pages — live statistics (memory, hit rate, interned strings, restart state, cached-script counts) at `/admin/reports/opcache` and the full directive dump at `/admin/reports/opcache/config`. It adds a confirm form at `/admin/config/system/opcache/reset` that calls `opcache_reset()` and a JSON "control" route at `/system/opcache*ctl` for tooling: GET returns status, POST (`/system/opcachectl/reset`) and PURGE reset the cache. The control route is intended for CI/CD deploy hooks that must clear the compiled opcode cache on each web node after a code push, and its access is governed by an IP allowlist (`$settings['opcachectl_reset_remote_addresses']`) and/or a shared token (`$settings['opcachectl_reset_token']`) defined in `settings.php`. Two permissions — "Access PHP OPcache statistics" and "Reset PHP OPcache" — gate the human-facing report and reset pages. The module has no dependencies beyond Drupal core 10/11 and the Zend OPcache PHP extension.

---

- View live PHP OPcache statistics (used/free/wasted memory, hit rate, cached keys/scripts) at `/admin/reports/opcache`.
- Inspect the full set of active OPcache directives (`opcache.*` ini values) at `/admin/reports/opcache/config`.
- See a human-readable, byte-formatted view of `opcache.memory_consumption`, `opcache.jit_buffer_size` and `opcache.max_file_size`.
- Reset (flush) the opcode cache from the admin UI through a confirmation form after deploying updated code.
- Trigger an OPcache reset on each web node from a CI/CD pipeline via an HTTP POST or PURGE to `/system/opcachectl/reset`.
- Restrict the control route to specific deploy hosts with `$settings['opcachectl_reset_remote_addresses'] = ['10.0.0.5', ...]` in `settings.php`.
- Allow token-authenticated resets from anywhere with `$settings['opcachectl_reset_token'] = '<random-32-char-value>'` and `?token=<value>`.
- Query current OPcache status as JSON (GET `/system/opcachectl`) for external monitoring/health dashboards.
- Detect and warn admins when OPcache is disabled, its cache is full, or a restart is pending/in progress.
- Replace core's terse OPcache requirement line with a richer runtime requirements entry (via `hook_requirements`).
- Confirm from the status report page whether remote reset is enabled and from which addresses/token.
- Grant an ops/deployer role the "Reset PHP OPcache" permission without giving full site-admin rights.
- Grant a read-only monitoring role the "Access PHP OPcache statistics" permission to view (not reset) cache health.
- Add a "Reset PHP OPcache" action link and local tabs (Statistics / Configuration) to the reports UI.
- Log every reset event (with hostname) to the `opcachectl` Drupal logger channel for audit/troubleshooting.
- Diagnose "changes not taking effect after deploy" by confirming the opcode cache was actually flushed.
- Free wasted OPcache memory when `cache_full` is reported without restarting PHP-FPM.
- Reformat cache size values with the `format_size` Twig filter and probe value types with the `of_type`/`get_type` Twig helpers in custom OPcache templates.
- Integrate OPcache resets into blue/green or rolling deploys by hitting the control route on each node in turn.
- Use the status JSON endpoint to assert (in a smoke test) that OPcache is enabled and healthy post-deploy.
- Provide operators a single Drupal page to check whether JIT is enabled and how the buffer is sized.
- Verify interned-strings usage and adjust `opcache.interned_strings_buffer` based on the reported figures.
