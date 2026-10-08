<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ray Debugger (ray_debugger) — agent index

**Development-only integration for the Spatie Ray app: `ray()` debugging for PHP, Twig, JS and AlpineJS.**

- **Version:** 1.0.x (1.0.4)
- **Core:** >=8.8 (PHP >=7.3)
- **Dependencies:** `spatie/ray` (Composer); submodules ray_debugger_twig / _js / _alpinejs

## Surface
- No routes, no permissions, no config entities.
- `ray_debugger_twig` — Twig `ray()` function (`RayTwigExtension`).
- `ray_debugger_js` / `ray_debugger_alpinejs` — attach client Ray libraries via `hook_page_attachments()` on **every** page.
- Behaviour is controlled by a project-root `ray.php` (`enable`, `host`, `port`; default `host.docker.internal:23517`).

**Security (dev-only tool — do not run on production):**
- No self-guard for environment: modules are active wherever enabled.
- `ray_debugger_js/ray_debugger_js.module:6-8` + `ray_debugger_js.libraries.yml:3` attach an **external CDN** script (`cdn.jsdelivr.net/npm/node-ray`) on all pages, incl. anonymous — a supply-chain/privacy exposure if left on in prod. `ray_debugger_alpinejs.module:6-8` similarly attaches on every page.
- Payloads go to the local Ray app over HTTP (not a remote SaaS) by default, but a `ray.php` `host` change could redirect them; any `ray()` left in code will leak whatever it is given.
- Mitigation: install with `--require-dev` and/or add to `$settings['config_exclude_modules']`.

See [api/usage.md](api/usage.md)
