# configure — place & configure the chatbot block

There is **no admin settings form** (`configure` in info.yml is null). Everything is
configured per-block through the core **Block layout** UI at
**/admin/structure/block** — place the **"AI DeepChat Chatbot"** block
(plugin id `ai_deepchat_block`, category *AI*) into a region, then edit its settings.

Prerequisites: enable `ai_chatbot` (pulls in `ai_assistant_api` + `ai` core), create at least
one **AI Assistant** at `/admin/config/ai/assistants` (`entity.ai_assistant.collection`), and
`composer require league/commonmark` so replies render as HTML instead of raw Markdown.

## Block settings (config schema `block.settings.ai_deepchat_block`)

| Key | Default | Meaning |
|---|---|---|
| `ai_assistant` | `null` | **required** — id of the `ai_assistant` entity this widget uses |
| `bot_name` | `Assistant` | display name of the bot |
| `bot_image` | module ai-icon svg | bot avatar image path/URL |
| `first_message` | `''` | intro message shown first (Markdown allowed) |
| `loading_message` | `''` | text while generating (only when verbose mode off; blank = animated ellipsis) |
| `use_username` / `default_username` | `false` / `''` | show logged-in username, else fallback name |
| `use_avatar` / `default_avatar` | `false` / `''` | show user's `user_picture`, else fallback avatar |
| `placement` | `toolbar` | `toolbar`, `bottom-right`, or `bottom-left` |
| `style_file` | `module:ai_chatbot:toolbar.yml` | a `deepchat_styles/*.yml` preset (hidden when placement=toolbar) |
| `width` / `height` | `500px` / `500px` | window size (forced to `100%`/`auto` for toolbar) |
| `collapse_minimal` | `false` | minimal toggle button when minimized (non-toolbar) |
| `expansion_method` | `expand` | toolbar only: `none`, `expand`, or `fullscreen` |
| `show_copy_icon` | `true` | copy-to-clipboard icon under each reply |
| `toggle_state` | `remember` | `remember`, `open`, or `close` on load |
| `stream` | `false` | stream tokens live — **legacy assistants only** (auto-disabled for agent-backed assistants) |
| `verbose_mode` | `true` | show per-step progress (agent/1.1.0+ assistants); hides `loading_message` |
| `show_structured_results` | `false` | show structured action results (legacy only) |

The block form warns you to pick an appropriate **role/visibility** so anonymous users don't
reach restricted assistants, and warns if `league/commonmark` is missing. Legacy vs. agent
assistant is detected from the assistant's `ai_agent` field, which toggles which of
`stream` / `verbose_mode` / `show_structured_results` are shown.

## Runtime AJAX endpoints (not user-facing config)

Messages POST to `ai_chatbot.api` (`/api/deepchat`, CSRF-protected); session set via
`ai_chatbot.session` (`/api/deepchat/session`); reset via `ai_chatbot.reset_conversation`.
All require the **`access deepchat api`** permission — see
[permissions/ai_chatbot.md](../permissions/ai_chatbot.md).

## Legacy block

An older `ai_chatbot_block` ("AI Chatbot", form-based via `ChatForm`) still exists for
backward compatibility; prefer `ai_deepchat_block` for new placements.
