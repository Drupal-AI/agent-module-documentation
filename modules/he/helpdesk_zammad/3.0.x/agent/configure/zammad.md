<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zammad plugin — configuration

Configured through **Helpdesk Integration**: create a helpdesk entity and pick plugin **Zammad**. The plugin's `buildConfigurationForm()` (`settingKeys()`) exposes:

- `url` (`#type url`) — Zammad instance base URL.
- `api_token` (`#type textfield`) — Zammad API token. **Stored plaintext** in config; no Key-module integration. Restrict who can edit helpdesk entities.
- `group` — default group new tickets file under.
- `state_closed` — which Zammad state = closed (options fetched live from `TICKET_STATE`).
- Chat fieldset: `chat_id`, `chat_debug`, `chat_show`, `chat_label`, `chat_fontsize`.

## Client
`ZammadClientFactory::create($url, $httpToken)` → `new ZammadAPIClient\Client(['url'=>…, 'http_token'=>…])`. No TLS override; cert verification is the HTTP client's default. `getClient(..., $user)` may `setOnBehalfOfUser()` so tickets are created as the mapped remote user.

## Chat widget
If any Zammad instance has a `chat_id`, `HelpdeskZammadHooks::libraryInfoAlter()` appends `<url>/assets/chat/chat.min.js` to the `chat` library and `pageBottom()` attaches it with `drupalSettings.helpdesk_zammad_chat` (id, fontsize, show, debug, label).

## Sync operations
`createIssue` (ticket), `addCommentToIssue` (article), `resolveIssue` (closed state), `pushUser` (upsert customer), `getAllIssues($helpdesk,$user,$since)` (pull tickets+articles+attachments; `$since>0` → `search('updated_at>Y-m-d')`).
