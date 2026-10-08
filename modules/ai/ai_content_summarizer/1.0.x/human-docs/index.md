# AI Content Summarizer — manual setup guide

**AI Content Summarizer** (`ai_content_summarizer`) generates a short AI summary
for a node and, optionally, a set of SEO-friendly alternative titles. It reads the
text from the fields you nominate (the body by default), sends it to a language
model with a prompt you can edit, trims the result to a length you set, and stores
the summary so it can be shown on the node.

Unlike most modules in this family, it does **not** rely on the shared Drupal AI
module. It ships its **own small provider layer** with built-in support for
**OpenAI**, **Anthropic (Claude)**, **Google Gemini**, and local **Ollama**. You
pick one active provider, enter its details, and the module talks to it directly.
That also means it manages the API key itself — see
[Configuration](configuration/index.md).

You can summarize on demand from a per-node action, bulk-list eligible content
with Summarize/Regenerate links, or have summaries generated automatically
whenever a node is created or updated. Summaries are stored per language in the
module's own database table and removed when their node is deleted. Every summary
is a billed external call (except when you run locally through Ollama), but all the
trigger routes are behind a permission, and the single-node route is CSRF-protected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose a provider, enter its
   settings, pick content types and source fields, tune prompts and behavior, and
   the important note on how API keys are stored.

## Where it lives in the admin menu

- **Settings:** **Configuration → Content authoring → AI Content Summarizer**
  (`/admin/config/content/ai-summarizer`), gated by the **Administer AI content
  summarizer** permission.
- **Bulk summarize:** **Content → AI Summarize** (`/admin/content/ai-summarize`),
  a list of eligible nodes with per-row Summarize/Regenerate links, gated by the
  **Use AI content summarizer** permission.

Two permissions control the module: **Administer AI content summarizer**
(restricted — configuration) and **Use AI content summarizer** (running summaries).
