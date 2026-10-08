Social Simple adds lightweight social share links (Twitter/X, Facebook, LinkedIn, Google+, Mail, Print, and Print-to-PDF) to nodes and taxonomy terms, exposed either as a per-content-type display element or as a placeable block.

---

The module builds share links from the current entity's canonical URL and title using pluggable "social network" services collected via the `social_simple_network` service tag; each implements `SocialNetworkInterface` and returns a render array for its share link (built with `Url::fromUri` and a FontAwesome icon). Ships networks: `twitter` (X), `facebook`, `linkedin`, `googleplus`, `mail`, `printer` (window.print), and `entity_print_pdf` (requires the Entity Print module). The `social_simple.generator` service (`buildSocialLinks()` / `generateSocialLinks()`) resolves the share URL and title (from the entity label, or the route title for non-entity pages) and themes the links via `social_simple_buttons`. Two ways to display: (1) per node type — a "Social simple share" section on the content-type form (gated by `administer social simple` or `administer nodes`) turns on sharing, selects networks, sets a share title, and picks an entity-reference field to source Twitter hashtags from; the buttons appear as a `social_simple_buttons` extra display component. (2) A "Social simple block" whose block settings choose the title and networks. The optional `social_simple_per_node` submodule adds a boolean `social_share` base field + a node-form checkbox (permission `disable social links per node`) to hide the buttons on individual nodes. Provides one permission (`administer social simple`), a config schema, a theme hook + template, and a JS library that opens shares in a popup. FontAwesome icons load from a jsDelivr CDN by default.

---

- Add Twitter/X, Facebook, and LinkedIn share buttons to article and blog nodes.
- Enable social sharing per content type and choose which networks show for each.
- Place a reusable "Social simple block" with a chosen set of networks in any region.
- Add a "Share by email" (mailto) button to pages.
- Add a "Print" button that triggers the browser print dialog.
- Add a "Print to PDF" share button via the Entity Print integration.
- Set a custom heading (e.g. "Share on") above the share links.
- Source Twitter hashtags from an entity-reference field (e.g. Tags) on the content type.
- Show share buttons on taxonomy term pages, not just nodes.
- Let editors hide share links on a specific node using the per-node submodule checkbox.
- Grant only certain roles the ability to toggle per-node sharing (`disable social links per node`).
- Control which roles can configure content-type share settings (`administer social simple`).
- Open share links in a correctly sized popup window (bundled JS) instead of a full navigation.
- Provide accessible share links with visually-hidden network labels for screen readers.
- Add a brand-new share destination by writing a tagged `SocialNetworkInterface` service.
- Reorder or override a shipped network by registering a higher-priority tagged service.
- Theme the button set by overriding `social-simple-buttons.html.twig` (per-node-type suggestion available).
- Integrate the Forward module with the Mail button when Forward is installed.
- Build share links programmatically for a custom entity via the `social_simple.generator` service.
- Render share buttons in a custom block or controller by calling `buildSocialLinks()`.
- Keep share markup cache-friendly (buttons vary by node/term and url.path).
