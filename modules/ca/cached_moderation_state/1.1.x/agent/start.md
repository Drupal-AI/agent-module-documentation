# Cached moderation state — agent index

Stores each moderated entity's Content Moderation state in a hidden, indexable field
`cached_moderation_state` so it can be queried/sorted/filtered cheaply. The field is added and
removed **automatically** for bundles as Content Moderation is enabled/disabled on them. Requires
`content_moderation` + `field`, PHP 8.1+.

- **How the field is auto-managed, the batch-update backfill form, the configure route** →
  [configure/setup.md](configure/setup.md)
- **The `cached_moderation_state` field type + the two services (field sync / batch update)** →
  [api/field-and-services.md](api/field-and-services.md)
- **Drush commands (`:update`, `:update-all`, `:sync-fields`, `:list-moderated-bundles`)** →
  [drush/commands.md](drush/commands.md)
- **Permission `access cached_moderation_state update_form`** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Field id/name: **`cached_moderation_state`** (field type `cached_moderation_state`, `no_ui`,
  cardinality 1, columns `value` + `updated`). Hidden from Field UI; UI access forbidden — read it
  in code (`$entity->cached_moderation_state->value`) or Views.
- `FieldConfigHandler::sync()` runs on module install and on `workflow` insert/update to create/
  delete the field per moderated bundle. You do NOT create the field yourself.
- Existing content needs a one-time back-fill via the batch form
  (`/admin/cached-moderation-state/update`) or `drush cached-moderation-state:update-all`.
