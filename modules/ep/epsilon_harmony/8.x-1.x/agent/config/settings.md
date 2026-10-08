<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Install/enable: `drush en epsilon_harmony -y` (pulls core `views`). All admin pages sit under
`/admin/config/epsilon_harmony` (menu links in `epsilon_harmony.links.menu.yml`, local tasks in
`epsilon_harmony.links.task.yml`). There is **no** `config/install` or `config/schema` shipped, so
all values start empty and are written by the forms below into config object
**`epsilon_harmony.settings`**.

## Routes & permissions (`epsilon_harmony.routing.yml`)

| Route | Path | Handler | Permission |
|---|---|---|---|
| `epsilon_harmony.admin_config` | `/admin/config/epsilon_harmony` | system menu block | `administer epsilon harmony` |
| `epsilon_harmony.configurations` | `/…/configurations` | `Form\ConfigForm` | `administer epsilon harmony` |
| `epsilon_harmony.list_configuration` | `/…/list_configuration` | `Form\ListConfiguration` | `administer epsilon harmony` |
| `epsilon_harmony.message_configuration` | `/…/message_configuration` | `Form\MessageConfiguration` | `administer epsilon harmony` |
| `epsilon_harmony.test` | `/…/test` | `Controller\EpsilonHarmonyController::testApi` | `administer epsilon harmony` |
| `epsilon_harmony.logs` | `/…/logs` | entity list | `view epsilon logs` |
| `entity.epsilon_harmony_log.canonical` | `/…/logs/{id}` | entity view | `view epsilon logs` |
| `epsilon_harmony.clear_logs` | `/…/logs/clear` | `Form\ClearLogsForm` | `administer epsilon harmony` |

Permissions (`epsilon_harmony.permission.yml`, both `restrict access: true`):
`administer epsilon harmony`, `view epsilon logs`.

## Connection settings — `Form\ConfigForm` (`epsilon_harmony_config_form`)

Writes these keys into `epsilon_harmony.settings`:

- `epsilon_harmony_client_id`
- `epsilon_harmony_secret_key`
- `epsilon_harmony_username`
- `epsilon_harmony_password`
- `epsilon_harmony_xouid`
- `epsilon_harmony_region` — select: `us` (label "US") or `eu` (label "Canada").

`EpsilonConnectionFactory::setApiBaseUrl()` maps the region to base URLs:
- `eu` → token `https://api-public.eu.epsilon.com`, api `https://api.harmony.eu.epsilon.com`
- otherwise → token `https://api-public.epsilon.com`, api `https://api.harmony.epsilon.com`

Each setter (`setUsername`, `setPassword`, `setClientId`, `setsecretKey`, `setXouid`) throws if
the value is empty, so all connection fields are required before any API call works.

## List identifiers — `Form\ListConfiguration` (`epsilon_harmony_list_form`)

Add rows mapping a **friendly List Identifier** → **Epsilon List ID**. Stored as a JSON string in
key `list_id_array`. "Add another list ID" (`epsilon_harmony_list_form_add_item`) rebuilds the
form with an extra row. `getlistId($key)` decodes this and throws on an unknown identifier.

## Message identifiers — `Form\MessageConfiguration` (`epsilon_harmony_message_form`)

Same pattern for **Message Identifier** → **Epsilon Message ID**, stored as JSON in key
`message_id_array`; resolved by `getmessageId($key)` for `sendMessage()`.

## Runtime state (not config)

`\Drupal::state()` holds `epsilon_harmony_access_token` and `epsilon_harmony_token_timeout`
(managed by `getToken()`; token cached ~1 hour).

## Test

The **Test** link (`EpsilonHarmonyController::testApi()`) calls `$service->testApi()` (forces a
fresh token) and redirects to the logs list so you can confirm the credentials work.
