Exclude Node Title hides the node title (the h1 / page title) from display, chosen per content type, per view mode, or for individual nodes.

---

Exclude Node Title suppresses node titles in the rendered output without deleting the title value. On its settings form (**Admin → Configuration → Content authoring → Exclude Node Title**, `exclude_node_title.settings`) each content type gets an exclude mode — **None**, **All nodes**, or **User defined nodes** — plus a set of view modes (Full, Teaser, RSS, Search index/result, plus a synthetic "Node form" mode) the exclusion applies to. "All nodes" hides the title for every node of that type in the selected view modes; "User defined nodes" hides nothing by default but adds an "Exclude title from display" checkbox to the node edit form so editors can hide titles case by case (gated by the `exclude any node title` / `exclude own node title` permissions). A site-wide "Type of rendering" option decides how the title disappears: **Remove text** empties the title markup, or **Hidden class** keeps the markup but adds a `visually-hidden` class (better for accessibility/SEO). The suppression is applied through Drupal preprocess hooks (`preprocess_page_title`, `preprocess_page`, `preprocess_node`, `preprocess_html`) so it works with the core Page Title block and node templates, and a `.exclude-node-title` body class is added on affected canonical pages. It can also optionally strip titles from core Search results, and ships a Display Suite `node_title` field override so DS-built displays honor the same settings. Per-node exclusions are stored in Drupal State keyed by node id, while type/view-mode/render settings live in the `exclude_node_title.settings` config object. Access to the settings form is gated by the `administer exclude node title` permission.

---

- Hide the h1 title on all Article nodes' full page view.
- Hide the title only on the teaser view mode while keeping it on the full page.
- Let editors decide per node whether to show the title (User defined mode + checkbox).
- Remove the title on landing-page content types built with Layout Builder / paragraphs.
- Suppress the title on a custom "embed" view mode used to render nodes inside other pages.
- Keep the title in the markup but visually hide it for screen-reader/SEO purposes (Hidden class render type).
- Completely strip the title text from the DOM (Remove text render type).
- Hide the title of a single promotional node without affecting others of the same type.
- Hide the title on Basic page content while leaving Blog posts untouched.
- Remove node titles from core Search results and the search index output.
- Add a `.exclude-node-title` body class so a theme can further adjust layout when the title is gone.
- Let content authors hide only their own nodes' titles (`exclude own node title`) versus any node (`exclude any node title`).
- Suppress the automatically shown "Edit <type>" page title behavior on the node edit form for excluded nodes.
- Hide the title in the core Page Title block (`page_title_block`) for excluded nodes.
- Configure title exclusion per content type in bulk from one admin form.
- Deploy title-exclusion settings across environments via configuration export/import.
- Override the Display Suite `node_title` field so DS layouts respect exclude settings.
- Restrict who can manage the module with the `administer exclude node title` permission.
- Query in code whether a given node's title should be hidden via the `exclude_node_title.manager` service.
- Programmatically add or remove a node from the per-node exclude list from a custom module.
- Hide titles for a "Card" or "Tile" view mode so reusable teasers render without a redundant heading.
- Automatically clean up stored settings when a content type is deleted (handled by the module).
- Choose exactly which of several view modes a content type's title is hidden in.
- Provide a headline-free display for full-width hero nodes where the title is baked into an image.

