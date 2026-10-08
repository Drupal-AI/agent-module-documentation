<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dify (dify) — agent index

Service-only **base module** for the Dify LLM-application platform. Ships **no routes, blocks,
permissions, config, or admin UI of its own** — it provides shared services that four optional
submodules build on. Package `Dify`. Core `^10 || ^11`. PHP `>=8.1`. License GPL-2.0-or-later.
Version 2.0.8. No Drupal module dependencies (base); submodules add their own.

- **The API client, services, controller, and trait it provides** → [api/client.md](api/client.md)
- **The markdown renderer + SSE chat/workflow proxy** → [services/proxy-and-markdown.md](services/proxy-and-markdown.md)

## Submodules (each documented in its own nested tree)

Enable only what you need. Nested docs at `modules/di/dify/modules/<submodule>/2.0.x/`.

- **dify_search_api** — Search API backend → Dify knowledge base. Needs `search_api` +
  `league/html-to-markdown`. → `../../modules/dify_search_api/2.0.x/agent/start.md`
- **dify_widget_vanilla** — custom themeable floating chatbot **block**, proxies the Dify Chat
  API. Needs `league/commonmark`. → `../../modules/dify_widget_vanilla/2.0.x/agent/start.md`
- **dify_widget_official** — **block** that embeds Dify's hosted `embed.min.js` widget. →
  `../../modules/dify_widget_official/2.0.x/agent/start.md`
- **dify_augmented_search** — **block** showing AI Workflow answers next to search results. Needs
  `league/commonmark`. → `../../modules/dify_augmented_search/2.0.x/agent/start.md`

## What the base module actually provides (from source)

- **Services** (`dify.services.yml`): `dify.markdown_service` (`MarkdownService`),
  `dify.chat_proxy_service` (`DifyChatProxyService`, arg `@logger.channel.dify`), and the
  `logger.channel.dify` channel.
- **`DifyClient`** (`src/DifyClient.php`) — Guzzle wrapper for the Dify **Dataset/Knowledge** API
  (`v1/datasets…`). Not a container service; the Search API backend `new`s it with two clients
  (JSON + file). Methods: list/get/delete documents, `createDocumentFromText`,
  `updateDocumentFromText`, `createDocumentFromFile`, `updateDocumentFromFile`, segment CRUD
  (`getSegments`/`createSegments`/`updateSegment`/`deleteSegment`), metadata
  (`createMetadataField`/`ensureMetadataField`/`assignDocumentMetadata`).
- **`MarkdownController`** (`src/Controller/MarkdownController.php`) — `render(Request)` → JSON
  `{html}`. **Defines no route**; each markdown submodule maps its own path here.
- **`IdentityCardTrait`** (`src/IdentityCardTrait.php`) — `buildIdentityCard()`, a plain-text
  compact/verbose field header driven by per-field priority; used by the backend + pipeline.
- **`dify.module`** — only `hook_help()`. No hooks that alter data.

## Install

`composer require drupal/dify` → `drush en dify`, then enable submodules and require their extra
libraries (see each submodule doc). No config form on the base module. No automated 1.x→2.x
upgrade path (uninstall + reinstall).
