<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Summary Token From P Tags makes the `[node:summary]` token work for nodes that have no body field: it renders the node and takes the first few sentences from the `<p>` tags in the output, so summary-driven features (meta descriptions, teasers, feeds) still get text.

---

Core's `[node:summary]` token is derived from the body field's summary; nodes built without a body field (paragraphs, layout builder, custom fields) leave it empty, which breaks anything relying on it — Metatag descriptions, RSS, teaser text. This module implements `hook_tokens()` so that when `[node:summary]` is requested for such a node, it renders the node's HTML and extracts the first three sentences found in `<p>` elements, returning that as the summary. Results are cached per node (`node_summary_token_from_p:<nid>`) to avoid re-rendering.

It adds no routes, permissions or configuration — it is purely a token replacement that participates in Drupal's token pipeline (respecting the token system's sanitization and bubbleable-metadata handling). The extracted text comes from the node's own already-rendered markup.

For sites that drive meta descriptions or teasers from `[node:summary]` but build content without a classic body field, it restores a sensible summary automatically. Setup is just enabling it; the token then resolves wherever it is used (e.g. a Metatag description pattern).

---

- Fill `[node:summary]` for bodyless nodes.
- Generate a summary from paragraph content.
- Provide a meta description for layout-builder nodes.
- Derive a teaser from rendered `<p>` tags.
- Make `[node:summary]` work without a body field.
- Feed a Metatag description from the summary token.
- Produce RSS summaries for bodyless content.
- Auto-summarize the first sentences of a node.
- Restore summary tokens after removing the body field.
- Summarize custom-field-built content.
- Get teaser text for a node without a body.
- Use `[node:summary]` in a token pattern reliably.
- Cache a derived node summary.
- Summarize nodes composed of paragraphs.
- Avoid empty meta descriptions on bodyless nodes.
- Extract the first three sentences of a node.
- Support summary-driven SEO on all node types.
- Generate teasers for landing-page nodes.
- Provide summaries for feed exports.
- Keep summary tokens consistent across content models.