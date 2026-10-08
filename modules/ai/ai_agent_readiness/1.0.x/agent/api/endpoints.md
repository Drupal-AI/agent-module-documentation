<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agent Readiness — discovery endpoints

All served by `AiAgentController`; all `_access: 'TRUE'` (public, read-only, non-mutating).

| Canonical path | API alias | Purpose |
|---|---|---|
| `/llms.txt` | `/api/ai-agent/llms-txt` | Concise LLM content map |
| `/llms-full.txt` | `/api/ai-agent/llms-full-txt` | Full LLM content map |
| `/.well-known/api-catalog` | `/api/ai-agent/api-catalog` | RFC 8288 API catalog |
| `/.well-known/agent-skills/index.json` | `/api/ai-agent/agent-skills` | Agent Skills v0.2.0 index |
| `/.well-known/mcp/server-card.json`, `/.well-known/mcp.json` | `/api/ai-agent/mcp-server-card` | SEP-2127 MCP server card |
| `/.well-known/oauth-protected-resource` | `/api/ai-agent/oauth-protected-resource` | RFC 9728 |
| `/.well-known/oauth-authorization-server`, `/.well-known/openid-configuration` | `/api/ai-agent/oauth-authorization-server` | RFC 8414 |
| `/auth.md` | `/api/ai-agent/auth-md` | WorkOS zero-auth declaration |

Content responses honor `Accept: text/markdown`. Configure what each document advertises at `/admin/config/services/ai-agent-readiness`.
