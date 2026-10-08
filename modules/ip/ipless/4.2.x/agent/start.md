<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Less (ipless) — agent index

Compiles `.less` files declared under a `less:` key in `*.libraries.yml` into CSS via the pure-PHP
`wikimedia/less.php` parser. Output goes to `public://ipless/`. Settings live on core's **Performance**
page (`system.performance` config, not a config entity of its own). One Drush command, one service, one
event, one hook. No permissions, no plugin types.

- **Enable/configure it, the four `system.performance` keys, declaring `less:` libraries** →
  [configure/performance-settings.md](configure/performance-settings.md)
- **Precompile from the CLI (`drush ipless:generate`)** → [drush/generate.md](drush/generate.md)
- **The `Ipless` service (`ipless.base`), the `ipless.force_rebuild` state key, the compilation event** →
  [api/service.md](api/service.md)
- **Altering Less parsing (`hook_less_alter`)** → [hooks/less-alter.md](hooks/less-alter.md)

Key facts: config keys are `system.performance` → `ipless.enabled`, `ipless.modedev`,
`ipless.sourcemap`, `ipless.watch_mode` (all booleans). `configure` route = `system.performance_settings`.
Compilation runs in `HtmlResponseIplessSubscriber` (priority 4 on `kernel.response`). Requires the
`wikimedia/less.php` PHP library (class `Less_Parser`); without it the module warns and does nothing.
