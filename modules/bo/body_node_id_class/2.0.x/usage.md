<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Body node ID Class adds a `page-node-<nid>` and a `page-node-type-<bundle>` CSS class to the `<body>` tag on node pages, forward-porting the unique per-node body class Drupal 7 core had.

---

The module is a single-hook helper with no configuration, settings form, permissions, services, or plugins. It implements `hook_preprocess_html()` and, when the current route carries a `node` parameter, appends classes to `$variables['attributes']['class']`. If the route parameter is a full `Node` object it adds two classes — `page-node-<nid>` (the node ID) and `page-node-type-<bundle>` (the content type machine name). If the parameter is only a bare node ID (not an upcast entity) it adds just `page-node-<nid>`. The classes appear on the outermost `<body>` element of the rendered page, so themers and site builders can target a single node or a whole content type from CSS without writing PHP. It affects only full HTML page requests routed with a node (canonical node pages); it does nothing on non-node routes, on entity view render arrays, or in stored data. After enabling it you only need to clear caches.

---

- Give one specific node page bespoke styling by targeting `.page-node-123 { … }` in your theme CSS.
- Apply per-content-type styles with `.page-node-type-article { … }` without a custom preprocess hook.
- Restore the Drupal 7 unique-node body class behavior on a Drupal 8–11 site.
- Hide or restyle a global element only on a landing node, e.g. `.page-node-42 .site-header { display:none; }`.
- Add a full-bleed hero layout only on `page-node-type-landing_page` bodies.
- Colour-code the admin or front-end by content type using the type body class.
- Scope a JavaScript behavior to a node type by checking for `page-node-type-<bundle>` on `document.body`.
- Target a campaign node for a one-off background image via its `page-node-<nid>` class.
- Differentiate print styles per content type using the body class.
- Let a designer style pages with pure CSS instead of requesting template overrides.
- Add spacing or typography tweaks for `page-node-type-blog` article pages only.
- Provide a stable hook for A/B or theme experiments keyed on a node ID.
- Override a component's theme only on a particular node without a node-id Twig suggestion.
- Build content-type-specific CSS grids driven by the `page-node-type-*` class.
- Detect the current node type client-side for analytics from the body class list.
- Keep node-specific overrides in the theme's stylesheet rather than in configuration.
- Style a "coming soon" node distinctly using its `page-node-<nid>` class.
- Apply a wider or narrower content container per content type via the body class.
- Target a homepage node (when a node is the front page) with `page-node-<nid>`.
- Add a badge or ribbon only to nodes of a given type using the type class.
- Simplify migration of Drupal 7 theme CSS that relied on the node body class.
- Enable per-node debugging styles (outlines/guides) scoped to one `page-node-<nid>`.
