<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chat Messenger (chat_messenger) — agent index

Self-hosted **1:1 and group chat between site users**, delivered by **AJAX long-polling** (no WebSocket
server, Node.js or Redis). Reactions, presence, typing indicators, read receipts, contacts/blocking and
**private file attachments**. Package `Communication`. Version **1.1.4**. Core `^10.3 || ^11`.

- **Dependencies:** core `user`, `file`, `image`, and **`drupal/flag` `^5.0`** (contacts are Flag flaggings).
  Suggested only: `drupal/ai` `^1.4` (AI quick replies — never required; `@?ai.provider` is optional-injected).
- **No custom entities.** State lives in 8 plain DB tables (`hook_schema()` in `chat_messenger.install`):
  `chat_conversation`, `chat_conversation_member`, `chat_message`, `chat_message_attachment`,
  `chat_message_reaction`, `chat_presence`, `chat_blocked_user`, `chat_poll_slots`.
- **Config:** one config object `chat_messenger.settings` (schema in `config/schema/`), admin form at
  `/admin/config/media/chat-messenger`. Ships two image styles: `chat_avatar`, `chat_thumbnail`.

## Solution docs

- **Install, permissions, routes, config settings, operating it** → [config/settings.md](config/settings.md)
- **Services, controllers, access checks, long-poll mechanism, rendering, hooks** → [api/architecture.md](api/architecture.md)

## What it provides (from source)

- **Permissions** (`chat_messenger.permissions.yml`): `use chat messenger`, `create chat groups`,
  `upload chat attachments`, `administer chat messenger` (restricted).
- **Routes** (`chat_messenger.routing.yml`): UI pages (`/chat-messenger`, `/new`, `/conversation/{id}`,
  `/group/create`, `/conversation/{id}/manage`, `/contacts`, `/blocked`, `/block/{user}`) and JSON/AJAX
  endpoints (`/poll`, `/presence/heartbeat`, `/presence/status`, `/message/{message}/react`,
  `/conversation/{id}/typing|mark-read|clear|delete`, `/contacts/request|remove|unblock/{user}`). Every
  mutation endpoint requires `_csrf_request_header_token: 'TRUE'`; per-conversation/-message routes use
  custom access checks (see below).
- **Access checks** (`src/Access/`): `ConversationAccessCheck` (member-only), `GroupOwnerAccessCheck`
  (group owners), `MessageAccessCheck` (member of the message's conversation). All `setCacheMaxAge(0)`.
- **Services** (`chat_messenger.services.yml`): `ConversationManager`, `MessageService`, `PresenceService`,
  `ReactionService`, `BlockService`, `ContactService`, `AttachmentService`, `MessageRenderer`,
  `ChatPollService`, `ChatConcurrencyGuard`, `SuggestionService`, `AiSuggestionClient`, plus the hook class
  `Hook\ChatMessengerHooks`.
- **Hooks** (`ChatMessengerHooks`, attribute-based): `hook_page_bottom()` injects the floating launcher;
  `hook_file_download()` gates private attachment downloads to conversation members. `hook_theme()` is in
  `chat_messenger.module` (8 templates in `templates/`).
- **Libraries** (`chat_messenger.libraries.yml`): `chat_messenger`, `launcher`, `emoji_picker`,
  `chat_shared` — plain JS/CSS, only core deps (`drupal`, `drupalSettings`, `once`). No CDN, no vendored libs.
- No Drush commands. No plugin types. No config entities.
