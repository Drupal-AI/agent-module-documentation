MCP Tools - Webform adds seven Tool API plugins that let an AI assistant list, inspect, create, update, and delete webforms and read or delete their submissions through the parent MCP Tools server.

---

This is one of MCP Tools' domain submodules. Enabling it registers seven `tool` plugins backed by `WebformService` (service `mcp_tools_webform.webform_service`): the reads `mcp_list_webforms`, `mcp_get_webform`, `mcp_get_webform_submissions`; and the writes `mcp_create_webform`, `mcp_update_webform`, `mcp_delete_webform`, `mcp_delete_webform_submission`. Submission data can contain personal information, so submission queries run with entity query access checks (`accessCheck(TRUE)`) for the configured execution user, and the whole domain is gated by the `mcp_tools use webform` permission (`restrict access: true`). It exposes no routes, config, or UI; the tools are reachable only through a connected MCP client or another Tool API consumer. Write operations need `write` scope and are subject to the global read-only / config-only modes (category `webform` → default content write-kind); every call runs as the configured execution user and is audit-logged.

Turn this on when an assistant should build or manage webforms and their submissions from plain-English requests, and prefer a least-privilege execution user given the PII involved. See `agent/tools/webform-tools.md`.

---
- List all webforms with their submission counts.
- Get a webform's element configuration and settings.
- Read a page of submissions for a webform.
- Retrieve submission field values for analysis or export.
- Create a new webform with a set of elements.
- Update a webform's settings or elements.
- Delete a webform and all of its submissions.
- Delete a single submission by id.
- Scaffold a contact form from a plain-English description.
- Summarize recent submissions for a form.
- Clean up test submissions after building a form.
- Keep the tools hidden entirely by leaving this submodule disabled.
- Restrict a connection to `read` scope so submissions can be read but nothing deleted.
- Require `write` scope before an assistant may create, update, or delete.
- Gate the whole domain behind the `mcp_tools use webform` permission.
- Block all writes site-wide with the server's global read-only mode.
- Run the tools as a least-privilege execution account to limit submission exposure.
- Rely on submission entity-query access checks for the execution user.
- Audit which webform tools are exposed on the MCP status page.
- Combine it with only the other domains an assistant needs.
