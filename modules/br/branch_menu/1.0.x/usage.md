Branch Menu renders a chosen Drupal menu as an interactive, downward-flowing tree graph drawn with D3.js.

---

The module provides one block plugin, "Branch Menu Graph" (`branch_menu_block`), placed through the standard Block layout UI. Each block instance has a single setting — a dropdown listing every menu on the site — and renders that menu's link tree (up to 6 levels deep) as an angular SVG graph. Server-side, `BranchMenuBlock::build()` loads the tree with core's `menu.link_tree` service, flattens each link into `{title, url, has_children, children}`, and hands the nested array to the browser via `drupalSettings.branchMenu.treeData`. The client library (`branch_menu/branch_graph`) loads D3 v7 from the jsDelivr CDN plus two local scripts that lay out non-overlapping nodes, draw polygonal branch paths, add per-node link anchors and labels, and animate hover states. The module has no routes, permissions, services, config schema, install hooks, or dependencies beyond Drupal core ^11; all configuration is per-block.

---

- Visualize a site's main navigation as a branching tree graph in a content region.
- Give editors a bird's-eye "site map" style view of any menu's hierarchy.
- Render a custom "documentation" or "sections" menu as a diagram on a landing page.
- Show a footer or utility menu graphically instead of as a flat link list.
- Present a multi-level product/category menu as an org-chart-like structure.
- Place the graph in the sidebar of a landing page to aid navigation discovery.
- Build a visual index page by placing the block and pointing it at a deep menu.
- Demonstrate menu depth and structure to stakeholders during content modeling.
- Replace a plain "HTML sitemap" menu block with a graphical tree on a public page.
- Show onboarding users the overall shape of a knowledge-base menu.
- Add a decorative but functional navigation graph to a marketing homepage.
- Render a course/curriculum menu as a branching learning path.
- Display an organizational structure encoded as a menu (departments as branches).
- Give a visual overview of an admin-curated "quick links" menu.
- Use as a D3.js integration example/starter for custom menu visualizations.
- Present a wiki or handbook table-of-contents menu as an expandable-looking graph.
- Show region-specific menus (per language or per section) as separate graph blocks.
- Provide a large-format navigation display for kiosk or dashboard screens.
- Compare menu hierarchies by placing several block instances, each on a different menu.
- Prototype a navigation redesign by visualizing the current menu tree before restructuring.
