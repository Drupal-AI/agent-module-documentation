<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migration Decorator (migration_decorator) — agent index
**Decorates migration plugin discovery so definitions can be rewritten, derived further, or removed before alter hooks.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** drupal:migrate
- **Services:** `plugin.manager.migration_discovery_decorator` (default_plugin_manager); a `ServiceProvider` swaps `plugin.manager.migration` to wrap core discovery.
- **Plugin type:** `@MigrationDiscoveryDecorator` under `Plugin/migration_decorator/Decorator` — lowest weight wins.
- **Install:** `hook_install()` sets module weight to 1 (must load after Migrate Drupal's provider).
- **Routes / permissions / config:** none — code-only developer infrastructure.

**Security:** No routes, forms, permissions or user input; no web-facing surface. No security findings.

See [extend/decorators.md](extend/decorators.md)
