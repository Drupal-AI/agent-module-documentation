<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Backlinks parses the rendered HTML of selected node fields on save, finds internal links to other nodes, and stores them so each node can display the list of nodes that link to it.

---

On `hook_node_presave` (via `EntityLinkService`) the module renders the configured source fields, loads the resulting HTML into a `DOMDocument`, and collects `<a href>` targets (skipping `file:`, `mailto:`, `javascript:` and `onenote:` schemes). Each address is resolved to a `Url`: internal hosts are matched against Drupal's `trusted_host_patterns` (from settings.php) and turned into user-input URLs, and only links that resolve to `entity.node.canonical` routes are kept. The extracted node ids are written to a `linked_node` reference field (and raw URLs to a `linked_url` field) that you add to your content types. A settings form (`/admin/config/content/backlinks`) picks which fields are scanned, and a bulk form (`/admin/config/content/backlinks/update`) rebuilds links across existing content. An optional "Linked Content" view (when Views is enabled) uses the `linked_node` relationship.

Both admin routes require `administer site configuration`. The module only parses already-stored node markup and resolves internal node routes — it does not fetch remote URLs, so there is no outbound request/SSRF surface.

---
- Show which nodes link to the current node
- Add a `linked_node` reference field to a content type
- Add a `linked_url` field to capture raw hrefs
- Choose which fields are scanned for links
- Rebuild backlinks for all existing nodes in bulk
- Populate backlinks automatically on node save
- Build a "related content" block from incoming links
- Use the provided Linked Content view with the `linked_node` relationship
- Ignore mailto/file/javascript links during extraction
- Restrict recognised internal hosts via trusted_host_patterns
- Report an SEO-style internal link graph
- Find orphan nodes with no incoming links
- Drive a "cited by" list on articles
- Keep backlinks in sync as body content changes
- Limit backlink resolution to node canonical URLs