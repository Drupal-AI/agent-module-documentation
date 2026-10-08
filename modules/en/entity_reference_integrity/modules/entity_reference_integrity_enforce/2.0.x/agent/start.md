# Entity Reference Integrity Enforce — agent index

Consumes the base module's `entity_reference_integrity` handler to block deletion of
still-referenced entities, for the entity types you enable. Config route
`entity_reference_integrity_enforce.settings`; permission `administer entity reference
integrity enforce`.

- **Settings key, the four enforcement hooks, and the delete-action override** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Enabled types stored in `entity_reference_integrity_enforce.settings:enabled_entity_type_ids`
  (sequence of entity type ids; empty by default = nothing enforced).
- Enforcement: `hook_entity_predelete` throws `ProtectedEntityException`; `hook_form_alter`
  disables the delete form and lists referrers; `hook_entity_access` denies `delete` on
  `api_json` routes; `hook_action_info_alter` replaces core `entity:delete_action` with a
  guarded subclass.
- All paths defer to `EntityReferenceIntegrityEntityHandler::hasDependents()`.
