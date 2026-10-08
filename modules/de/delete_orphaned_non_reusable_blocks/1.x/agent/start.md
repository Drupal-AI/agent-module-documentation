<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Delete Orphaned Non-Reusable Blocks (delete_orphaned_non_reusable_blocks) — agent index

Lists and deletes **orphaned inline (non-reusable) block_content** left by Layout Builder edits.
Version **dev**. Core `^8.8 || ^9 || ^10 || ^11`.

Maintenance tool for block_content bloat from removed inline blocks. **Bulk deletion — list first,
review, keep a backup**, then delete; correctness of "orphaned" is what separates cleanup from data
loss.