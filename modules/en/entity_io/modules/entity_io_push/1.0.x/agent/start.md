<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO Push (entity_io_push) — agent index

Submodule of **Entity IO**. Pushes entities as JSON to another Drupal site over Basic Auth and
receives pushed JSON. Depends on `basic_auth`, `entity_io`. Core `^10 || ^11`. `configure` route
`entity_io_push.settings`. Ships permissions (`entity_io_push.permissions.yml`); config install
`node_json_push.settings` (empty `servers`). No config schema, no new plugin type.

## Mechanism (from source)

- **`JsonPushService`** (`src/Service/JsonPushService.php`, `@http_client`, `@config.factory`,
  logger): `push($json, $server_name, $format)` looks up the server in
  `entity_io_push.settings.servers`, builds headers (Content-Type / Content-Encoding per format +
  parsed `Key: Value` custom headers), and POSTs to `$server['url'] . <receiver route>` with Guzzle
  Basic `auth` (15s timeout).
- **Deploy forms** (`src/Form/DeployEntity*Form.php`) — one per entity type; export the entity and
  call the push service.
- **`JsonReceiverController::receive`** (`src/Controller/JsonReceiverController.php`) — the endpoint
  on the receiving site: decodes/decompresses the body, validates with
  `JsonValidate::validateEntity`, and imports via `entity_io.entity_importer`
  (`EntityImporter::import`), returning the created entity's URL/type/id.
- **`SettingsForm`** (`src/Form/SettingsForm.php`) — manages the `servers` list (url/user/password/
  headers).

## Routes & permissions

| Route | Path | Permission / auth |
|---|---|---|
| `entity_io_push.settings` | `/admin/config/entity-io/services/servers` | `administer site configuration` |
| `entity_io_push.receive_json` | `POST /entity-io/push/importer` | `entity_io push receive json` (restricted) + `_auth: [basic_auth]` |
| `entity_io_push.deploy_node` | `/node/{node}/deploy` | `entity_io push deploy node` |
| `entity_io_push.deploy_comment` | `/comment/{comment}/deploy` | `entity_io push deploy comment` |
| `entity_io_push.deploy_term` | `/taxonomy/term/{taxonomy_term}/deploy` | `entity_io push deploy taxonomy term` |
| `entity_io_push.deploy_user` | `/user/{user}/deploy` | `entity_io push deploy user` |
| `entity_io_push.deploy_media` | `/media/{media}/deploy` | `entity_io push deploy media` |
| `entity_io_push.deploy_block` | `/block/{block_content}/deploy` | `entity_io push deploy block` |

Permissions in `entity_io_push.permissions.yml`; `entity_io push receive json` is marked
`restrict access: TRUE`.
