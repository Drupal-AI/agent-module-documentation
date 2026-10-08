<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_webform — tool reference

All tools extend `McpToolsToolBase` (`MCP_CATEGORY = 'webform'`), require the `mcp_tools use webform`
permission, and delegate to `WebformService` (`mcp_tools_webform.webform_service`). Category maps to
the **content** write-kind; the write methods re-check `AccessManager::canWrite()`.

| Tool id | Class | Op | Purpose | Key inputs |
|---|---|---|---|---|
| `mcp_list_webforms` | `ListWebforms` | Read | All webforms + submission counts. | — |
| `mcp_get_webform` | `GetWebform` | Read | Webform details incl. elements + settings. | `id`* |
| `mcp_get_webform_submissions` | `GetSubmissions` | Read | Page of submissions with data. | `id`/`webform_id`*, `limit`, `offset` |
| `mcp_create_webform` | `CreateWebform` | Write | Create a webform with elements. | `id`*, `title`*, `elements` |
| `mcp_update_webform` | `UpdateWebform` | Write | Update settings and/or elements. | `id`*, `updates`* |
| `mcp_delete_webform` | `DeleteWebform` | Write | Delete a webform + all its submissions. | `id`* |
| `mcp_delete_webform_submission` | `DeleteSubmission` | Write | Delete one submission by id. | `sid`* |

`*` = required. Write tools need `write` scope and are blocked under global read-only mode.

## Behavior notes

- `getSubmissions()` counts and lists via entity queries with `->accessCheck(TRUE)`, so submission
  visibility follows webform-submission entity access for the execution user. Returned fields per
  submission: `sid`, `uuid`, `created`, `completed`, `changed`, `uid`, `remote_addr`, and the
  element `data`.
- `deleteWebform()` reports how many submissions were removed with the form.
- `createWebform()`/`updateWebform()` process the supplied `elements` into the webform's stored
  element definition; both call `canWrite()` first.
- Submission element data may include personal information — treat outputs accordingly and keep the
  domain permission-gated with a least-privilege execution user.
