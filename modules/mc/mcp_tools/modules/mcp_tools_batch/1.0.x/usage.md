MCP Tools - Batch adds Tool API plugins for bulk operations — mass-creating, updating, publishing, and deleting nodes, creating taxonomy terms, and assigning a role to many users — from an MCP/AI connection, capped at 50 items per call.

---

This submodule of MCP Tools contributes six write `tool` plugins under the `batch` category, each backed by `BatchService`: create multiple nodes, update multiple nodes, publish/unpublish multiple nodes, delete multiple nodes, create multiple taxonomy terms, and assign a role to multiple users. Every call is bounded to 50 items (`BATCH_LIMIT`) and returns per-item success/skip/error lists. Access is enforced by the shared MCP Tools model — the `mcp_tools use batch` permission plus the connection's write scope, the content write-kind policy, and the read-only switch — and each service method additionally re-checks `canWrite()`. Delete refuses published nodes unless `force=true`. It depends only on the base mcp_tools module.

---

- Ask an AI to create 30 article stubs from a list in one call.
- Bulk-update a field value across many nodes at once.
- Publish a batch of drafted pages together.
- Unpublish a set of outdated nodes in one operation.
- Delete a group of unpublished test nodes safely.
- Force-delete published nodes when explicitly intended.
- Create a whole taxonomy vocabulary's terms from a list.
- Assign an "editor" role to a cohort of users at once.
- Seed demo content for a new site quickly.
- Migrate a spreadsheet of items into nodes via an agent.
- Apply an editorial change (e.g. status) to many items together.
- Clean up stale content in bounded 50-item batches.
- Onboard multiple users into a role during setup.
- Generate structured content types with consistent fields in bulk.
- Roll back a publish by unpublishing the same id set.
- Integrate bulk content operations into an ECA or AI-agent workflow.
- Avoid one-by-one node edits when scripting from Claude Code / Cursor.
- Report per-item errors from a bulk run to fix just the failures.
- Populate a category vocabulary before importing tagged content.
- Batch-create landing pages for a campaign.
