<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & Drush export

There is **no admin settings form and no exported config** (the module ships no `config/` directory —
`configure` is `null`, `provides_config_schema` is `false`). All non-UI behaviour is driven by a
`settings.php` array plus one Drush command.

## `$settings['graphql_export']` (settings.php)

Keyed by **GraphQL server machine id**. Read via `Settings::get('graphql_export', [])` in both the
controller and the Drush command.

```php
$settings['graphql_export'] = [
  'my_server' => [
    'graphqls' => '../schema.graphqls',   // path/stream to write the SDL
    'json' => '../schema.json',           // path/stream to write introspection JSON
    'skip_config_export' => FALSE,        // TRUE = do not auto-export on config:export
  ],
];
```

Per-server keys:

- `graphqls` — destination for the SDL file. Any path/stream URI writable by Drupal (e.g.
  `private://…`, `../schema.graphqls`).
- `json` — destination for the introspection JSON file.
- `skip_config_export` — when truthy, the `config:export` post-command hook skips this server (manual
  `graphql-export:schema` still exports it).

If a value is a directory, the writer appends `<server_id>.graphqls` / `<server_id>.json`
(`GraphqlExportCommands.php:162 writeFile()`). A failed `file_put_contents` throws
`RuntimeException`, caught per server and logged as an error.

## Drush

Service `graphql_export.commands` (`drush.services.yml`, tag `drush.command`) →
`Drupal\graphql_export\Commands\GraphqlExportCommands` (arg `@graphql_export.service`).

### `graphql-export:schema [server_ids] [--type=…]`

Manual export (`exportCommand`, `GraphqlExportCommands.php:79`).

- `server_ids` — optional, comma-separated (`my_server,and_another`). Omitted = **all** servers
  (`Server::loadMultiple(NULL)`).
- `--type` — `graphqls` or `json`. Omitted = both.
- Per server, the destination is `$settings['graphql_export'][id]['graphqls'|'json']` if set,
  otherwise defaults to **`private://<id>.graphqls`** / **`private://<id>.json`**.

```
drush graphql-export:schema                       # all servers, both formats
drush graphql-export:schema --type=graphqls       # all servers, SDL only
drush graphql-export:schema --type=json my_server # one server, JSON only
```

### `@hook post-command config:export`

`postCommand()` (`GraphqlExportCommands.php:41`) runs automatically after `drush config:export`
(`cex`). It loads only the servers named in `$settings['graphql_export']`, skips any with empty
config or `skip_config_export`, and writes each server's `graphqls`/`json` files. This lets the
schema travel with configuration in version control and appear in PR diffs. Inputs are the trusted
`settings.php` array and the site's own server config — no request/user input is involved.
