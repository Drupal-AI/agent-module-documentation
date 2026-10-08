Submodule of MCP Tools that adds five Tool API plugins for inspecting configuration drift, previewing site-building operations as a dry run, and exporting the active configuration to the sync directory.

---

`mcp_tools_config` lets an AI/MCP client reason about a site's configuration without a Drush shell. It compares active storage against the sync directory (the equivalent of `drush config:status`/`config:export`), shows a field-level diff for a single config object, tracks which config entities were touched by earlier MCP tool calls, and previews what a would-be operation (create role, grant permissions, add field, delete content type, export config, and so on) would change before anything is executed. Only the config export tool actually mutates anything; it writes active config to the sync directory and requires the admin scope plus an explicit `confirm=true`. All five tools are ordinary Tool API plugins extending `McpToolsToolBase`, so they inherit the parent module's access model: the `mcp_tools use config` permission, the per-connection read/write/admin scope, the config-only write policy, and the global read-only switch. The submodule ships no config objects, routes, or forms of its own — its work is done through the `config.storage`/`config.storage.sync` services and a small set of comparison/preview/tracking services.

---

- Ask "what configuration has changed since the last export?" (`mcp_config_changes`) before syncing.
- Get a per-config field-level diff between active and sync for one object, e.g. `system.site` (`mcp_config_diff`).
- Review the exact create/update/delete changelist that an export would produce.
- Preview creating a content type and see every config object it would generate (form/view displays).
- Preview adding a field to a bundle and learn whether the storage already exists.
- Preview deleting a content type and list dependent configuration that would be affected.
- Preview creating or deleting a user role before committing to it.
- Preview granting or revoking permissions on a role and see exactly which permissions would be added/removed.
- Preview creating a taxonomy vocabulary or a view.
- Dry-run an import-config operation to see what would be pulled from the sync directory.
- Audit which configuration entities were created or modified through MCP tools (`mcp_config_mcp_changes`).
- Decide whether a staging site has drifted from its committed configuration.
- Export active configuration to the sync directory from an admin-scoped connection after reviewing the changelist.
- Confirm that "no changes to export" before running a deploy step.
- Let an agent walk a human through the impact of a site-building change without touching the database.
- Detect accidental configuration overrides made outside of code.
- Build a change summary for a pull request from the tracked-MCP-changes list.
- Verify a specific configuration exists in active but not sync (new_in_active) or vice versa.
- Gate configuration export behind the admin scope while still allowing read-only diff inspection.
- Use the preview tools as a safety check step in an agent workflow that otherwise calls mutating site-building tools.
