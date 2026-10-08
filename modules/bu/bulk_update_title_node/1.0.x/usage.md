<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Update Title Node performs a case-insensitive find-and-replace across node titles for a selected content type. You pick a content type, enter an existing (partial or full) title substring and a replacement, and the module updates every matching node's title via the Batch API.

Use it to fix a recurring typo, rebrand a term, or normalize titles across many nodes at once.
---
Enable with `drush en bulk_update_title_node`. The form is at `/admin/content/bulk-update` (route `bulk_update_title_node.bulk_update`), gated by the module's own `access bulk update titles nodes` permission.

The form (`src/Form/BulkUpdateTitlesForm.php`) queries nodes with `->accessCheck(TRUE)` and a `LIKE` condition built with `Database::getConnection()->escapeLike()`, then batches `str_ireplace($from, $to, $title)` updates through `Node::save()`. It validates that at least one node matches before running.
---
- Fix a typo repeated across many node titles.
- Rebrand a product name in all matching titles.
- Normalize capitalization or wording in titles.
- Replace a substring in titles for one content type.
- Run large title updates without timing out (Batch API).
- Preview match count via validation before replacing.
- Scope the replace to a single content type.
- Do a case-insensitive find-and-replace on titles.
- Clean up imported titles with stray prefixes.
- Update titles after a taxonomy or naming change.
- Give editors a controlled bulk-rename tool.
- Avoid editing hundreds of nodes by hand.
- Respect node access checks during the query.
- Escape user input safely for the LIKE query.
- Restrict the tool via a dedicated permission.
- Apply consistent title formatting sitewide.