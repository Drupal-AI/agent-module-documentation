<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Update Title Node (`bulk_update_title_node`) — agent index
**Bulk case-insensitive find-and-replace on node titles for a chosen content type (Batch API).**

- **Version:** 1.0.x  | **Core:** ^8 || ^9 || ^10 || ^11
- **Route:** `/admin/content/bulk-update` (`bulk_update_title_node.bulk_update`)
- **Permission:** `access bulk update titles nodes`
- Query uses `accessCheck(TRUE)` + `escapeLike()`; updates via `Node::save()` in batch.

**Security:** FormBase (CSRF enforced), permission-gated, entity query uses `accessCheck(TRUE)` and parameterized LIKE via `escapeLike()`. No verified finding.
