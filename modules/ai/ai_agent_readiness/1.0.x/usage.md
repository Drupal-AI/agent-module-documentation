<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Agent Readiness exposes a set of standardized discovery documents so AI agents and LLM crawlers can find and understand a site's content and services.
---
Emerging AI-agent conventions expect sites to advertise capabilities at well-known URLs. This module serves `/llms.txt` and `/llms-full.txt`, a `.well-known/api-catalog` (RFC 8288), an agent-skills index (v0.2.0), an MCP server card (`/.well-known/mcp/server-card.json` and `/.well-known/mcp.json`), OAuth protected-resource / authorization-server / OpenID metadata (RFC 9728 / RFC 8414), and an `/auth.md` zero-auth declaration — each also mirrored under `/api/ai-agent/*`. It performs `Accept: text/markdown` content negotiation for content responses.

Every discovery route uses `_access: 'TRUE'`, which is by design: these are **read-only public discovery endpoints** (the whole point is to be crawlable by anonymous agents) and none of them mutate site state. The only privileged surface is the settings form at `/admin/config/services/ai-agent-readiness`, gated by the restricted `administer ai agent readiness` permission, where an administrator controls what the generated documents advertise. Setup is: enable, open the settings page, and describe the site's endpoints/skills to publish.
---
- Publish `/llms.txt` and `/llms-full.txt` for LLM crawlers.
- Advertise an MCP server card at `/.well-known/mcp/server-card.json` and `/.well-known/mcp.json`.
- Serve an agent-skills index at `/.well-known/agent-skills/index.json`.
- Expose an RFC 8288 API catalog at `/.well-known/api-catalog`.
- Publish OAuth protected-resource metadata (RFC 9728).
- Publish OAuth authorization-server / OpenID configuration (RFC 8414).
- Declare zero-auth posture via `/auth.md` (WorkOS convention).
- Offer `Accept: text/markdown` content negotiation for agent-friendly output.
- Mirror every document under `/api/ai-agent/*` for API clients.
- Let LLM tools discover site capabilities without scraping HTML.
- Configure what the discovery documents advertise from one admin form.
- Restrict configuration to trusted admins via a restricted permission.
- Make a site "agent-ready" for MCP-capable assistants.
- Provide a canonical machine-readable content map for AI ingestion.
- Keep discovery output public and cacheable for crawlers.
- Signal supported authentication methods to agents.
- Standardize discovery across multiple sites in a fleet.
- Help search/LLM crawlers prioritize the right pages.
