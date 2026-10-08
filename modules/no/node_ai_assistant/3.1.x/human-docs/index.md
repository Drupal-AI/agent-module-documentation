# Node AI Assistant — manual setup guide

**Node AI Assistant** (`node_ai_assistant`) puts an AI chatbot right inside the
node edit form. It adds an **"AI Assistant" tab** to the vertical tabs group at
the bottom of the edit screen, where content editors and moderators can ask
plain-English questions about the node they're editing — "What is in the hero
paragraph?", "List all empty fields", "Summarise this node" — and get instant
answers, without scrolling through a long form or leaving the page. It reads
every field on the node (text, entity references, images, links, booleans) and
recursively pulls in nested paragraph data up to five levels deep, so even
complex structures are queryable. Chat history is kept for the session so
follow-up questions work naturally, and suggestion chips help editors get
started.

The assistant is deliberately **read-only and safe** — it only reads and
summarises field data and never modifies node content — and the tab appears only
when **editing an existing node**, not on the creation form (where there's no
data yet). A dedicated permission, **Use node AI assistant**
(`use node ai assistant`), controls which roles see the tab.

The most important thing to understand is that this is an **AI egress
integration**. The node's field data and the editor's prompts are sent to the AI
provider you configure through the Drupal **AI** module — which may be OpenAI,
Anthropic Claude, Azure OpenAI, or Google Gemini. That content can be
unpublished or sensitive, so confirm it's acceptable to send externally, disclose
it per your policy, and be mindful of per-call AI costs. The AI provider's
credentials are handled by the AI module (store them as secrets, ideally via the
Key module). It depends on core **Node** and the **AI** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with the AI
   module) and enable it.
2. [Configuration](configuration/index.md) — configure an AI provider, grant the
   permission, and choose which fields and suggestion chips to use.

## Where it lives in the admin menu

The module's own settings form is at **Administration → Configuration → Content
authoring → Node AI Assistant** (`/admin/config/content/node-ai-assistant`),
where you pick which fields are sent to the AI and define default chat snippets.
The AI provider itself is configured under **Configuration → AI → Providers**.
