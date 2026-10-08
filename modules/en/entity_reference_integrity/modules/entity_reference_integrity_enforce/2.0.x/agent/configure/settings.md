# Entity Reference Integrity Enforce — configuration & enforcement

## Settings

- Route `entity_reference_integrity_enforce.settings` →
  `/admin/config/content/entity-reference-integrity` (permission
  `administer entity reference integrity enforce`, `restrict access: true`).
- Form `SettingsForm` lists every entity type as checkboxes and saves the ticked ids to
  config `entity_reference_integrity_enforce.settings:enabled_entity_type_ids`
  (schema: sequence of strings; **empty on install** → nothing is protected until you enable
  types).

Set it with Drush:

```bash
drush config:set entity_reference_integrity_enforce.settings \
  enabled_entity_type_ids.0 taxonomy_term -y
```

Only entity types present in `enabled_entity_type_ids` are enforced; all others delete normally.

## The four enforcement points (`entity_reference_integrity_enforce.module`)

| Hook / alter | Effect |
|---|---|
| `hook_entity_predelete` (`EntityPredelete`) | Hard backstop: throws `ProtectedEntityException` if an enabled, still-referenced entity is being deleted — catches *any* code path incl. raw `$entity->delete()`. `hook_module_implements_alter` forces this to run first. |
| `hook_form_alter` (`FormAlter`) | On any entity **delete** form for an enabled, referenced entity: removes `actions.submit` + description, shows an error message and an item list of referencing entities (first 10 per type; each shown only if the user has `view label` access; adds "Access to some entities is restricted." otherwise). Adds the config as a cacheable dependency. |
| `hook_entity_access` | For `delete` operation on routes whose `_format` is `api_json` (JSON:API), returns `AccessResultForbidden` with the reason string when the referenced entity has dependents. (REST/GraphQL are noted as `@todo`, not yet covered.) |
| `hook_action_info_alter` | Replaces core `entity:delete_action` class with `Plugin\Action\DeleteAction`, whose `access()` first runs the core check, then `orIf(forbiddenIf($hasDependents))` — so VBO/bulk deletes are blocked too. |

All four resolve dependents through the base handler:
`\Drupal::entityTypeManager()->getHandler($type, 'entity_reference_integrity')->hasDependents($entity)`.

## Notes

- The predelete exception is thrown, not caught — callers of `delete()` on protected entities
  must expect a `ProtectedEntityException`.
- Reference queries run with `accessCheck(FALSE)` (in the base handler), so protection does not
  leak based on the acting user's access; only the *listing* of referrers respects `view label`.
