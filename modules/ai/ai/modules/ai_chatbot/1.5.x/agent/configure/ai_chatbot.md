# configure — place & configure the chatbot block

There is **no admin settings form** (`configure` in info.yml is null). Everything is
configured per-block through the core **Block layout** UI at
**/admin/structure/block** — place the **"AI DeepChat Chatbot"** block
(plugin id `ai_deepchat_block`, category *AI*) into a region, then edit its settings.

Prerequisites: enable `ai_chatbot` (pulls in `ai_assistant_api` + `ai` core), create at least
one **AI Assistant** at `/admin/config/ai/ai-assistant` (`entity.ai_assistant.collection`).
`league/commonmark` now ships with AI Core, so replies render as HTML out of the box.

## Chat Executor (new in 1.5.x)

The message flow is now routed through a **`ChatProcessor`** plugin (AI Core's plugin type),
chosen in the block form as the **"Chat Executor"** (`chat_processor_plugin`). This module
ships one executor, **`ai_assistant_api_processor`** (the default,
`DeepChatFormBlock::ASSISTANT_PROCESSOR_PLUGIN_ID`), which drives an `ai_assistant` entity.
The executor's own settings live under **`plugin_configuration`**; for the assistant executor
those are:

| plugin_configuration key | Meaning |
|---|---|
| `assistant_id` | **required** — id of the `ai_assistant` entity this widget uses |
| `stream_output` | stream tokens live (legacy/non-agent assistants) |
| `verbose_mode` | show per-step progress for agent-backed assistants |
| `show_structured_results` | show structured action results (legacy only) |

## Block settings (config schema `block.settings.ai_deepchat_block`)

| Key | Default | Meaning |
|---|---|---|
| `chat_processor_plugin` | `''` | the Chat Executor (`ChatProcessor` plugin id); default resolves to `ai_assistant_api_processor` |
| `plugin_configuration` | `[]` | the executor's config (holds `assistant_id` etc., see above) |
| `bot_name` | `Assistant` | display name of the bot |
| `bot_image` | module ai-icon svg | bot avatar image path/URL |
| `first_message` | `''` | intro message shown first (Markdown allowed) |
| `loading_message` | `''` | text while generating (only when verbose mode off; blank = animated ellipsis) |
| `agent_delegation_message` | `''` | message shown while an agent-backed turn is delegated |
| `use_username` / `default_username` | `false` / `''` | show logged-in username, else fallback name |
| `use_avatar` / `default_avatar` | `false` / `''` | show user's `user_picture`, else fallback avatar |
| `placement` | `toolbar` | `toolbar`, `bottom-right`, or `bottom-left` |
| `style_file` | `module:ai_chatbot:toolbar.yml` | a `deepchat_styles/*.yml` preset (hidden when placement=toolbar) |
| `width` / `height` | `500px` / `500px` | window size (forced to `100%`/`auto` for toolbar) |
| `collapse_minimal` | `false` | minimal toggle button when minimized (non-toolbar) |
| `expansion_method` | `expand` | toolbar only: `none`, `expand`, or `fullscreen` |
| `show_copy_icon` | `true` | copy-to-clipboard icon under each reply |
| `toggle_state` | `remember` | `remember`, `open`, or `close` on load |
| `stream` | `false` | stream tokens live — legacy assistants only (auto-disabled for agent-backed assistants) |
| `disable_csrf` | `false` | **frontend-only** flag (see note) |

**Deprecated/migrated keys:** `ai_assistant`, `verbose_mode`, `show_structured_results` are
now `type: ignore` in the schema — kept so pre-1.5 block config still validates, then folded
into `chat_processor_plugin` + `plugin_configuration` by
`ai_chatbot_post_update_chat_processor()` and dropped on the next save.

The block form still warns you to pick an appropriate **role/visibility** so anonymous users
don't reach restricted assistants. Legacy vs. agent assistant is detected from the assistant's
`ai_agent` field, which toggles which of the stream/verbose/structured options are shown.

## `disable_csrf` note

The "Disable CSRF Protection" checkbox only sets a `drupalSettings`/body flag read by the
frontend JS; the server route `ai_chatbot.api` still carries a static `_csrf_token: 'TRUE'`
requirement, so server-side CSRF validation is **not** actually switched off by this box.

## Runtime AJAX endpoints (not user-facing config)

| Route | Path | Notes |
|---|---|---|
| `ai_chatbot.api` | `/api/deepchat` | message POST, CSRF-protected |
| `ai_chatbot.session` | `/api/deepchat/session` | starts a session, returns the CSRF token |
| `ai_chatbot.reset_thread` | `/api/deepchat/reset` | POST, clears the active thread |
| `ai_chatbot.reset_conversation` | `/ajax/chatbot/reset-session/{assistant_id}/{thread_id}` | POST, clears a conversation |
| `ai_chatbot.message_skeleton` | `/ajax/chatbot/message-skeleton/{assistant_id}/{thread_id}/{user}` | renders a message skeleton (`access content`) |

All but `message_skeleton` require the **`access deepchat api`** permission — see
[permissions/ai_chatbot.md](../permissions/ai_chatbot.md).

## Legacy block

An older `ai_chatbot_block` ("AI Chatbot", form-based via `ChatFormBlock`) still exists for
backward compatibility; prefer `ai_deepchat_block` for new placements.
