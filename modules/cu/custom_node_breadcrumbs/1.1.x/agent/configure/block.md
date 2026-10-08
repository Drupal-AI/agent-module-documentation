<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up custom node breadcrumbs

1. Enable the module.
2. On each content type that needs custom breadcrumbs, add a **Link** field with machine name `field_breadcrumbs` that allows **multiple** values.
3. Edit a node and add the breadcrumb links (title + URI) in order.
4. Place the **Custom Node Breadcrumb Block** via the Block layout UI (`/admin/structure/block`), typically in the breadcrumb region, and set any visibility conditions.

## Behaviour
- The block (`NodeBreadcrumbs::build()`) reads the node from the current route, prepends the front page (`<front>`) as the home link, then outputs each `field_breadcrumbs` entry as a title/URI pair.
- Rendering uses the `custom_node_breadcrumbs` Twig template, which also produces breadcrumb structured data.
- The block is uncacheable (`max-age: 0`) since it varies by the current node.
- If the node has no `field_breadcrumbs` field, the block renders an empty trail.
