<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body node ID Class — agent index

Adds `page-node-<nid>` and `page-node-type-<bundle>` CSS classes to the `<body>` tag on node
pages. Zero configuration: no settings form, no `configure` route, no permissions, no services,
no plugins, no Drush, no config schema. Its entire behavior is one preprocess hook.

- **What classes it adds, the hook, and when it fires** →
  [api/mechanism.md](api/mechanism.md)

Key fact: `hook_preprocess_html()` reads the route's `node` parameter. A full `Node` object →
adds both `page-node-<nid>` and `page-node-type-<bundle>`; a bare node ID → adds only
`page-node-<nid>`. It only runs on full node page requests; enable it and clear caches — nothing
else to set up.
