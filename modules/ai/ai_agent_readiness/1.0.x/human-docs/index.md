# AI Agent Readiness — manual setup guide

**AI Agent Readiness** (`ai_agent_readiness`) makes your site "discoverable" by AI
agents and LLM crawlers. A set of emerging conventions expect a website to
advertise what it offers at predictable, well‑known URLs — and this module
publishes exactly those documents for you, so an AI assistant can find and
understand your content and services without scraping your HTML.

Out of the box it serves a family of discovery files: `/llms.txt` and
`/llms-full.txt` (concise and full content maps for LLMs), a
`/.well-known/api-catalog`, an agent‑skills index, an MCP server card, OAuth /
OpenID metadata documents, and an `/auth.md` authentication declaration. Every one
of these is also mirrored under `/api/ai-agent/*` for API clients, and the module
performs `Accept: text/markdown` content negotiation so agents get
machine‑friendly output.

All of the discovery URLs are **public by design** — the whole point is that any
anonymous agent can crawl them — and they are strictly read‑only: nothing on these
routes changes your site. The only restricted part is the settings form, where an
administrator controls what those generated documents actually advertise.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form where you describe
   what your site advertises to agents.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → AI Agent Readiness**
(`/admin/config/services/ai-agent-readiness`), gated by the restricted **Administer
AI agent readiness** permission. The discovery documents themselves need no login
and are served at the well‑known URLs listed above.

## How to use it

1. Enable the module — the discovery endpoints go live immediately with default
   content.
2. Open the settings form and describe your site's endpoints, skills and
   authentication posture so the generated documents are accurate.
3. Visit `/llms.txt` (and the other well‑known URLs) to confirm they return what
   you expect. From then on, MCP‑capable assistants and LLM crawlers can discover
   your site automatically.
