<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `set_author` import processor

Source: `src/Plugin/EntityShareClient/Processor/SetAuthor.php`. A single
`entity_share_client` **ImportProcessor** plugin — there is no dedicated module settings page.

## Enabling & configuring

Configured **per import config**, not globally:

- Go to the Entity Share Client import config (admin UI at `admin/config/services/entity_share/import_config`,
  or the `import_config` config entities) and enable the **Set author** processor.
- Settings are stored in that import config's `import_processor_settings.set_author` key
  (the module ships no `config/install` or `config/schema` — the values live on the host `import_config`).

Plugin definition: `id = "set_author"`, runs in stage `process_entity` at weight **110**,
`locked = false` (can be turned on/off per import config).

### Settings keys (`defaultConfiguration()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `shared_author` | user id | anonymous (`0`) | Fallback author when the source author cannot be matched locally. Set via an `entity_autocomplete` user field (`include_anonymous = TRUE`, required). |
| `create_author` | bool | `FALSE` | If on, create a local user from the remote author's name/mail/status when no local match is found. |

## Author-resolution order (`processEntity()`)

For each imported content entity that has a `uid` relationship in the JSON:API payload:

1. **Local UUID match** — `getExistingEntities()` queries the `user` storage for a user whose `uuid`
   equals the source author's JSON:API id (`accessCheck(FALSE)`). If found, that uid is used.
   (Source id `"missing"` is skipped.)
2. **Remote lookup** — otherwise, if the payload has `relationships.uid.links.related.href`, it calls
   `getUserId()`, which does `remoteManager->jsonApiRequest()` (GET) against the remote user resource and:
   - returns the local uid found by `user_load_by_mail($attributes['mail'])`, else
   - by `user_load_by_name($attributes['name'])`, else
   - if `create_author` is on, `User::create(['name','mail','status'])` and `save()` (returns the new uid;
     a save exception is swallowed).
3. **Fallback** — if still unresolved, use the configured `shared_author` id.

The resolved id is written with `$processed_entity->set('uid', $author_id)` before the entity is saved.

## Notes

- The remote request uses the remote already configured on the Entity Share `RuntimeImportContext`
  (`getRemote()`) — Set Author does not add its own remote/endpoint configuration.
- Non-2xx remote responses, JSON:API `errors`, or a null `data` cause the lookup to return `FALSE`
  (→ fallback), so a broken/missing remote author never blocks the import.
- Upgrade hook `set_author_update_8001()` migrates the old `set_node_author` settings key to `set_author`
  on existing `import_config` entities.
