<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bulk_comment_delete (`bulk_comment_delete`) — agent index
**Bulk-delete comments grouped by the commented node's content type, via confirm form + batch.**

- **Version:** 3.0.x  | **Core:** ^8 || ^9 || ^10
- **Depends on:** core `comment`
- **Routes:** `/admin/content/bulk-comments` and `/admin/content/bulk-comments/delete`
- **Permission:** `administer bulk commnet delete` (sic — typo in machine name), no `restrict access` flag.
- Uses the entity storage API for deletion (not raw SQL); selection query uses the DB query builder with `condition(..., 'IN')`.

**Security:** state-changing operations run through Drupal FormBase (CSRF token enforced) and are gated by a custom permission not granted to anonymous. Deletion uses the entity API. No verified finding; minor: chosen types are passed via `$_SESSION`.
