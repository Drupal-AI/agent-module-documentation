<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ray Debugger integrates the Spatie Ray desktop debugging app into Drupal, exposing a `ray()` helper for PHP, Twig, JavaScript and AlpineJS.

---

The base module simply requires the `spatie/ray` Composer package, which provides the global `ray()` function; a `ray.php` config file at the project root controls where payloads go (host/port, default `host.docker.internal:23517`) and whether Ray is enabled at all. Three submodules extend it: `ray_debugger_twig` registers a Twig `ray()` function, while `ray_debugger_js` and `ray_debugger_alpinejs` attach client-side Ray libraries. Debug payloads are sent to the Ray *desktop app* over local HTTP — not to any Kontainer/SaaS endpoint — so nothing leaves the machine by default, though a misconfigured `ray.php` host could point elsewhere.

This is strictly a development tool and must not run on production. Two design points matter: the module has no environment guard of its own, and the JS submodules attach their libraries unconditionally on every page via `hook_page_attachments()` — `ray_debugger_js` even injects an external `cdn.jsdelivr.net/npm/node-ray` script on all pages (including anonymous front-end) whenever it is enabled. Leaving these modules on in production therefore both loads an external CDN script site-wide and lets any `ray()` calls left in code stream data to whatever the Ray host is set to. The README's guidance is to install via `--require-dev` and/or add it to `$settings['config_exclude_modules']` so it is never enabled on other environments. It defines no routes or permissions.

Set-up: require the module with Composer in dev, enable only the submodules you need, add a `ray.php` at the project root, and keep the Ray app running locally.

---

- Debug PHP variables from a preprocess or module hook with `ray($var)`.
- Colour-code and label Ray output (e.g. `ray($x)->purple()->label('...')`).
- Debug Twig variables in templates with the `ray()` Twig function.
- Debug JavaScript values in a Drupal behavior with `ray(settings)`.
- Debug AlpineJS state with `$ray(...)` in a template.
- Configure the Ray host/port and enable flag via a project-root `ray.php`.
- Disable all `ray()` output by setting `enable => false` in `ray.php`.
- Point Ray at a Docker/DDEV host via `host.docker.internal`.
- Install as a dev-only dependency with `composer require --dev`.
- Exclude the module from production via `$settings['config_exclude_modules']`.
- Enable only the Twig submodule if you only need template debugging.
- Enable the JS submodule to load node-ray for client-side debugging.
- Audit for the external jsdelivr node-ray script before enabling the JS submodule in any shared environment.
- Verify the module is NOT enabled on production before deploying.
- Send a raw-value dump to the Ray app for inspection during development.