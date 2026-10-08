# Configuration

Configuring this module is mostly about **who can read the snapshot** and **how
callers authenticate**. The snapshot is sanitized metadata, but it still
describes your infrastructure, so tighten access to what your integration
actually needs.

## Permissions

Two permissions govern the module. Grant them at **People → Permissions**
(`/admin/people/permissions`):

- **Access project context snapshot** — controls who can call the permission-gated
  REST endpoint (`GET /project-context-connector/snapshot`). Give this only to the
  trusted users or service accounts that need it. Do **not** grant it to the
  anonymous role unless you genuinely intend the snapshot to be public.
- **Administer project context connector** — controls who can change the module's
  settings (including the signing secret). Restrict this to administrators.

## Authentication methods

The module supports several ways for a caller to authenticate:

- **Basic Auth** or **OAuth2 bearer tokens** against the permission-gated endpoint
  (the caller acts as a Drupal user who has the *Access project context snapshot*
  permission).
- **HMAC signatures** against the signed endpoint
  (`GET /project-context-connector/snapshot/signed`), which needs no Drupal user
  at all — the request is authorized by a valid signature instead.

### The HMAC signing secret

The signed endpoint uses **SHA-256 HMAC signatures with timestamp-based replay
protection**. This depends on a shared **signing secret**, which is the security
boundary for that endpoint — anyone who holds it can retrieve the snapshot without
a Drupal account. Treat it as a credential:

- Set a strong, random secret and keep it out of version control.
- With **DDEV**, store it as an environment variable and reference it rather than
  committing it:

  ```bash
  ddev dotenv set .ddev/.env --pcc-signing-secret=<random-value>
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Rotate the secret if you suspect it has leaked, and give it only to the
  automation that needs it.

## Rate limiting

The module applies **Flood-API-based throttling** (default **60 requests per
minute**), returning HTTP **429** when a caller exceeds it. Leave this on to
protect the endpoint from being hammered; adjust the limit if your monitoring
cadence needs a different rate.

## CORS

If a browser-based tool needs to call the endpoint from another origin, the module
supports an **optional CORS allow-list** with exact-match and wildcard-subdomain
patterns. Keep the allow-list as narrow as possible — list only the origins that
must reach the snapshot.

## What gets exposed

The response reports core/PHP/database versions, active modules and themes with
versions and security-update status, and configuration flags (maintenance mode,
caching, error display, cron). Some of these are **configurable** — for example,
you can control whether database driver/version detail is included. Review the
settings and confirm the output reveals nothing sensitive for your environment
before you hand access to any external caller.

## MCP tool

With `mcp_server` enabled, the snapshot is also available to AI assistants as the
`project_context_snapshot` MCP tool. The same "treat the metadata as sensitive"
guidance applies — only connect assistants you trust.
