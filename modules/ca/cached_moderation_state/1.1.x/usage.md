Cached moderation state stores each moderated entity's current Content Moderation state in a real, indexable field (`cached_moderation_state`) on the entity, so the moderation state can be queried, sorted, and filtered (e.g. in Views or entity queries) without the joins/computation the core `moderation_state` computed field requires.

---

The module automatically manages a hidden field named `cached_moderation_state` (a custom
`no_ui` field type of the same id) on every entity bundle that Content Moderation moderates. On
install, and via `hook_ENTITY_TYPE_insert/update()` for `workflow` config entities, its
`FieldConfigHandler::sync()` creates the field storage (locked) and a field instance on each
moderated bundle, and deletes instances from bundles that stop being moderated. The field's value
is kept in sync with the entity's real moderation state: the `CachedModerationStateItem` field
type recomputes its `value` (and an `updated` timestamp) from `$entity->moderation_state` on every
access/`preSave`, so newly saved entities always cache the right state. The field is hidden from
the Field UI (`HiddenFieldConfig` / `hook_entity_bundle_field_info_alter`) and access is forbidden
in the UI (`hook_entity_field_access`) — it is meant to be read programmatically or in Views only.
Because the field is added *after* content already exists, the module ships a **batch update** to
back-fill existing entities: a form at `/admin/cached-moderation-state/update` (route
`cached_moderation_state.batch_update_form`, permission `access cached_moderation_state update_form`)
and Drush commands (`cached-moderation-state:update`, `:update-all`, `:sync-fields`,
`:list-moderated-bundles`). The batch update sets the field without creating new revisions or
firing unwanted side effects (`BatchUpdateHandler`). Requires PHP 8.1+, `content_moderation`, and
`field`.

---

- Add a query-able moderation-state field so a View can filter nodes by "Draft" / "Published" / "Archived" efficiently.
- Sort a content admin View by moderation state using a real field instead of the computed one.
- Filter entity queries (`->condition('cached_moderation_state', 'draft')`) without loading each entity's workflow.
- Build a "needs review" dashboard that queries the cached state column directly.
- Expose moderation state to search indexing (e.g. Search API) as a stored field value.
- Avoid the performance cost of core's computed `moderation_state` on large listings.
- Automatically get the field on every bundle you enable Content Moderation for — no manual field creation.
- Automatically remove the field from a bundle when you stop moderating it.
- Back-fill the cached state for all existing content after installing the module (batch update form).
- Back-fill only specific bundles from the CLI: `drush cached-moderation-state:update node:article,node:page`.
- Back-fill every moderated bundle at once: `drush cached-moderation-state:update-all`.
- Re-initialize only entities whose cached field is still empty with the `--only-uninitialized` option.
- List all currently moderated bundles with `drush cached-moderation-state:list-moderated-bundles`.
- Repair/resynchronise the field instances if something goes wrong with `drush cached-moderation-state:sync-fields`.
- Read an entity's cached moderation state in code via `$entity->cached_moderation_state->value`.
- Keep the cached value correct automatically because it recomputes from `moderation_state` on save.
- Update non-default (pending) revisions' cached state during batch runs without spawning new revisions.
- Provide a stable, indexed column for reporting on editorial workflow progress.
- Drive conditional logic in custom code off a stored moderation state rather than recomputing it.
- Integrate moderation state into a data export/feed where a computed field is awkward to serialise.
- Give large multi-workflow sites a consistent, performant way to access moderation state everywhere.
