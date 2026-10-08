# AI Chat — manual setup guide

**AI Chat** (`ai_chat`) places a floating AI chat widget — a chat bubble — on your
site. Behind the bubble sits an AI assistant configured through the
[AI Agents](https://www.drupal.org/project/ai_agents) and AI Assistant API
modules, so visitors can hold a conversation with an assistant you have set up in
Drupal.

The module's job is to render the widget; the assistant's brain lives elsewhere.
You define which assistant answers, which agents and tools it can use, and which
AI provider it talks to using the AI Assistant API and AI Agents configuration.
AI Chat then surfaces that assistant as a chat window on the front end.

Two things are worth being deliberate about. First, **conversations are sent to
the configured AI provider** — that is external data egress, so confirm it is
acceptable for whatever visitors might type. Second, **scope the assistant's tools
and agents tightly**: because the widget can be shown to untrusted visitors, the
assistant must not be able to trigger privileged actions or expose data it
shouldn't. AI Chat has no access‑control role of its own — it relies on how you
configure the assistant.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and configure a provider.

## How to use it

AI Chat leans on the AI Assistant API and AI Agents modules for its settings
rather than adding its own large configuration screen. The setup order is:

1. Configure an AI provider (OpenAI, Ollama, etc.) in the AI module, with its key
   stored securely (see the installation page).
2. Build an **AI Assistant** (and any **AI Agents** / tools it should use) with the
   AI Assistant API module — this defines what the chatbot knows and can do. Keep
   the assistant's tool access scoped so front‑end visitors can't trigger
   privileged actions.
3. Enable AI Chat, and the floating chat widget appears on the site, backed by
   that assistant.

Depends on **AI Agents** (`ai_agents`), **AI Assistant API**
(`ai_assistant_api`), and core **User**. Works on Drupal 10.3+ and 11.
