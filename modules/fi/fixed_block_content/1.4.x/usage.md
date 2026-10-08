<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fixed Block Content lets you place custom (content) blocks by a stable configuration reference instead of by content id, so a block placement never becomes "This block is broken or missing" when the underlying custom block is absent, deleted, or not yet staged.

---

The module adds a `fixed_block_content` **configuration entity** that acts as a permanent wrapper around a `block_content` (custom block). Each fixed block records a target custom-block *bundle* and, optionally, a serialized *default content* (HAL-normalized) that can recreate the block. A derived core block plugin (`fixed_block_content:<id>`, admin category "Fixed custom") is exposed for each fixed block and can be placed in Block layout like any block; when rendered it loads the linked custom block (creating an empty one on demand if it disappeared) and displays it in a chosen view mode. Because the wrapper is *configuration*, it is exported and deployed with the site, solving two problems: staging (custom blocks created locally aren't lost between environments) and permanence (a placement survives deletion of its content block). The fixed block can `exportDefaultContent()` to snapshot the current block into config and `importDefaultContent()` to restore it; an `auto_export` option re-snapshots on config update, and a `protected` option marks the custom block non-reusable so it isn't edited/deleted independently. Management lives at *Structure → Block content → Fixed block content* (`entity.fixed_block_content.collection`), gated by the core `administer block types` permission; the HAL module provides the serialization used for default content.

---

- Stop "This block is broken or missing" errors after deploying to a fresh environment.
- Ship a footer/CTA custom block as configuration so staging and production stay in sync.
- Keep a block placement working even if an editor deletes the underlying custom block.
- Store a default body for a block in config so a new environment recreates it automatically.
- Place the same fixed block in multiple regions/themes without duplicating content.
- Protect a custom block (mark it non-reusable) so it can't be edited outside its fixed wrapper.
- Snapshot the current block content into config before a release (export default content).
- Restore a block's shipped default content after an editor changed it (import default content).
- Auto-export a block's content to config on every save for continuous config staging.
- Choose the view mode a placed fixed block renders the custom block in.
- Provide baseline marketing copy blocks that always exist in every environment.
- Bridge Deploy / content-staging workflows for custom blocks that aren't natively staged.
- Recreate an empty block automatically if the referenced content block is missing.
- Give a multisite/config-split setup a reliable, config-driven set of standard blocks.
- Reference a block by a stable machine name instead of a fragile content id.
- Seed a new site build with required blocks straight from configuration.
- Prevent accidental loss of a hero block during content cleanup.
- Manage all fixed blocks from a single admin list under Block content.
- Assign a human-readable title to a fixed block independent of the custom block label.
- Keep block placements in Layout/Block UI pointing at content that is guaranteed to exist.
