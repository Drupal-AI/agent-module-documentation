# Configuration

MCP Tools is configured at **Configuration → Web services → MCP Tools**
(`/admin/config/services/mcp-tools`), which needs the **Administer site configuration**
permission. The important thing to understand here is not any single checkbox but the
**layered access model** — because the caller on the other end is a language model, not a
person, and you are deciding how much of your site it can touch.

## Start with a preset

The settings form offers three presets that set sensible starting points; pick the one
that matches the environment:

- **Development** — full access, no rate limiting. For local work only.
- **Staging** — config‑only mode, rate limited, audit logging on.
- **Production** — read‑only mode, strict limits, full audit trail.

You can then adjust the individual controls below.

## The layered access model

Access is decided by several layers that stack on top of one another:

1. **Module‑based availability.** Only the tools belonging to submodules you have enabled
   exist at all. This is the first and simplest control — expose a domain by enabling its
   submodule, remove it by uninstalling.
2. **Global read‑only mode.** A single site‑wide switch that blocks **every** write,
   regardless of any other setting. Turn it on during an incident to freeze an assistant's
   ability to change anything.
3. **Connection scopes.** Each connection carries scopes — `read`, `write`, `admin`. The
   form distinguishes **default scopes** (what a connection gets if it asks for nothing)
   from **allowed scopes**, a ceiling a connection cannot exceed.
4. **Config‑only mode.** Restricts writes to chosen *kinds* — `config`, `content`, `ops` —
   so, for example, an assistant may change configuration but not content.
5. **Per‑domain permissions.** Each domain has its own permission (`mcp_tools use
   content`, `mcp_tools use users`, and so on), so you can gate individual surfaces with
   Drupal's normal roles.
6. **Rate limiting.** Caps how many tool calls a connection may make.

## Scope‑trust settings — preserve the defaults

The form controls where a connection's scopes are allowed to come from. The defaults are
deliberate and correct, and you should keep them:

- **Trust scopes via environment** — **on** by default. The environment is
  server‑controlled, so this is trustworthy.
- **Trust scopes via header** and **trust scopes via query** — **off** by default. These
  are client‑controlled, and a language model should not be able to grant itself more
  access by setting a header. Leave them off unless you have a specific, well‑understood
  reason.

## The execution user

Every tool runs as a configured Drupal user, so **that user's permissions are the real
ceiling** on what an assistant can do. Treat it like a service account: give it exactly
the permissions the exposed tools need and nothing more. The remote HTTP transport refuses
to run as **uid 1** unless an explicit override is set — for production, create a dedicated
executor account (there is a "Create MCP Executor Account" action on the remote settings
page) rather than reusing the site admin.

## Safety behaviours worth knowing

- Destructive operations require **explicit confirmation** rather than firing silently.
- Unknown tool parameters are **rejected**, not quietly dropped.
- **Audit logging** records tool activity (via `dblog`) so you can review what an assistant
  did.

## Save and audit

Save the form, then open the **status** page at
`/admin/config/services/mcp-tools/status` to confirm exactly which tools are exposed under
the settings you chose. Make a habit of reviewing this page whenever you enable a new
submodule or before you open the endpoint to anything beyond local development.
