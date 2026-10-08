<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Commander (content_commander) — agent index
**Declarative, dependency-aware content generation from PHP enums, executed via the Dex console.**

- **Version:** 1.0.x
- **Core:** `>=11` (PHP `>=8.3`)
- **Depends on:** `dex_console` (provides the `dex` console); also `nikic/php-parser`, `digilist/dependency-graph`, `symfony/console`.
- **Surface:** CLI only. No routing.yml, no permissions.yml, no web endpoints. Content is created by the auto-registered Dex command (`content-commander:create-all` and per-enum commands).
- **Author content as:** enum cases implementing `Drupal\content_commander\ContentInterface` (opt-in `ContentTrait`) in a module's `src/ContentCommander/`. Dependencies via `#[DependsOn(content, optional)]`. Optional stable `uuid()`; return `null` to store a UUID in `content_commander.content_mapping`.
- **Key classes:** `Command\CcCommand` (the console command), `ContentContext` (dependency access), `ContentRepository` (load a generated entity by enum).
- **Destructive flag:** `-d/--delete` deletes existing same-UUID entities before recreating — avoid in production.

**Security:** No web-facing routes or permissions; purely a developer/CLI tool run through the Dex console (requires shell access). No anonymous, mutating, or CSRF-relevant HTTP surface. The `-d` flag is destructive but console-only.

See [api/enums.md](api/enums.md).
