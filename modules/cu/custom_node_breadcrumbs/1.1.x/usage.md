<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A block that renders a per-node breadcrumb trail built from a link field on the node, and also emits structured data for it.
---
The site builder adds a multi-value link field named `field_breadcrumbs` to the desired content types and populates it per node. The **Custom Node Breadcrumb Block** (`custom_node_breadcrumb_block`) reads the current route's node, iterates the `field_breadcrumbs` values into title/URI pairs, prepends the front-page URL as home, and renders them via the `custom_node_breadcrumbs` Twig template (the template also handles structured data). A page preprocess attaches the module's library so the breadcrumb is styled.

This is a display/site-structure module with no routes or permissions of its own; block placement and visibility are controlled through the normal Block layout UI. The block output is uncacheable (`max-age: 0`) because it depends on the current route's node. Setup: create the `field_breadcrumbs` link field, add links per node, and place the block.
---
- Give each node its own manually-defined breadcrumb trail.
- Build breadcrumbs from a per-node `field_breadcrumbs` link field.
- Allow multiple breadcrumb links per node.
- Prepend the site front page as the breadcrumb home link.
- Emit structured data alongside the visible breadcrumb.
- Place the breadcrumb via the Block layout UI.
- Control block visibility with standard block conditions.
- Override default breadcrumbs on specific content types.
- Theme the breadcrumb markup via the provided template.
- Attach the module's breadcrumb CSS library site-wide.
- Set link titles and URIs per breadcrumb entry.
- Support internal and external breadcrumb URIs.
- Improve SEO with breadcrumb structured data.
- Show tailored navigation paths for landing pages.
- Avoid path-based breadcrumb logic in favour of explicit links.
- Reuse the block across multiple content types with the field.
- Keep breadcrumbs editable by content authors.
- Render nothing when the node lacks the field.
- Provide a lightweight per-node breadcrumb alternative.