<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chat Messenger — services, controllers & mechanism

No custom entities or config entities: everything is plain query-builder access over 8 tables
(`chat_messenger.install` `hook_schema()`). All services are in `src/Service/`; wiring in
`chat_messenger.services.yml`.

## Data model (tables)

`chat_conversation` (id, type `direct|group`, `direct_key` UNIQUE for pairs, title, timestamps, created_by) ·
`chat_conversation_member` (conversation_id+uid, is_owner, watermarks: `last_read_message_id`,
`last_delivered_message_id`, `cleared_before_id`, `list_hidden_at`) · `chat_message` (id, conversation_id,
uid, body, created) · `chat_message_attachment` (message_id → fid) · `chat_message_reaction` (message_id+uid
UNIQUE, emoji) · `chat_presence` (uid, last_seen, status, typing_conversation_id, typing_updated) ·
`chat_blocked_user` (blocker_uid+blocked_uid) · `chat_poll_slots` (single-row counter for concurrency).

## Services

- **ConversationManager** — create/load conversations & membership. `getOrCreateDirectConversation()` uses a
  canonical sorted `direct_key` + the UNIQUE constraint to resolve creation races; `assertMember()` throws
  `AccessDeniedHttpException`; `removeMember()` refuses to drop the last owner; `getUserConversations()` hides
  a member's "deleted" threads until new activity passes `list_hidden_at`.
- **MessageService** — `sendMessage()` (re-checks membership *and* block state server-side, so a stale/direct
  POST can't bypass the client-hidden compose form), history queries (`getMessagesBefore/After`, viewer-scoped
  by `cleared_before_id`), and forward-only `markDelivered()`/`markRead()` watermarks. `getMessageStatus()`
  drives sent/delivered/read ticks.
- **PresenceService** — heartbeat, online threshold, typing set/clear/query, and manual status. `setStatus()`
  whitelists against `STATUSES` (`available|busy|away`) and throws on anything else.
- **ReactionService** — `toggleReaction()` (one reaction per user per message via UNIQUE key; re-selecting
  removes) and grouped summaries (`getSummaries()` aggregates count + is_own).
- **BlockService** — directional rows, but `isBlocked()` matches either direction (bidirectional effect);
  only the blocker can `unblock()`.
- **ContactService** — mutual contacts on the `chat_contact` Flag: a one-way flag is a pending request, the
  reverse flag accepts it; blocked users can't become contacts.
- **AttachmentService** — `getUploadValidators()` returns D10.2+/11 constraint keys `FileExtension` +
  `FileSizeLimit` from config; `attachToMessage()` marks the file permanent + registers file usage;
  `getConversationIdForFile()` backs the download access hook. Storage: `private://chat_messenger`.
- **MessageRenderer** — renders messages/reaction fragments via the `chat_message` /
  `chat_message_reactions` themes with `renderInIsolation()`, so both the compose-form AJAX response and the
  poll delta emit identical server-escaped HTML; clients only ever inject rendered markup.
- **ChatPollService** — pure (no loops/HTTP), computes `checkForUpdates()`: new messages, typing users,
  reaction changes, and per-conversation/total unread counts, returning plain data for the controller to render.
- **ChatConcurrencyGuard** — atomic counting semaphore over the `chat_poll_slots` row: `tryAcquire()` does a
  conditional `count = count+1 WHERE count < max`; `release()` decrements with a `count > 0` guard.
- **SuggestionService** / **AiSuggestionClient** — quick replies. `SuggestionService` matches ordered regex
  RULES (with a default set) and caches AI results per message id; `AiSuggestionClient` calls the `drupal/ai`
  provider (`@?ai.provider`, NULL when the module is absent) with a structured-JSON schema and returns NULL on
  any failure so the caller falls back to rule-based replies. No direct outbound HTTP here — the `ai` module
  owns provider credentials and transport.

## Controllers (`src/Controller/`)

- **ConversationController** — list, single thread (`conversation()` renders the last 50 messages, header,
  compose form, quick replies; `#cache max-age 0`), user picker (incl. a cache-bypassing fragment for the
  launcher), `startDirect()` (block + contacts-only guarded), `olderMessages()` (AJAX paging).
- **PollController** — `poll()` is the bounded long-poll: acquires a concurrency slot (503 if full), registers
  a `register_shutdown_function` release so the slot frees on any termination, loops `checkForUpdates()` every
  `poll_interval` up to `poll_max_wait`, marks delivered, and returns rendered message/reaction HTML as a
  plain `JsonResponse` (bypassing the render/page-cache pipeline). Also `heartbeat()`, `setStatus()`,
  `react()`, `typing()`, `markRead()` (scopes the client-supplied `upto_id` by conversation before using the
  message for suggestions), `clearHistory()`, `deleteConversation()`.
- **ContactController** — contacts list, browse-to-add, blocked list, and AJAX request/remove/unblock.

## Forms (`src/Form/`)

`ChatMessageForm` (AJAX compose; `submitForm()` does the real send so it works JS-off, `send()` only builds
the AJAX append), `CreateGroupForm` / `GroupManageForm` (checkbox member lists; both re-validate block state
server-side as defense in depth), `BlockUserForm`, `SettingsForm`.

## Hooks (`src/Hook/ChatMessengerHooks.php`, attribute `#[Hook(...)]`)

- `page_bottom` — injects the `chat_launcher` for permitted users off the module's own routes, with correct
  `user.permissions` + `route` cache metadata.
- `file_download` — for a file this module attached, returns download headers only if the current user is a
  member of the owning conversation, `-1` otherwise, NULL for files it doesn't own (private:// stays deny-by-default).

## Frontend

`js/chat_messenger.js` (long-poll client, quick replies via `textContent`, message/reaction HTML via
`insertAdjacentHTML` on server-rendered fragments), `js/emoji_picker.js`, `js/chat_launcher.js`. Libraries use
only core (`drupal`, `drupalSettings`, `once`) — no CDN or third-party JS. Templates in `templates/` autoescape
message body, sender name, filenames and emoji.
