<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_node_breadcrumbs — agent index
**A block that renders a node's breadcrumb (plus structured data) from a per-node `field_breadcrumbs` link field.**

- **Version:** 1.1.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Block:** `custom_node_breadcrumb_block` (`NodeBreadcrumbs`) — reads the route node's `field_breadcrumbs`, adds `<front>` as home, renders via the `custom_node_breadcrumbs` theme (output `max-age: 0`).
- **Setup fields:** add a multi-value **link** field `field_breadcrumbs` to content types.
- **Library:** attached in `hook_preprocess_page()`.

**Security:** Display-only. No routes, permissions or mutating endpoints; block placement/visibility via core Block UI. Breadcrumb data comes from an editor-populated link field. See [configure/block.md](configure/block.md).
