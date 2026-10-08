<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chat Messenger — install, permissions, routes & settings

## Install / enable

`composer require drupal/chat_messenger` then enable it (pulls in `drupal/flag ^5.0`; core `user`/`file`/
`image` are hard deps). `hook_install()` (chat_messenger.install) imports the `chat_avatar` and
`chat_thumbnail` image styles and calls `_chat_messenger_ensure_chat_contact_flag()`, which creates the
`chat_contact` Flag entity that the contacts feature is built on. `hook_uninstall()` removes tables, config
and the flag. Attachments require a working **private file system** (`file_private_path` in settings.php);
avatars require the core **user picture** field.

## Permissions (`chat_messenger.permissions.yml`)

- `use chat messenger` — send/receive/view; needed for essentially every UI page and API endpoint.
- `create chat groups` — gates the "New group" action and `/chat-messenger/group/create`.
- `upload chat attachments` — gates the compose form's `managed_file` element (checked in
  `ChatMessageForm::buildForm()`).
- `administer chat messenger` — the settings form; declared `restrict access: true`.

## Routes (`chat_messenger.routing.yml`)

UI (permission `use chat messenger` unless noted): `/chat-messenger` (list), `/chat-messenger/new`
(+`/new/fragment` for the launcher), `/chat-messenger/start/{user}` (resolve-or-create a direct thread),
`/chat-messenger/conversation/{conversation}` (thread; `_custom_access` `ConversationAccessCheck`),
`/chat-messenger/group/create` (perm `create chat groups`), `/chat-messenger/conversation/{conversation}/manage`
(`GroupOwnerAccessCheck`), `/chat-messenger/contacts`, `/contacts/add`, `/blocked`, `/block/{user}`.

JSON/AJAX (all POST + `_csrf_request_header_token: 'TRUE'`, except `poll` which is GET): `/chat-messenger/poll`,
`/presence/heartbeat`, `/presence/status`, `/message/{message}/react` (`MessageAccessCheck`),
`/conversation/{conversation}/typing|mark-read|clear|delete` (`ConversationAccessCheck`),
`/conversation/{conversation}/older` (GET), `/contacts/request|remove|unblock/{user}`.

Admin form: `/admin/config/media/chat-messenger` (`chat_messenger.settings` route, perm `administer chat
messenger`). Menu links (`.links.menu.yml`) put "Chats"/"Contacts"/"Blocked users" under the `admin` menu and
the settings link under Configuration → Media; local tasks in `.links.task.yml`.

## Config object `chat_messenger.settings`

Schema `config/schema/chat_messenger.schema.yml`; install defaults `config/install/chat_messenger.settings.yml`.
Keys (default):

- `poll_max_wait` (10) — max seconds a single long-poll request blocks before returning.
- `poll_interval` (1) — seconds between update checks inside the wait loop.
- `poll_max_concurrent` (8) — max simultaneous long-poll connections (enforced by `ChatConcurrencyGuard`).
- `presence_online_threshold` (45) — seconds since last heartbeat within which a user counts as online.
- `presence_typing_expiry` (6) — seconds a typing indicator stays valid.
- `attachment_max_size` (5242880 bytes) — max upload size (also capped by PHP `upload_max_filesize`/`post_max_size`).
- `attachment_extensions` ('jpg jpeg png gif pdf doc docx txt') — space-separated allowed extensions.
- `quick_replies_enabled` (true) — show quick-reply chips when a message is read.
- `ai_suggestions_enabled` (false) — use `drupal/ai` for suggestions instead of the rule-based list.
- `ai_provider_model` ('') — the AI simple provider/model option, e.g. `openai__gpt-4o` (blank = none).
- `contacts_only_enabled` (false) — restrict *new direct* conversations to mutual contacts.

`SettingsForm` (`src/Form/SettingsForm.php`, extends `ConfigFormBase`) surfaces attachments, quick replies
and contacts. The AI provider select only appears if the `ai` module is installed (`$container->has('ai.provider')`);
it warns when the configured size exceeds the PHP limit, and requires a provider/model when AI suggestions are
enabled. Only attachment/quick-reply/contacts keys are written by the form; the poll/presence tuning keys are
config-only (edit via config import or drush `config:set`).

## Operating notes

- The floating launcher (`hook_page_bottom()`) appears on every page except the module's own routes, for users
  with `use chat messenger`; its cacheability varies by `user.permissions` + `route`.
- The long-poll endpoint returns HTTP 503 `{"retry":true}` when `poll_max_concurrent` is saturated — clients
  back off with jitter. On a small worker pool keep this well below your total PHP-FPM workers.
- "Clear chat" / "delete conversation" only move the calling member's own watermarks
  (`cleared_before_id` / `list_hidden_at`); message rows and other members' views are untouched.
