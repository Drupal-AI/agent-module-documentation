<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pluggable Access Control Handler (pach) — agent index

**Decorates `entity_type.manager` so any entity type's access is handled by pACH's handler, which delegates to tagged access plugins.**

- **Version:** 11.0.x
- **Core:** `^11 | ^12`
- **Depends:** none
- **Services:** `pach.entity_type.manager` (decorates `entity_type.manager`, priority 10, `autowire: true`); `plugin.manager.pach` (plugin manager, `parent: default_plugin_manager`).
- **Plugin type:** `AccessControlHandler` (Attribute preferred; Annotation still works but is **deprecated in 11.0.0**, removed in Drupal 12), base `AccessControlHandlerBase` with `access()`, `createAccess()`, `fieldAccess()`; example plugins in `pach_examples`.
- **Routes / permissions / config:** none.

**Security:** developer infrastructure with no HTTP surface of its own (no routes, no permissions, no config, no forms). Access plugins can both grant and deny access, so a custom plugin can widen access to an entity type — treat plugin code as security-sensitive and review it. See [plugins/access-plugin.md](plugins/access-plugin.md). No module-level findings.

## Diff 10.3.x → 11.0.x

Major bump; the plugin API and runtime behavior are unchanged, so existing access plugins keep working. Changes:

- **Core requirement:** `^10.3 | ^11` → `^11 | ^12`. **BC break — drops Drupal 10 support.** `composer.json` now requires `drupal/core: ^11 || ^12`.
- **Annotation deprecated:** `\Drupal\pach\Annotation\AccessControlHandler` (the legacy `@AccessControlHandler` doc-comment annotation) now triggers `E_USER_DEPRECATED` and is removed in Drupal 12. Migrate plugins to the PHP `#[AccessControlHandler(...)]` attribute. The attribute class is unchanged (`id`, `type`, `weight`).
- **Handler constructor:** `EntityAccessControlHandler` now also receives a serialization service (`serialization.phpserialize`) via `createInstance()` (extra constructor argument); no behavioral change for callers.
- **Decorator wiring:** `pach.entity_type.manager` is now declared with `autowire: true` and an explicit argument list (inner service, namespaces, module handler, discovery cache, translation, class resolver, last-installed-schema repository, service container).
- Unchanged: plugin discovery under `Plugin/pach`, `AccessControlHandlerBase` method signatures, per-account/per-entity access caching with the `:pach` cache-id suffix, and the `pach_examples` submodule.
