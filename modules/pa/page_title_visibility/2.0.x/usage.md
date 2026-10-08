Page Title Visibility lets editors hide the page title on a per-node basis (and set a per-content-type default) by visually hiding the core Page Title block, without removing it from the markup.

---

The module adds a revisionable, translatable boolean base field `display_page_title` to every node (default TRUE), shown as a "Display page title" checkbox in a "Page display options" section of the node edit form. When a node's flag is off, `hook_preprocess_block()` adds core's `visually-hidden` CSS class to the `page_title_block` on that node's page — so the `<h1>` remains in the DOM (preserving accessibility and SEO) but is hidden visually. A per-content-type default is stored in a small config object `page_title_visibility.content_type.<bundle>` (edited on the node type form's "Page display defaults" section) and seeds the checkbox for new nodes when the node's own value is unset. Editing either the per-node checkbox or the per-type default requires the `administer page display visibility config` permission (marked `restrict access: true`); users without it see the checkbox disabled with an explanatory description. The title is left visible on node edit/delete/revision routes and on non-node routes (views, taxonomy, etc.). Requires the core `block`, `node` and `system` modules; the site's content type must be configured to render a page title block for the effect to apply. On install it backfills `display_page_title = 1` for existing published nodes and sets the module weight to 98 so it runs after modules like Scheduler.

---

- Hide the page title on a single node while keeping it on all others.
- Keep the `<h1>` in the markup for accessibility/SEO while hiding it visually.
- Set a per-content-type default for whether new nodes show their title.
- Build a landing/campaign node whose big heading is supplied by a hero block instead of the title.
- Suppress duplicate titles when a layout already prints the heading elsewhere.
- Let editors toggle title visibility from the node form's advanced tabs.
- Restrict who can change title visibility to a specific role via the module's permission.
- Show the title-visibility checkbox disabled to editors lacking permission.
- Default new "Basic page" nodes to a hidden title while keeping "Article" titles visible.
- Preserve per-node title settings across revisions (field is revisionable).
- Keep title-visibility settings when translating a node (field is translatable).
- Ensure titles stay visible on node edit/delete/revision admin routes.
- Avoid hiding titles on non-node pages (views, taxonomy terms, the front page).
- Carry the original title-visibility value onto a cloned node (via `hook_clone_node_alter`).
- Backfill a sensible default (visible) for all existing nodes on install.
- Manage title visibility without hand-editing the Block UI per node.
- Override a content-type default on individual nodes as needed.
- Give designers a per-node switch to control heading display in custom themes.
