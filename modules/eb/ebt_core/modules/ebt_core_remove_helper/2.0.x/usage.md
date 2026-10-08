<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Core Remove Helper is a small maintenance submodule of EBT Core that adds an admin form for bulk-removing EBT blocks and cleaning up the shared `field_ebt_settings` field storage — useful before uninstalling EBT block-type modules.

---

The submodule provides a single form route, `ebt_core_remove_helper.ebt_remove_helper` at `/admin/structure/block/remove-ebt-blocks` (a local task "Remove All EBT Blocks" under the custom block library, gated by the `administer site configuration` permission). The form (`EbtRemoveHelperForm`) offers an operation select with two actions: **Remove All EBT Blocks** — finds every `block_content` entity whose bundle machine name starts with `ebt_` (via the block content type storage) and deletes them in a Batch API job (`_ebt_core_remove_helper_remove_blocks`); and **Remove EBT Settings Field Storage** — deletes the `field_ebt_settings` field storage config, but only when no `ebt_` block types remain. It defines no config, permissions, Drush, or plugins of its own. The form warns that deleting inline blocks used by existing Layout Builder pages can trigger a known Layout Builder error and recommends taking a backup and avoiding programmatic block removal on live sites.

---

- Bulk-delete every EBT block (all `block_content` of `ebt_`-prefixed bundles) before uninstalling EBT modules.
- Clean up the shared `field_ebt_settings` field storage after removing all EBT block types.
- Reach the tool from the custom block library via the "Remove All EBT Blocks" local task.
- Run the deletion as a Batch API job so large numbers of blocks are processed safely.
- Identify EBT blocks automatically by the `ebt_` bundle machine-name prefix.
- Prepare a site for uninstalling EBT Core by clearing dependent content first.
- Avoid manually deleting dozens of EBT blocks one by one.
- Prevent an orphaned `field_ebt_settings` storage after EBT block types are removed.
- Guard field-storage removal so it only runs when no EBT block types remain.
- Provide a single admin screen for EBT teardown operations.
- Support cleanup workflows when migrating away from the EBT ecosystem.
- Warn editors about the Layout Builder inline-block deletion caveat before proceeding.
- Give site builders a reversible-by-backup path to remove EBT content.
- Scope deletions strictly to EBT-prefixed block types, leaving other custom blocks untouched.
- Reduce config drift by removing leftover EBT field storage.
- Serve as an optional, enable-when-needed maintenance tool rather than an always-on feature.
