# Configuration

How you configure Dify depends on which submodules you enabled. The base module
holds the knowledge-base credentials used for content indexing; each chatbot
widget is configured in its own block; and search indexing is set up through
Search API.

## Base module — knowledge base credentials

Go to **Configuration → Search and metadata → Dify** (`/admin/config/search/dify`)
and enter your Dify knowledge base credentials. These are used by the **Dify
Search API** submodule when pushing content to Dify.

Credentials entered here are stored in Drupal **State** — kept in the database and
**never exported with your configuration** — so they won't leak into a config
export. Make sure your Dify endpoint is trusted and reached over HTTPS.

## Chatbot widgets — configured per block

Both chatbot widgets are placed via **Structure → Block Layout**
(`/admin/structure/block`). There is **no global settings form** for them — every
setting lives in the block:

- **Dify Vanilla Widget** (`dify_widget_vanilla`) — place the block, then in its
  settings enter the **base URL** and **API token**, and adjust its appearance.
  You can theme it extensively: 20 CSS color variables, overridable bot/user
  avatars (defined in Twig), suggested questions, and a resizable, minimizable
  floating window. It streams responses, keeps conversation history in the
  browser's localStorage, and supports thumbs up/down feedback.
- **Dify Official Widget** (`dify_widget_official`) — place the block and enter the
  **base URL** and **token** in its settings. It embeds Dify's own hosted widget
  as-is, with no custom code.

## Search API indexing (dify_search_api)

To push Drupal content into a Dify knowledge base:

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. Create a **server** using the **Dify** backend.
3. Create an **index**, add the fields you want to send, and set per-field
   priority weights for relevance.
4. Choose a chunking mode — **automatic**, **custom**, or **hierarchical**
   (parent/child) — and, if you're indexing file fields, configure file extraction
   (PDF, DOCX, etc.) via a Dify Workflow.
5. Index your content. It is pushed to the Dify knowledge base automatically, with
   source-URL metadata for attribution in chatbot answers.

## Augmented search (dify_augmented_search)

Place the **Augmented Search** block via **Structure → Block layout**, typically
near your search results. In its settings, point it at a Dify **Workflow**
(it uses the Workflow API, `/workflows/run`, not the Chat API). When a visitor
runs a search, the block shows a streaming, markdown-rendered AI answer alongside
the normal results. Colors and theming are configurable in the block.

## Security recap

- Credentials are stored server-side (State) and never reach the browser or a
  config export.
- All API calls go through a server-side proxy, POST proxy routes are
  CSRF-protected, and SSL verification is enabled on outgoing requests.
- Treat your Dify API tokens as secrets, and confirm your Dify instance is trusted
  and served over HTTPS.
