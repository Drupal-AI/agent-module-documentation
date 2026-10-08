# Entity Share config entities

Entity Share is driven by **config entities** defined in its submodules. The base module has
no config of its own. Enable the submodules first:

```bash
drush en entity_share_server -y   # server side → `channel`
drush en entity_share_client -y   # client side → `remote`, `import_config`
```

## `channel` (server) — `entity_share_server`

A Channel exposes one entity type + bundle + language as a JSON:API collection.
Admin: **Config → Web services → Entity Share → Channels** (`entity.channel.collection`).
Permission to manage: `administer_channel_entity`.

`config_export` keys (config prefix `entity_share_server.channel.<id>`):

| Key | Meaning |
|---|---|
| `id`, `label` | machine id + human label |
| `channel_entity_type` | entity type id exposed, e.g. `node` |
| `channel_bundle` | bundle id, e.g. `article` |
| `channel_langcode` | language, e.g. `en` |
| `channel_filters` | JSON:API filter conditions (sequence) |
| `channel_sorts` | sort definitions (sequence) |
| `channel_groups` | filter groups / conjunctions (sequence) |
| `channel_searches` | exposed search paths (sequence) |
| `channel_maxsize` | max page size |
| `access_by_permission` | bool: authorize any user holding the pull permission |
| `authorized_roles` | sequence of role ids allowed to read the channel |
| `authorized_users` | sequence of user UUIDs allowed to read the channel |

Create a channel with Drush:

```bash
drush php:eval '\Drupal::entityTypeManager()->getStorage("channel")->create([
  "id" => "articles_en",
  "label" => "Articles EN",
  "channel_entity_type" => "node",
  "channel_bundle" => "article",
  "channel_langcode" => "en",
])->save();'
```

Read one back:

```bash
drush php:eval '$c=\Drupal::entityTypeManager()->getStorage("channel")->load("articles_en");
print $c->get("channel_entity_type")."/".$c->get("channel_bundle");'
```

## `remote` (client) — `entity_share_client`

A Remote points at a server site's base URL and chooses an authorization plugin.
Admin: **Config → Web services → Entity Share → Remotes** (`entity.remote.collection`).
Permission to manage: `administer_remote_entity`.

`config_export` keys (config prefix `entity_share_client.remote.<id>`):

| Key | Meaning |
|---|---|
| `id`, `label` | machine id + human label |
| `url` | base URL of the remote server site, e.g. `https://server.example.com` |
| `auth` | mapping: `pid` (auth plugin id), `uuid`, `data` (credential provider + storage key) |

Auth plugin ids (`entity_share_client` ClientAuthorization plugins): `anonymous`, `basic_auth`,
`header`, `oauth`. Credentials are stored via the **Key** module (`data.credential_provider`
= `entity_share` or `key`, `data.storage_key` = the Key id).

Create a remote with Drush:

```bash
drush php:eval '\Drupal::entityTypeManager()->getStorage("remote")->create([
  "id" => "hub",
  "label" => "Content hub",
  "url" => "https://hub.example.com",
  "auth" => ["pid" => "anonymous", "uuid" => "", "data" => []],
])->save();'
```

## `import_config` (client) — `entity_share_client`

Assembles the **import-processor** pipeline that controls how pulled entities are created/updated
(config prefix `entity_share_client.import_config.<id>`). Keys: `id`, `label`, `import_maxsize`,
`import_processor_settings` (a sequence keyed by processor plugin id, each with per-stage
`weights` plus processor-specific settings). Manage at `entity.import_config.collection`,
permission `administer_import_config_entity`.

Notable import-processor plugin ids (from config schema): `default_data_processor` (import
`policy` + `update_policy`), `entity_reference` / `embedded_entity_importer`
(`max_recursion_depth`), `physical_file` (`rename`), `revision` (`enforce_new_revision`,
`translation_affected`, `revision_log_message`), `language_fallback` (`fallback_language`,
`force_language`), `path_alias_processor`, `link_internal_content_importer`, `changed_time`,
`skip_imported`, `book_structure_importer`.

## Pulling content (client)

- UI: **Admin → Content → Entity Share** (`/admin/content/entity_share`, route
  `entity_share_client.admin_content_pull_form`, permission `entity_share_client_pull_content`).
- Drush: the client submodule ships `entity_share:pull`-style commands
  (`Drupal\entity_share_client\Commands\EntityShareClientCommands`) — run `drush list --filter=entity_share`
  to see the exact command names on the installed version.

## Permissions

Server: `administer_channel_entity`, `entity_share_server_access_channels`.
Client: `administer_remote_entity`, `administer_import_config_entity`,
`administer_import_status_entities`, `entity_share_client_pull_content`,
`entity_share_client_display_errors`. Base: `entity_share_access_config_pages`.
