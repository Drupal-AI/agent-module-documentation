<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Last Updated shows a node's "changed" (last updated) date through a placeable block, with a per-node checkbox (and per-content-type default) that lets editors decide whether each node displays its updated date.

---

The module adds a boolean base field, `display_updated`, to all node types, surfaced as a "Display updated date" checkbox on the node edit form (grouped under a "Page display options" section). It also adds a "Display updated date." default checkbox to each content type's edit form ("Page display defaults"), which sets that bundle's default via a `BaseFieldOverride`. The actual date is rendered by the **"Last Updated date block"** (`updated_date_block`), a context-aware block that takes the current node and prints its `changed` timestamp with a configurable prefix, date format (any core date format or a custom PHP format), and timezone. The block's access is gated: it returns "forbidden" for any node whose `display_updated` is unchecked, and it caches per the node's `display_updated` value. A permission, **"administer node last updated date"**, controls who may toggle the checkbox on nodes and content types (users without it see the field disabled). The block output uses a dedicated theme hook/template (`field__node__changed__updated`). There is no global settings page — you place and configure the block, set defaults per content type, and toggle per node. Note the permission only governs this module's block, not other ways of showing the changed date (e.g. Layout Builder).

---

- Show a "Last updated on <date>" line on article pages via a placed block.
- Let editors hide the updated date on specific nodes by unticking a checkbox.
- Default new Pages to display their updated date while leaving Articles off (per-content-type default).
- Configure the date prefix text (e.g. "Revised on", "Last modified").
- Pick a site date format or a custom PHP date format for the updated date.
- Render the updated date in a specific timezone regardless of the viewer's.
- Place the updated-date block above or below the main content in the theme's regions.
- Restrict who can change the "display updated" setting via the "administer node last updated date" permission.
- Suppress the updated date on evergreen/reference pages where "last updated" is misleading.
- Show freshness ("last updated") on news or documentation nodes to build reader trust.
- Keep the updated date off landing pages but on blog posts, controlled per node.
- Provide a consistent updated-date presentation across content types through one block.
- Cache the updated-date display correctly per node's display_updated flag.
- Let a content type default to showing the updated date, then override it on individual nodes.
- Theme the updated-date output via the field__node__changed__updated template.
- Disable the toggle for editors without permission while still showing the configured default.
- Add a "last reviewed" style timestamp to policy or legal pages.
- Present the changed date only where editorially appropriate rather than site-wide.
- Combine a friendly prefix and custom format like "Last updated on January 5, 2026 3:04pm".
- Remove the updated date from a node by unticking its checkbox without editing the theme.
