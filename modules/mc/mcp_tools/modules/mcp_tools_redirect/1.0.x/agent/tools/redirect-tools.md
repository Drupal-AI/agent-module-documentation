<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect tools

Plugins in `src/Plugin/tool/Tool/`, all `MCP_CATEGORY = 'redirect'` → permission
**`mcp_tools use redirect`**. Read ops need read scope; Write ops need write scope, a
non-read-only connection, and a write-kind the connection's policy allows. Each delegates to
`mcp_tools_redirect.redirect` (`RedirectService`).

| Tool id | Class | Op | Write-kind | Destructive | Inputs | Does |
|---|---|---|---|---|---|---|
| `mcp_redirect_list` | `ListRedirects` | Read | - | - | limit?, offset? | Lists redirects with pagination (access-checked query). |
| `mcp_redirect_get` | `GetRedirect` | Read | - | - | id | Returns one redirect by id. |
| `mcp_redirect_find` | `FindBySource` | Read | - | - | source | Finds a redirect by its source path. |
| `mcp_redirect_create` | `CreateRedirect` | Write | content | - | source, destination, status_code?, language? | Creates a redirect; status_code limited to 301/302/303/307; refuses a duplicate source. |
| `mcp_redirect_update` | `UpdateRedirect` | Write | content | - | id, source?, destination?, status_code?, language? | Updates fields of an existing redirect. |
| `mcp_redirect_delete` | `DeleteRedirect` | Write | content | yes | id | Deletes a redirect. |
| `mcp_redirect_import` | `ImportRedirects` | Write | content | yes | redirects (list) | Bulk-imports redirects; skips existing sources, reports created/skipped/errors. |

## Notes

- `redirect` category defaults to content write-kind; every create/update/delete/import re-checks `AccessManager::canWrite()` at the service layer.
- `RedirectService::normalizeDestination()` keeps `http(s)://` and `entity:`/`internal:`/`route:`/`base:` URIs as-is and wraps bare paths as `internal:/...` — matching the redirect module's own destination handling. Both the `mcp_tools use redirect` permission (restricted) and the connection's write scope gate every mutation.
