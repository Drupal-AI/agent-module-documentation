<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Last Updated — agent index

Displays a node's `changed` (last updated) date through a placeable **block**, gated per node
by a `display_updated` boolean base field (with a per-content-type default). No global settings
page (`configure: null`); depends on `block`, `node`, `system`.

- **The "Last Updated date block" (`updated_date_block`): place it, its settings, and its
  per-node access gating** → [configure/block.md](configure/block.md)
- **The `display_updated` toggle: the node-form checkbox, the per-content-type default, and the
  `administer node last updated date` permission** → [configure/display-toggle.md](configure/display-toggle.md)
- **Theming the output (`field__node__changed__updated` template)** →
  [theming/template.md](theming/template.md)

Key facts:
- Block plugin id **`updated_date_block`** (context: `node`); settings `date_prefix`,
  `date_format`, `custom_date_format`, `timezone` (schema `block.settings.updated_date_block`).
- The block is **hidden** on any node whose `display_updated` is FALSE (blockAccess forbidden).
- Base field **`display_updated`** (boolean) is added to every node type; default FALSE.
- Permission **`administer node last updated date`** gates toggling the checkbox on nodes and
  content types; it only governs this module's block, not other displays of the changed date.
