<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Log entity (`epsilon_harmony_log`)

Content entity defined in `src/Entity/EpsilonLogs.php`
(`@ContentEntityType id = "epsilon_harmony_log"`), base table **`epsilon_logs`**,
`admin_permission = "administer epsilon harmony"`, implements
`EpslionLogInterface` (extends `ContentEntityInterface`, `EntityOwnerInterface`). It is the
debug record written by `EpsilonApiFactory::logEpsilon()` after every Harmony API call. Not
fieldable via UI; created programmatically only (no add/edit/delete forms).

## Base fields (`baseFieldDefinitions()`)

| Field | Type | Meaning |
|---|---|---|
| `id` | integer | primary key, also the entity `label` key |
| `endpoint` | string(255) | API URL called |
| `uid` | entity_reference → user | current user at call time (`preCreate()` sets it) |
| `method` | string(255) | HTTP method (POST/PUT/GET/DELETE) |
| `status_code` | integer | HTTP status from the response |
| `status_message` | string(255) | reason phrase / fault string |
| `header` | string_long | request headers sent to Harmony |
| `request` | string_long | request payload sent |
| `response` | string_long | response body received |
| `created` | created | timestamp |

## Handlers, routes, links

- Only a **list_builder** handler: `Entity\Controller\EpsilonLogListBuilder`. No view/form/access
  handlers are declared; access falls back to the `admin_permission` and the route permissions.
- Links: `canonical = /admin/config/epsilon_harmony/logs/{epsilon_harmony_log}`,
  `collection = /admin/config/epsilon_harmony/logs`.
- Routes `epsilon_harmony.logs` (`_entity_list`) and `entity.epsilon_harmony_log.canonical`
  (`_entity_view`) both require permission **`view epsilon logs`**.

## List builder

`EpsilonLogListBuilder` columns: Log ID, Method, Endpoint, Status Code, Status Message, Created.
`getEntityIds()` queries with `accessCheck(FALSE)`, sorts by id DESC, pages 20 per screen.
`render()` prepends a description with a link to the clear-logs page. `getOperations()` adds a
single **View** operation linking to the canonical page.

## Clearing logs

`Form\ClearLogsForm` (`epsilon_clear_logs`, route `epsilon_harmony.clear_logs`, permission
`administer epsilon harmony`) is a `ConfirmFormBase`; on confirm it runs
`\Drupal::database()->truncate('epsilon_logs')->execute()` and redirects back to the logs list.
