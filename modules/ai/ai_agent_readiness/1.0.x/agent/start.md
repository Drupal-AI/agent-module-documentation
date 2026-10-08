<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agent Readiness (ai_agent_readiness) — agent index

**Serves standardized AI-agent / LLM-crawler discovery documents (llms.txt, .well-known MCP/OAuth/agent-skills, api-catalog) with markdown content negotiation.**

- **Version:** 1.0.x  •  **Core:** ^10 || ^11  •  **Package:** Web Services
- **Configure:** `/admin/config/services/ai-agent-readiness` (`administer ai agent readiness`, restricted).
- **Public routes:** `/llms.txt`, `/llms-full.txt`, `/.well-known/{api-catalog,agent-skills/index.json,mcp/server-card.json,mcp.json,oauth-protected-resource,oauth-authorization-server,openid-configuration}`, `/auth.md`, all mirrored at `/api/ai-agent/*`.
- **Controller:** `AiAgentController`.
- **Security:** All discovery routes are `_access: 'TRUE'` **by design** — read-only, non-mutating public documents meant to be crawled anonymously; only the settings form is permission-gated. Reviewed SOUND — no security findings.

See [api/endpoints.md](api/endpoints.md).
