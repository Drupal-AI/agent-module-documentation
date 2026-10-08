<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityLogic (entitylogic) — agent index

**Plugin framework that wraps entities in bundle-aware business-logic classes, resolved by `entity_type.bundle:selector` with `_fallback`.**

- **Version:** 1.0.x  •  **Core:** ^8 || ^9 || ^10 || ^11  •  Developer/API module (code-first)
- **API:** `entitylogic()` global function (returns manager / wraps entity / loads+wraps by ID(s) / empty instance); `EntityLogicManager` (`wrapEntity`, `wrapNew`, `wrapEmpty`, `provideWrap`, `selectPluginId`, `decodePluginId`). Plugin base `EntityLogicBase`, annotation `@EntityLogic`, dir `Plugin/EntityLogic`.
- **Twig:** `entitylogic(...)` function (`EntityLogicTwigExtension`).  **Views:** field plugin `MethodCall`.  **Drush:** generator `entitylogic.generator`.  **Tokens:** `entitylogic.tokens.inc`.
- **Submodule:** `entitylogic_ui` — routes `/admin/reports/entitylogic[/{plugin_id}]`, permission `entitylogic_ui view list`.
- **Security:** No runtime endpoints or mutations in the base module; the UI submodule's report routes are permission-gated (read-only listing). Note `EntityLogicManager::provideWrap()` runs entity queries with `accessCheck(FALSE)` (`EntityLogicManager.php:137`) — expected for a developer wrapper, but callers are responsible for enforcing access on results.

See [api/usage.md](api/usage.md)
