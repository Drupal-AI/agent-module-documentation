<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dex Console (dex_console) — agent index

**Provides a `dex` CLI binary that boots Drupal and auto-discovers Symfony Console commands (`#[AsCommand]`) from every module's `src/Command/` directory — a Drush-independent command framework.**

- **Version:** 1.1.x (info.yml version 1.1.0)
- **Core:** ^10.2 || ^11 (composer: ^10.3 || ^11); PHP 8.2+; requires `symfony/runtime`
- **Binary:** `bin/dex` (Composer bin → `vendor/bin/dex`); CLI-only, throws if not `cli` SAPI
- **Service:** `console.command_loader` — a `ContainerCommandLoader` built by `DexCompilerPass`
- **Service provider:** `DexConsoleServiceProvider` registers `DexCompilerPass` (priority 0); throws `LogicException` if the core `DexCompilerPass` exists (do not combine with the core patch)
- **Discovery:** classes under `<module>/src/Command/` carrying `#[AsCommand]` are auto-registered as public, autowired, `console.command`-tagged services
- **Routes / permissions / config:** none — no `.routing.yml`, `.permissions.yml`, `.links.*`, or config

**Security:** CLI-only framework; no web routes, no anonymous endpoints, no request-driven sinks. `bin/dex` refuses non-CLI SAPI. Privilege is equivalent to Drush — anyone able to execute the binary runs Drupal with full site rights; no additional finding.

See [drush/commands.md](drush/commands.md)
