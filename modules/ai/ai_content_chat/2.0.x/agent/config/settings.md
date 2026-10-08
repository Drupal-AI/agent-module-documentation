<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Chat — configuration, routes & permissions

## Install / enable
`drush en ai_content_chat`. Requires `block` and `ai` (Drupal AI). Install the AI module and configure at least one chat-capable provider (OpenAI, Anthropic, Google AI, …); the settings form only lists providers whose `getSupportedOperationTypes()` includes `chat` and that have configured chat models. Optional Composer libs for file text: `smalot/pdfparser:^2.0` (PDF), `phpoffice/phpword:^1.0` (DOCX); without them those file types are skipped (logged as a warning).

`hook_schema()` (`ai_content_chat.install`) creates table **`ai_content_chat_index`** with columns `id` (serial PK), `entity_type`, `entity_id`, `bundle`, `title`, `content` (big text), `indexed` (timestamp); unique key on `(entity_type, entity_id)`. `hook_uninstall()` deletes `ai_content_chat.settings`. Update hooks: `10001` creates the table and migrates legacy config-stored `indexed_content`; `10002` migrates old `content_type` source keys to `entity_type`+`bundle`.

## Config object `ai_content_chat.settings`
Defaults in `config/install/ai_content_chat.settings.yml`; types in `config/schema/ai_content_chat.schema.yml`.

| Key | Type | Purpose |
|---|---|---|
| `ai_provider` | string | AI provider plugin id (empty until configured). |
| `ai_model` | string | Model id for the chat call. |
| `system_prompt` | string | System prompt; must contain `{context}`, replaced with the retrieved content block. Ships a strict "answer only from provided content" prompt. |
| `fallback_message` | string | Returned when no indexed content matches the question. |
| `max_tokens` | integer | Max tokens for the answer (default 1000). |
| `temperature` | float | Sampling temperature (default 0.7). |
| `content_sources` | sequence | List of `{entity_type, bundle, fields[]}` to index. |
| `last_indexed` | integer | Timestamp of last (re)index. |

The block plugin also stores per-instance settings (`block.settings.ai_content_chat_block` schema): `title`, `placeholder`, `welcome_message`, `button_text`, `primary_color`, `secondary_color`.

## Settings form — `Form/SettingsForm`
Route `ai_content_chat.settings` at `/admin/config/ai/content-chat` (`administer ai content chat`, `_admin_route`). Sections:
- **AI Provider Settings** — provider, model (`getAvailableProviders()` filters to chat-capable providers with configured models), temperature, max tokens.
- **Response Settings** — system prompt, fallback message.
- **Content Sources** — for each indexable content entity type/bundle, an "Enable" checkbox + a "Fields to index" checkboxes list. `getIndexableEntityTypes()` includes only `ContentEntityTypeInterface`s and excludes `user`, `file`, `path_alias`, `shortcut`, `shortcut_set`, `menu_link_content`, `content_moderation_state`, `workspace`, `redirect`, `crop`, `webform_submission`. `getTextFields()` offers common label fields (`title`/`name`/`label`/`info`), `body`, `description`, `field_*` text fields, and `field_*` file / media-reference fields.
- **Indexing** — status line (last indexed date + count) and a "Re-index Content" submit (`reindexSubmit()` saves the form then calls `ContentIndexer::startBatchIndex()`).

`submitForm()` rebuilds `content_sources` from the enabled bundles whose field set is non-empty and saves the config.

## Routes & permissions
| Route | Path | Method | Access |
|---|---|---|---|
| `ai_content_chat.settings` | `/admin/config/ai/content-chat` | GET/POST | `administer ai content chat` |
| `ai_content_chat.api.chat` | `/api/ai-content-chat/ask` | POST | `use ai content chat` + `_csrf_request_header_token: TRUE`, `no_cache` |
| `ai_content_chat.api.reindex` | `/admin/config/ai/content-chat/reindex` | POST | `administer ai content chat` |

Permissions (`ai_content_chat.permissions.yml`): **`administer ai content chat`** (`restrict access: true`) — settings, sources, indexing; **`use ai content chat`** — interact with the chatbot. The ask endpoint requires the CSRF request-header token (the JS fetches `session/token` and sends it as `X-CSRF-Token`).

## Operating notes
- Grant `use ai content chat` to the roles that should reach the widget; the block itself is placed and scoped via core Block layout / visibility.
- After changing which types or fields are indexed, click **Re-index Content** (a batch that truncates the index and re-fills it in chunks of 50).
- Ongoing edits are picked up automatically via `hook_entity_insert/update/delete`.
