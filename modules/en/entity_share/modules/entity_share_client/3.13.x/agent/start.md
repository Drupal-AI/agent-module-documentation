# entity_share_client — agent start

Submodule of **entity_share** (the **client** side). Defines the **`remote`** config entity (a
server's base `url` + an `auth` plugin) and the **`import_config`** config entity (an ordered
import-processor pipeline), plus the Pull form and Drush. Admin UI: **Config → Web services →
Entity Share → Remotes** (`entity.remote.collection`); pull at **Content → Entity Share**
(`/admin/content/entity_share`). Depends on core JSON:API + `entity_share`.

Full field lists, auth plugin ids, processor plugin ids, Drush, services, and create/read
snippets are in the parent docs:
- Config entities (`remote`, `import_config`) → [../../../../3.13.x/agent/configure/config-entities.md](../../../../3.13.x/agent/configure/config-entities.md)
- Services + plugin extension points → [../../../../3.13.x/agent/api/programmatic.md](../../../../3.13.x/agent/api/programmatic.md)

Quick create a remote:

```bash
drush php:eval '\Drupal::entityTypeManager()->getStorage("remote")->create([
  "id" => "hub", "label" => "Content hub",
  "url" => "https://hub.example.com",
  "auth" => ["pid" => "anonymous", "uuid" => "", "data" => []],
])->save();'
```

Plugin types it defines: `import_processor` (attribute `ImportProcessor`, base
`ImportProcessorPluginBase`, dir `Plugin/ImportProcessor/`), `client_authorization` (attribute
`ClientAuthorization`, ids `anonymous`/`basic_auth`/`header`/`oauth`), `import_policy`.
Permissions: `administer_remote_entity`, `administer_import_config_entity`,
`administer_import_status_entities`, `entity_share_client_pull_content`,
`entity_share_client_display_errors`.
