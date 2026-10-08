<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Delete Orphaned Non-Reusable Blocks lists and deletes inline (non-reusable) block content left orphaned by Layout Builder edits.

---

Layout Builder's inline blocks are non-reusable block_content entities created when you add a custom block to a layout. When a layout is changed or an inline block removed, the block_content entity is not always cleaned up — it becomes an orphan, a row in the block_content table referenced by nothing. Over a site's life these accumulate, bloating the table and cluttering any block_content listing. This module finds those orphans and lets an administrator delete them.

It is a maintenance tool, and like any bulk-deletion utility it warrants care: it identifies inline blocks with no referencing layout and removes them, so the correctness of "orphaned" is what stands between cleanup and data loss. The determination is generally reliable for Layout Builder inline blocks, but as with any tool that deletes content in bulk, run it with a backup in place and review what it proposes to remove before confirming, especially on a complex site with custom layout usage.

For a site that has used Layout Builder heavily and accumulated orphaned inline blocks, it reclaims the clutter. Treat it as a deliberate maintenance action — list first, review, then delete — rather than an automated sweep, and keep a backup.

---

- List orphaned inline blocks.
- Delete non-reusable orphaned blocks.
- Clean up after Layout Builder edits.
- Reclaim block_content bloat.
- Find blocks referenced by no layout.
- Remove leftover inline blocks.
- Tidy the block_content table.
- Review orphans before deleting.
- Run maintenance with a backup.
- Clean a Layout Builder site.
- Delete orphaned custom blocks.
- Audit inline block usage.
- Reduce block clutter.
- Remove abandoned inline blocks.
- List before deleting.
- Maintain Layout Builder content.
- Free orphaned block rows.
- Clean up removed layout blocks.
- Confirm orphans before removal.
- Do a deliberate cleanup.