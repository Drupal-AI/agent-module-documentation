<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
APCu Diagnostics surfaces the bundled `apc.php` diagnostics UI from the `krakjoe/apcu` package as an admin report inside Drupal at `/admin/reports/apcu`.

---

APCu Diagnostics is a very thin integration layer: it registers a single admin report route and a
single controller that `require`s the `apc.php` script shipped in the `krakjoe/apcu` Composer
package (`vendor/krakjoe/apcu/apc.php`) and renders its output inside a Drupal page. That script is
the same APCu monitoring dashboard familiar from the APCu extension — memory usage, fragmentation,
hit/miss ratios, per-entry cache listings and refresh controls. The module does not implement any of
that itself; it only bridges apc.php into Drupal by overriding `$_SERVER['PHP_SELF']`, disabling
apc.php's own login (Drupal's route permission gates access instead) and including the script. It
ships one permission (`access apcu diagnostics`, marked `restrict access: true`), one route, one
menu link under *Reports*, and a functional access test. It has no config, no services, no schema,
no dependencies beyond Drupal core, and no submodules. The `krakjoe/apcu` package must be installed
via Composer for the page to render; if apc.php is missing the page shows a "file is missing"
message.

---

- View the APCu monitoring dashboard from within Drupal at `/admin/reports/apcu`.
- Inspect APCu shared-memory usage and free/used segments.
- Check APCu cache hit and miss counts and ratios.
- Monitor memory fragmentation of the APCu store.
- List cached APCu user-cache entries and their metadata.
- Diagnose whether APCu is enabled and sized correctly for the site.
- Tune `apc.shm_size` and related php.ini settings using live numbers.
- Troubleshoot APCu-backed cache backends (e.g. APCu as a fast cache bin).
- Give a diagnostics view to trusted administrators without giving them shell/CLI access.
- Reach the report through the *Administration → Reports → APCu diagnostics report* menu link.
- Grant the `access apcu diagnostics` permission to specific admin roles.
- Restrict the diagnostics page to trusted operators (permission is `restrict access: true`).
- Confirm APCu is actually serving cache before load testing.
- Watch APCu fill/eviction behaviour during traffic.
- Verify a Composer-installed `krakjoe/apcu` package is wired up correctly.
- Use apc.php's refresh/clear controls to reset APCu counters while investigating.
- Provide an in-browser alternative to CLI `apcu_cache_info()` calls.
- Support Drupal 9, 10 and 11 sites.
- Diagnose per-request opcode/user cache behaviour on a single web node.
- Keep the diagnostics behind Drupal's access system rather than apc.php's built-in password.
