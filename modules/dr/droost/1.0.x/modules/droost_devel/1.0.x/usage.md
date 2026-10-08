<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Devel exposes Drupal's Devel Generate as a single gated MCP tool so an AI agent can create test content, users, terms, vocabularies, menus and media.

---

Droost Devel is a small optional submodule that bridges `devel_generate` into Droost's MCP surface as one tool, `droost_generate`. An agent can generate test data — content nodes, users, taxonomy terms, vocabularies, menus, or media — directly over MCP instead of shelling out to `drush devel-generate`. The tool takes a `type`, a count (`num`), an optional `kill` flag to delete existing items first, and `bundles` to target specific node types, a vocabulary, or media types. As a state-changing tool it extends `DestructiveToolBase`: it is disabled by default and only runs when the operator opts in through `droost.settings` (`allow_entity_write`, or the master `allow_destructive`) and only over the CLI/STDIO transport. It depends on the Droost base module and `devel_generate`, and is for local/trusted development only.

---

- Generate N test content nodes over MCP without leaving the agent.
- Generate test user accounts for local development.
- Generate taxonomy terms into a chosen vocabulary.
- Generate vocabularies, menus, or media items.
- Delete existing items first with the `kill` flag before regenerating.
- Target specific node types (content), a vocabulary (term), or media types (media) via `bundles`.
- Seed a fresh local site with realistic-volume content for testing a view or listing.
- Keep test-data generation gated behind `allow_entity_write` / `allow_destructive`.
- Restrict generation to the CLI/STDIO transport (refused over HTTP `/_mcp`).
- Give an AI agent a deterministic, schema-described alternative to `drush devel-generate`.
- Reset and reseed content between test runs.
- Populate a bundle so `droost_views` / `droost_display` composition has data to render.
