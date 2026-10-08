<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Summary Token From P Tags (node_summary_token_from_p) — agent index

Implements **`hook_tokens()`** so `[node:summary]` resolves for nodes **without a body field** — it renders the node and takes the first three sentences from `<p>` tags. Version **2.0.0**. Core `^10 || ^11`. Requires **node**. No routes/permissions/config.

- `node_summary_token_from_p_tokens()` handles the `summary` token; when core's body-derived summary is empty it calls `node_summary_token_from_p_generate_for_node($node)`.
- Extraction renders the node HTML and pulls text from `<p>` elements; result cached as `node_summary_token_from_p:<nid>`.

Security: pure token replacement over the node's own rendered markup, within Drupal's token pipeline (sanitization + bubbleable metadata) — no user input, routes or access surface.