<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Development Mode turns a Drupal site into a development environment by being enabled: Twig debugging on, caches off, verbose errors, no aggregation — and it restores the previous settings when you uninstall it. It is emphatically not for production.

---

Rather than asking developers to hand-edit `settings.php` and `services.yml`, this module performs those edits itself. `hook_install()` first snapshots the current `system.performance` (css, js, cache) and `system.logging` (error_level) values into state under `dev_mode.config`, then sets CSS/JS aggregation and gzip off, page cache max-age to 0 and error reporting to `verbose`. It then tries to append an include of its own `settings.dev_mode.php` to the site's `settings.php`; that file adds `development.services.yml` to `$settings['container_yamls']` (enabling Twig debug/auto-reload, disabling the Twig cache, switching `cache.backend.null` in and turning on cacheability debug headers) and re-asserts the performance/logging overrides. If `settings.php` is not writable it falls back to editing `sites/default/services.yml` directly — chmodding `sites/default` to 0777, rewriting the twig flags, then chmodding back to 0555. At runtime the module attaches a small JS library and injects `Cache-Control: no-cache`, `Pragma: no-cache` and `Expires: 0` meta tags into every page. Uninstalling reverses all of it: config is restored from the state snapshot, the settings.php include is stripped, and the services.yml fallback edits are undone. The install message says it plainly: *"Do not enable on production sites!"*

---

- Put a local development site into debug mode with one module enable.
- Turn on Twig debugging without editing settings.php by hand.
- Disable render and page caching while developing a theme.
- Get verbose error messages with backtraces during development.
- Disable CSS/JS aggregation so assets are readable.
- Add cacheability debug headers to responses.
- Restore the previous performance settings automatically on uninstall.
- Standardise dev settings across a team without sharing settings files.
- Bring a new developer's environment up quickly.
- Avoid committing local settings overrides to the repository.
- Prevent browser caching during front-end work via no-cache meta tags.
- Switch a CI or review environment into debug mode temporarily.
- Diagnose a template selection problem with Twig debug comments.
- Turn off the Twig cache so template edits show immediately.
- Use the null cache backend to rule out caching bugs.
- Toggle development mode per environment by including the module conditionally.
- Keep the original settings safe in state while dev mode is on.
- Debug a caching issue with cacheability headers visible.
- Give designers an environment where CSS changes appear instantly.
- Remove all changes cleanly by uninstalling the module.
