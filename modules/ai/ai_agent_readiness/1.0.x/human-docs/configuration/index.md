# Configuration

AI Agent Readiness is configured at **Configuration → Web services → AI Agent
Readiness** (`/admin/config/services/ai-agent-readiness`). You need the restricted
**Administer AI agent readiness** permission to open it — grant it only to trusted
administrators, since this form controls what your site tells every AI agent about
itself.

## What the form controls

The settings form is where you describe what each of the published discovery
documents should advertise. In one place you shape the content that agents and
crawlers will read from your site's well‑known URLs, including:

- The **content map** served at `/llms.txt` and `/llms-full.txt` — the concise
  and full descriptions of what your site contains, which LLM crawlers use to
  decide what to read.
- The **API catalog** at `/.well-known/api-catalog` (RFC 8288).
- The **agent‑skills index** at `/.well-known/agent-skills/index.json`.
- The **MCP server card** at `/.well-known/mcp/server-card.json` and
  `/.well-known/mcp.json`, which tells MCP‑capable assistants how your site
  presents itself as a server.
- The **OAuth / OpenID metadata** documents
  (`/.well-known/oauth-protected-resource`,
  `/.well-known/oauth-authorization-server`,
  `/.well-known/openid-configuration`) and the `/auth.md` authentication
  declaration, which signal how agents should authenticate.

Save the form to regenerate the documents. Because these outputs are public and
cacheable, changes are meant to be picked up by crawlers on their next visit.

## Verify the output

Every document is reachable two ways: at its canonical well‑known path and at an
`/api/ai-agent/*` mirror. After saving, load a few directly in your browser — for
example `/llms.txt`, `/.well-known/api-catalog`, and
`/.well-known/mcp/server-card.json` — to confirm they contain what you entered.
Agents that send `Accept: text/markdown` will receive markdown‑formatted content
responses.
