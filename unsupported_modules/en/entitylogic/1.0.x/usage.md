<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EntityLogic is a developer framework for wrapping entities in bundle-aware business-logic objects, so per-type/per-bundle behaviour lives in dedicated classes instead of scattered hooks.
---
You define `EntityLogic` plugins (annotation-based, IDs shaped as `entity_type`, `entity_type.bundle`, or with a `:selector` suffix) extending `EntityLogicBase`. The `EntityLogicManager` resolves the most specific plugin for a given entity/bundle/selector (falling back to `_fallback`), instantiates it, and injects the entity; a static instance cache keyed by UUID keeps one stateful object per entity. The magic `entitylogic()` function is the main entry point: with no args it returns the manager; given an entity (and optional selector) it wraps it; given `type:selector` plus an ID / array of IDs / null it loads-and-wraps, wraps-many, or returns an empty instance. A `provideWrap()` helper does get-or-create.

The same `entitylogic()` function is exposed to Twig as a function, so templates can call typed methods on the wrapped entity, and a Views field plugin (`MethodCall`) can render the result of a logic method in a View. A Drush generator (`drush generate` → EntityLogic) scaffolds new logic classes, and there is a `token_info` integration plus an `entitylogic_ui` submodule that lists registered logic classes at `/admin/reports/entitylogic` (permission `entitylogic_ui view list`). This is code-first infrastructure: it has no configuration UI in the base module and no runtime endpoints.
---
- Encapsulate per-bundle business logic in dedicated classes
- Call `entitylogic($node)->someMethod()` from PHP
- Resolve the most specific logic class for an entity + bundle
- Use a `:selector` to switch logic variants for the same bundle
- Provide a `_fallback` logic class for unmatched entities
- Wrap many entities at once by passing an array of IDs
- Get a stateful, UUID-cached logic instance per entity
- Create-or-fetch an entity with `provideWrap()`
- Call typed logic methods from Twig via the `entitylogic()` function
- Render a logic method's result as a Views field (MethodCall)
- Scaffold a new EntityLogic class with the Drush generator
- Expose computed values as tokens through the token integration
- List registered logic classes at /admin/reports/entitylogic (UI submodule)
- Replace ad-hoc entity hooks with OOP logic objects
- Build an empty logic instance to create new entities from
- Centralise validation/derivation logic per content type
- Share one logic instance across render, token and Views calls
- Keep templates thin by moving computation into logic classes
