Submodule of MCP Tools that adds seven Tool API plugins for importing, exporting, and validating node content via CSV and JSON.

---

`mcp_tools_migration` gives an AI/MCP client a lightweight content-migration helper for node bundles. It imports rows from a CSV string or a JSON array into nodes of a given content type (with an optional column→field mapping), exports up to 100 nodes of a type to CSV or JSON, reports the required and optional fields for a content type so import data can be prepared correctly, validates a proposed import batch before it runs, and reports the status of the last import. Each import/export call is capped at 100 items. All tools extend `McpToolsToolBase` with category `migration`, so they inherit the parent access model (`mcp_tools use migration` permission, per-connection read/write scope, config write policy, global read-only switch); the write tools additionally check `canWrite()` in `MigrationService`. The submodule ships one permission and one service (`MigrationService`); it declares no config, routes, or forms.

---

- Import a batch of articles from a CSV string into a content type in one call (`mcp_migration_import_csv`).
- Import structured items from a JSON array, each with a title and field values (`mcp_migration_import_json`).
- Map source column names to Drupal field names during import (e.g. `{"Name":"title","Description":"body"}`).
- Discover a content type's required vs optional fields before preparing import data (`mcp_migration_field_mapping`).
- See allowed values for list fields so imported data matches the schema.
- Validate an import batch and get per-row errors/warnings before committing anything (`mcp_migration_validate`).
- Export up to 100 nodes of a type to CSV for a spreadsheet or backup (`mcp_migration_export_csv`).
- Export nodes to a JSON array for downstream processing (`mcp_migration_export_json`).
- Check whether the last import finished, and how many items succeeded or failed (`mcp_migration_import_status`).
- Bulk-create landing pages, FAQs, or catalog entries from an agent-generated dataset.
- Round-trip content between environments by exporting JSON here and importing it elsewhere.
- Let an agent dry-run a migration (validate) and only import once the data is clean.
- Cap runaway imports at 100 items per call to keep operations bounded.
- Generate seed/demo content for a new content type from a small CSV.
- Prepare a field-mapping plan by first inspecting the target bundle's fields.
- Surface which rows failed and why, so the agent can fix and retry.
- Restrict all content mutation to write-scoped connections while leaving field inspection read-only.
- Export a content type's data for an SEO or content audit.
