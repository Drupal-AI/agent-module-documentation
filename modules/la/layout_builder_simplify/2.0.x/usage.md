<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Simplify replaces Layout Builder's flat "Choose a block" list with a two-step, category-first chooser and a searchable custom-block browser.

---

Core Layout Builder shows every available block in a single long off-canvas list. This module overrides `layout_builder.choose_block` (via a RouteSubscriber that swaps the controller for `ChooseBlockController::build`) so the first screen shows only block categories as links; picking a category loads a second screen (`layout_builder_simplify.choose_individual_block`) with just that category's blocks plus a name filter. The "Custom" category instead shows the 20 most-recently-updated content blocks and attaches a JSON autocomplete search (`/block-search.json`) so editors can type-ahead to find a custom block by its info label.

All block-placement routes remain gated by Layout Builder's own `_layout_builder_access: 'view'` requirement, so only users who can already edit a layout reach the chooser. The autocomplete endpoint `/block-search.json` requires `_permission: 'access content'` and returns custom block `info` labels, UUIDs and type labels for any keyword match. Setup is install-and-go: enabling the module changes the chooser everywhere Layout Builder is used.
---
- Group the Layout Builder add-block list by category instead of one long list
- Give editors a category-first "Choose a block" off-canvas screen
- Filter blocks within a category by typing part of the block name
- Browse the 20 most recently updated custom content blocks under "Custom"
- Type-ahead search custom blocks by their info label via autocomplete
- Speed up placing blocks on sites with many block plugins
- Reduce scrolling in the off-canvas block chooser
- Keep the standard Layout Builder add-block workflow otherwise intact
- Provide a "Back" link to return from a category to the category list
- Show custom block type and last-changed timestamp in the recent list
- Override only the chooser controller, leaving placement routes unchanged
- Use with per-entity or per-bundle Layout Builder layouts
- Improve editor UX for content teams building landing pages
- Deploy as a drop-in enhancement with no configuration
- Combine with core Layout Builder default and override layouts
- Let editors find reusable custom blocks without leaving the layout UI
