# Ray Debugger — manual setup guide

**Ray Debugger** (`ray_debugger`) integrates the
[Spatie Ray](https://myray.app/) desktop debugging app into Drupal. Ray gives
you a clean, unified console on your own machine where you can inspect variables
from **PHP, Twig, JavaScript, and AlpineJS** — all in one place, colour-coded and
labelled — instead of scattering `var_dump()` and `console.log()` across your
code.

The base module simply requires the `spatie/ray` Composer package, which provides
the global `ray()` helper function. A small `ray.php` config file at your project
root controls where debug payloads are sent (host and port, defaulting to
`host.docker.internal:23517` for Docker/DDEV setups) and whether Ray is enabled
at all. Debug data is sent to the Ray desktop app over local HTTP — it is not
sent to any cloud/SaaS service by default, so nothing leaves your machine unless
you point the `host` somewhere else.

Three optional submodules extend the base:

- **`ray_debugger_twig`** — registers a `ray()` function you can call inside Twig
  templates.
- **`ray_debugger_js`** — attaches a client-side Ray library so you can call
  `ray()` from JavaScript.
- **`ray_debugger_alpinejs`** — attaches the AlpineJS Ray helper so you can use
  `$ray(...)` in Alpine components.

> **Development only — never enable on production.** The module has no
> environment guard of its own, so it is active wherever it is enabled. Two things
> matter especially: the JS submodules attach their libraries on **every** page
> (including anonymous front-end pages), and **`ray_debugger_js` loads an external
> script from a CDN (`cdn.jsdelivr.net/npm/node-ray`)** on all pages when enabled
> — a supply-chain and privacy exposure if left on in production. Any `ray()`
> calls left in your code will also stream whatever they are given to the Ray
> host. Install it as a dev-only dependency and/or exclude it via
> `$settings['config_exclude_modules']` so it can never be enabled elsewhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (dev), enable
   only the submodules you need, and add a `ray.php`.

This module has **no configuration page** in the Drupal admin UI. Its behavior is
controlled entirely by the `ray.php` file at your project root (see below); it
defines no routes and no permissions.

## How to use it

1. Keep the **Ray desktop app** running on your machine.
2. Add a `ray.php` file at your project root to set the host/port and the enable
   flag. For example:

   ```php
   <?php
   return [
     'enable' => true,
     'host' => 'host.docker.internal',
     'port' => 23517,
   ];
   ```

   Setting `enable => false` (or omitting the file) turns every `ray()` call into
   a harmless no-op.
3. Debug from wherever you need it:
   - **PHP** — `ray($variables)->purple()->label('HTML variables');`
   - **Twig** (with `ray_debugger_twig`) — `{{ ray(view_mode, 'label', 'The current view mode') }}`
   - **JavaScript** (with `ray_debugger_js`) — `ray(settings)` inside a behavior.
   - **AlpineJS** (with `ray_debugger_alpinejs`) — `x-on:click="$ray(message)"`.

Only enable the submodules you actually use, and only in development. Remember
that leftover `ray()` calls will fatal if the underlying library is absent, so
guard or remove debug code before deploying.
