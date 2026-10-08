<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
pluggable Access Control Handler (pACH) lets modules influence any entity type's access checks through access plugins, without subclassing or overriding the entity's own access control handler.

---

Normally, changing an entity type's access logic means either implementing `hook_entity_access()` (limited) or replacing the entity's `access` handler class (invasive, one module wins). pACH decorates the core `entity_type.manager` service (`pach.entity_type.manager`, decoration priority 10) so that every entity type that defines an access control handler is swapped for pACH's `EntityAccessControlHandler`. That handler collects all access plugins registered for the entity type and lets each one contribute to the `AccessResultInterface` for `access`, `createAccess`, and `fieldAccess` operations.

Access plugins are defined with the `AccessControlHandler` attribute/annotation and discovered by the `plugin.manager.pach` manager; they extend `AccessControlHandlerBase` and override `access()`, `createAccess()`, and/or `fieldAccess()`, each receiving the running `AccessResult` by reference plus the entity, operation, and account. The bundled `pach_examples` submodule shows block and node examples. The module itself exposes no routes, permissions, or configuration — it is developer infrastructure. Security note: plugins can both grant and deny access, so a poorly written plugin could broaden access to an entity type; review custom plugins as security-sensitive code. Access results are combined with the normal Drupal access-result semantics.

---

- Add custom access logic to nodes without replacing the node access handler.
- Extend access control for taxonomy terms via a plugin.
- Control comment access with a pluggable handler.
- Adjust file/field access using a field-level access plugin.
- Let multiple modules each contribute to one entity type's access.
- Implement create access rules per bundle in a plugin.
- Override field access for specific fields via fieldAccess().
- Keep access logic in a plugin instead of a hook.
- Target any entity type that defines an access handler.
- Study the pach_examples submodule for reference plugins.
- Combine several access plugins for the same entity type.
- Return neutral/allowed/forbidden results per Drupal access semantics.
- Centralize access rules in versioned plugin classes.
- Avoid brittle service-class overrides of entity access.
- Apply workspace/content-moderation aware access rules (see tests).
- Unit/kernel test access plugins in isolation.
