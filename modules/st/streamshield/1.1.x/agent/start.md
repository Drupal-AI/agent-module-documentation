<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Streamshield (streamshield) — agent index

**Sends UGC nodes/comments to the Streamshield AI moderation service; the service calls back to unpublish flagged content.**

- **Version:** 1.1.x
- **Core:** ^10 || ^11
- **Admin routes (permission `administer site configuration`):** `/admin/config/streamshield`, `.../registration`, `.../content_types`, `.../scan`.
- **Public endpoints (`_access: 'TRUE'`, signature-checked):** `streamshield.callback` (`POST /streamshield/callback`, unpublishes by nid/cid), `streamshield.image` (`GET /streamshield/file`, returns file bytes for a requested path).
- **Services:** `moderation_service`, `registration_service`, `hash_service` (signature/HMAC).

**Access:** admin config is permission-gated. The two `/streamshield/*` endpoints are declared `_access: TRUE` and authenticate requests with the `HashService` signature/`access_key` check.
