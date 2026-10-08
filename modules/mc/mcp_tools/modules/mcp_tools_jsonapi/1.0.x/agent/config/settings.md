<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_jsonapi — settings

Config object **`mcp_tools_jsonapi.settings`** controls which entity types the JSON:API tools may
reach and how results are shaped. Form `JsonApiSettingsForm` at route
`mcp_tools_jsonapi.settings` → **`/admin/config/services/mcp-tools/jsonapi`** (route requirement
`_permission: 'mcp_tools administer'`, linked under MCP Tools settings). Schema:
`config/schema/mcp_tools_jsonapi.schema.yml`; install defaults: `config/install/`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `allowed_entity_types` | sequence of strings | `[]` | Explicit allowlist. Empty = allow all content entity types (still subject to the block lists). |
| `blocked_entity_types` | sequence of strings | `user`, `shortcut`, `shortcut_set`, `menu_link_content`, `path_alias`, `redirect`, `webform_submission` | Types blocked in addition to the always-blocked internal list. Takes precedence over the allowlist. |
| `allow_write_operations` | boolean | `true` | When false, only read operations are permitted regardless of scope. |
| `max_items_per_page` | integer | `50` | Cap on items returned per `list` request. |
| `include_relationships` | boolean | `false` | Whether serialized responses include entity-reference field values. |

## Notes

- `JsonApiService::isEntityTypeBlocked()` first rejects a hardcoded always-blocked set, then applies
  `blocked_entity_types`; `discoverTypes()` also skips JSON:API-internal resource types and, when
  `allowed_entity_types` is non-empty, anything not on it.
- The default block list keeps sensitive types (accounts, webform submissions with PII, redirects,
  menu links, path aliases, shortcuts) off by default — narrow it deliberately.
- These settings bound *which types* the tools touch; per-entity `view`/`create`/`update`/`delete`
  access is still enforced separately for the execution user on every call.
- `configure` route id in this submodule's `data.json` is `mcp_tools_jsonapi.settings`.
