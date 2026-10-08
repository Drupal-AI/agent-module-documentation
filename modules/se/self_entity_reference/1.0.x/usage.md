<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Self Entity Reference adds a computed field that references an entity to itself.

---

Self Entity Reference implements `hook_entity_base_field_info` (via an `EntityTypeInfo` service and a computed `SelfEntityReferenceFieldItemList`) to add a read-only computed entity-reference field that points each entity back at itself. This is useful for Views relationships, tokens, or field formatters that expect an entity-reference field but where you simply want 'this entity'. Requires PHP 8.0+. No routes, no permissions, no configuration UI — the field is provided automatically.

---

- Reference an entity to itself via a computed field.
- Use an entity in contexts expecting an entity-reference.
- Build Views relationships back to the same entity.
- Expose the entity through reference-field formatters.
- Feed tokens/derived data from a self reference.
- Avoid storing a redundant self-reference value.
- Provide the field automatically on entity types.
- Keep the field read-only/computed.
- Work across content entity types.
- Run on Drupal 9.4, 10, and 11.
- Require no configuration to use.
- Rely on the class_resolver service pattern.
- Support PHP 8.0+ typing.
- Enable advanced Views/field setups.
- Reuse core entity-reference tooling.
- Add no security surface (no routes/permissions).
