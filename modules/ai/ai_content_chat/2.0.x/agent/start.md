<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Chat (ai_content_chat) — agent index

RAG chatbot: answers user questions from indexed site content via the Drupal AI module. Version dir `2.0.x` (installed 2.0.0). Core `^10 || ^11`. Package `AI`.

**Dependencies:** `drupal:block`, `ai:ai` (Drupal AI module; needs a chat-capable provider). Composer `drupal/ai:^1.0`. Optional (suggests): `smalot/pdfparser:^2.0` (PDF text), `phpoffice/phpword:^1.0` (DOCX text).

## What it provides
- **Block plugin** `ai_content_chat_block` (`Plugin/Block/ChatbotBlock`, admin label "AI Content Chat", category "AI") — renders the floating widget via the `ai_content_chat_widget` theme (template `templates/chatbot-widget.html.twig`), attaches the `ai_content_chat/chatbot` library (`js/chatbot.js`, `css/chatbot.css`).
- **Routes** (`ai_content_chat.routing.yml`): `ai_content_chat.settings` (config form, `administer ai content chat`); `ai_content_chat.api.chat` POST `/api/ai-content-chat/ask` (`use ai content chat` + `_csrf_request_header_token`); `ai_content_chat.api.reindex` POST `/admin/config/ai/content-chat/reindex` (`administer ai content chat`).
- **Controller** `Controller/ChatApiController` — `chat()` and `reindex()`, return JSON.
- **Services** (`ai_content_chat.services.yml`): `ai_content_chat.chat_service` (`Service/ChatService`), `ai_content_chat.indexer` (`Service/ContentIndexer`), `ai_content_chat.file_text_extractor` (`Service/FileTextExtractor`).
- **Config form** `Form/SettingsForm` (extends `ConfigFormBase`) at `/admin/config/ai/content-chat`.
- **Permissions** (`ai_content_chat.permissions.yml`): `administer ai content chat` (restricted), `use ai content chat`.
- **Config** `ai_content_chat.settings` (`config/install` + `config/schema`). **Schema/DB table** `ai_content_chat_index` (`ai_content_chat.install` `hook_schema`; update hooks 10001/10002).
- **Hooks** (`ai_content_chat.module`): `hook_theme`, `hook_help`, and `hook_entity_insert/update/delete` → auto (re)index single entity.
- Menu link `ai_content_chat.settings` under `ai.admin_settings` (`ai_content_chat.links.menu.yml`).

## Solution docs
- [config/settings.md](config/settings.md) — settings object, keys, schema, content-source selection, permissions, routes.
- [services/indexing-and-chat.md](services/indexing-and-chat.md) — ContentIndexer (index/search/context), FileTextExtractor, ChatService (provider call), controller/block flow.

No submodules. No Drush commands. No conversation storage.
