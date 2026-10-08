<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block List Override removes (or restricts to only) block plugins from Drupal's block library — the theme block-placement list and the Layout Builder "Add block" list — by matching plugin ids via exact name, colon-prefix, or regex, to declutter the UI and improve performance.

---

Core exposes a very long list of block plugins, many never used. This module filters that list at the plugin-definition level. It implements `hook_block_alter()` (the site-wide/theme block list) and `hook_plugin_filter_block__layout_builder_alter()` (the Layout Builder chooser), running each block plugin id through a `block_list_override.list` service (`BlockListOverride::blockIsAllowed()`). A block is considered "listed" if its id exactly equals an entry in the **Match** list, begins with an entry in the **Prefix** list followed by a colon (e.g. `field_block:user` matches `field_block:user:user:uid`), or matches a **Regex** entry (e.g. `/field_block:node:(.*):nid/`). The **Action** (negate) toggle chooses whether listed blocks are *Removed* (`negate=0`, default) or whether the list is limited to *Allow only* those blocks (`negate=1`). Blocks already placed inside Layout Builder sections are always kept, to avoid breaking existing layouts. All matching uses the `system_*` config keys; note that in this version the Layout Builder hook also reads the `system_match`/`system_prefix`/`system_regex` patterns (only its negate is separate, `layout_negate`). Settings live in `block_list_override.settings` and are edited at `/admin/config/block_list_override/settings` (permission *access block list override*), with two preview pages listing the blocks that remain after your rules. Removing a block that is actually placed will produce "non-existent block" messages, so use with care.

---

- Hide dozens of never-used core/contrib block plugins from the theme block-placement list.
- Shorten the Layout Builder "Add block" chooser so editors see only relevant blocks.
- Remove a specific block by exact plugin id (e.g. `system_powered_by_block`).
- Remove every block sharing a prefix, e.g. all `field_block:` blocks, via one Prefix entry.
- Remove all node-nid field blocks with a regex like `/field_block:node:(.*):nid/`.
- Limit the entire block library to only an approved set using the "Allow only" action.
- Improve admin UX/performance on sites with many entity/field blocks.
- Keep Layout Builder tidy while leaving already-placed blocks working.
- Strip out inline-block or custom-block-type entries editors shouldn't pick.
- Remove Views blocks (`views_block:*`) that are exposed elsewhere from the chooser.
- Curate an editor-facing block palette per governance policy.
- Prevent accidental placement of deprecated or internal blocks.
- Reduce the block list to speed up block admin pages on large sites.
- Apply the same removal rules to both the theme block list and Layout Builder at once.
- Use different actions for the two lists (Remove system-wide, but Allow-only in Layout Builder) via the separate negate toggles.
- Migrate settings automatically from the legacy Block Blacklist module on install.
- Preview exactly which blocks survive your rules on the System/Layout preview pages.
- Enforce a minimal, curated block set as configuration across environments.
- Combine match, prefix and regex rules to precisely target block ids.
- Call `blockIsAllowed()` from custom code to reuse the same filtering logic.
- Gate access to the configuration behind the dedicated *access block list override* permission.
- Remove clutter blocks like "Syndicate", "Powered by Drupal", or unused menu blocks.
