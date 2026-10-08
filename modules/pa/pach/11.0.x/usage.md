<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
pluggable Access Control Handler (pACH) lets modules influence any entity type's access checks through access plugins, without subclassing or overriding the entity's own access control handler. The 11.0.x branch targets Drupal 11 and 12.

---

Normally, changing an entity type's access logic means either implementing `hook_entity_access()` (limited) or replacing the entity's `access` handler class (invasive, one module wins). pACH decorates the core `entity_type.manager` service (`pach.entity_type.manager`, decoration priority 10, autowired) so that every entity type that defines an access control handler is swapped for pACH's `EntityAccessControlHandler`. That handler collects all access plugins registered for the entity type and lets each one contribute to the `AccessResultInterface` for `access`, `createAccess`, and `fieldAccess` operations. Results are cached per account and per entity/revision using a `:pach`-suffixed cache id so they do not collide with core's own access cache.

Access plugins are defined with the `AccessControlHandler` attribute (the legacy annotation still works but is deprecated in 11.0.0 and removed in Drupal 12) and discovered by the `plugin.manager.pach` manager; they extend `AccessControlHandlerBase`, implement `applies()` to gate when they run, and override `access()`, `createAccess()`, and/or `fieldAccess()`, each receiving the running `AccessResult` by reference plus the entity, operation, and account. The bundled `pach_examples` submodule shows block and node examples. The module itself exposes no routes, permissions, or configuration — it is developer infrastructure. Security note: plugins can both grant and deny access, so a poorly written plugin could broaden access to an entity type; review custom plugins as security-sensitive code. Access results are combined with the normal Drupal access-result semantics.

---

- Add custom access logic to nodes without replacing the node access handler.
- Extend access control for taxonomy terms via a plugin.
- Control comment access with a pluggable handler.
- Adjust file/field access using a field-level access plugin.
- Let multiple modules each contribute to one entity type's access.
- Implement create access rules per bundle in a plugin.
- Override field access for specific fields via `fieldAccess()`.
- Gate whether a plugin runs at all with `applies()`.
- Keep access logic in a plugin instead of a hook.
- Target any entity type that defines an access handler.
- Study the `pach_examples` submodule for reference plugins.
- Combine several access plugins for the same entity type, ordered by `weight`.
- Return neutral/allowed/forbidden results per Drupal access semantics.
- Centralize access rules in versioned plugin classes.
- Avoid brittle service-class overrides of entity access.
- Apply workspace/content-moderation aware access rules (see tests).
- Unit/kernel test access plugins in isolation.
- Migrate legacy `@AccessControlHandler` annotations to the PHP attribute for Drupal 12 readiness.
- Run pACH on Drupal 11 or 12 as a dependency-free access-extension layer.
