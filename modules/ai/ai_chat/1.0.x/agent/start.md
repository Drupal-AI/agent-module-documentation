<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Chat (ai_chat) — agent index

A floating, role-aware AI chat widget placed on the bottom-right of every page. A user's message is
POSTed to a controller that runs a configured **`ai_assistant`** entity through the
**`ai_assistant_api.runner`** service and returns the reply as JSON; a vanilla-JS widget renders it.

- **Depends on** `ai_agents`, `ai_assistant_api`, core `user` (package *AI Tools*). Core `^10.3 || ^11`,
  PHP `>=7.4`. Version **1.0.0-alpha6** (version dir `1.0.x`).
- **Provides no** entities, plugins, permissions, Drush commands, hooks beyond one, or config schema.
- All conversational behaviour, tools and agents come from the `ai_assistant` entity (defined by
  `ai_assistant_api`), not from this module.

## What it actually is (from source)

- **Routes** (`ai_chat.routing.yml`):
  - `ai_chat.settings` — `/admin/config/ai/ai-chat`, `_form: SettingsForm`,
    `_permission: 'administer site configuration'`. Config target for `configure`.
  - `ai_chat.send_message` — `/ai-chat/send`, POST, `_format: json`,
    `_controller: ChatController::send`. See [api/send-endpoint.md](api/send-endpoint.md) for its
    exact gate and behaviour.
- **Controller** `src/Controller/ChatController.php` — `send()` decodes the JSON body
  (`message`, `thread_id`, `assistant_id`), resolves the assistants the caller's roles allow, runs
  `ai_assistant_api.runner` (`setAssistant` → optional `setThreadsKey` → `setUserMessage` →
  `process`), and returns `{ ok, reply, thread_id }`.
- **Form** `src/Form/SettingsForm.php` (`ai_chat_settings_form`) — writes config object
  **`ai_chat.settings`**: `chat_title`, `primary_color`, and `role_assistants` (per-role
  `assistants[]` + `default_assistant`). No config schema ships for this object.
- **Hook** `ai_chat.module::ai_chat_page_attachments()` — attaches library `ai_chat/widget` and
  `drupalSettings.ai_chat` (endpoint URL, the assistant options allowed for the current user,
  default assistant, primary colour, title) on every page where the user has an allowed assistant.
  Helpers `_ai_chat_get_available_assistants()` / `_ai_chat_get_default_assistant()`.
- **Library** `ai_chat/widget` → `js/ai_chat.js` + `css/ai_chat.css`, depends on `core/drupal`,
  `core/drupalSettings`. The JS builds the widget DOM, POSTs via `fetch(..., credentials:
  'same-origin')`, and keeps thread id / open state / panel position in `localStorage`.
- **Menu** `ai_chat.links.menu.yml` — settings link under `ai.admin_settings`.

## Solution docs

- **Settings form, config object & role→assistant mapping** →
  [config/settings.md](config/settings.md)
- **The send endpoint, the widget JS, threads and how a message is processed** →
  [api/send-endpoint.md](api/send-endpoint.md)
