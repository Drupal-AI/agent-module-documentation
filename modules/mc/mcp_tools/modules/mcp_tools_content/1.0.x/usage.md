Adds four MCP tools that let an AI agent create, update, publish/unpublish and delete Drupal content (nodes).

---

mcp_tools_content is a submodule of MCP Tools. It registers four Tool API plugins under `src/Plugin/tool/Tool/` (all `MCP_CATEGORY = 'content'`) that delegate to `ContentService`. Every write is gated by the parent access model — the `mcp_tools use content` permission, an MCP write scope, the global read-only switch and the config-only write-kind policy — and `ContentService` re-checks `AccessManager::canWrite()` and audit-logs each mutation before touching a node.

---

- Create an article from a title and body supplied in plain language.
- Bulk-scaffold draft pages, then publish them once reviewed.
- Set an entity-reference field (author, category, related node) at create time via `{target_id}`.
- Attach an uploaded image to a node by passing the file id as `{target_id}`.
- Create content as a draft (`status:false`) for later editorial review.
- Update only a node's title without disturbing other fields.
- Patch a single field on an existing node while preserving the rest.
- Correct a body text-format (e.g. move from `full_html` to `basic_html`).
- Publish a batch of nodes an agent created earlier by `nid`.
- Unpublish outdated content without deleting it.
- Toggle publish state idempotently and learn whether anything changed.
- Delete a spam or test node permanently after a confirmation step.
- Chain CreateContent -> UpdateContent using the returned `nid`.
- Generate a new revision on every content edit for audit history.
- Let an AI editor draft, revise and publish a blog post end to end.
- Seed demo content for a fresh site build.
- Fix typos across several nodes by nid in one agent session.
- Retire a landing page by unpublishing then deleting it.
- Create content under a specific author uid when the tool allows it.
- Drive content workflows from Claude/Cursor without the Drupal admin UI.
