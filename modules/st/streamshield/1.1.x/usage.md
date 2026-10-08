<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Streamshield sends user-generated content (selected node and comment types) to the Streamshield AI moderation service and lets that service call back to unpublish content it flags.

---

After registering the site (`/admin/config/streamshield/registration`) and choosing which content types to moderate (`/admin/config/streamshield/content_types`), the `ModerationService` gathers moderatable fields from a node/comment, attaches signed metadata, and POSTs them to the Streamshield API via Guzzle; a `scan` form re-processes existing content. Two front-facing endpoints support the service: `streamshield.callback` (`POST /streamshield/callback`) receives a decision and, for `action=unpublish`, loads the referenced node/comment by id and unpublishes it; `streamshield.image` (`GET /streamshield/file`) returns file bytes for a requested path. Both are declared with `_access: 'TRUE'` and instead rely on an HMAC-style `HashService` signature/`access_key` check to authenticate requests. Admin config routes are gated by `administer site configuration`.

Typical setup: register the site to obtain access/secret keys, select content types, and let content be moderated automatically on create/update.

---

- Automatically moderate new nodes of selected content types.
- Automatically moderate new comments.
- Re-scan all existing content through the moderation service.
- Register the site with the Streamshield service.
- Choose which content types are moderated.
- Let the service unpublish flagged nodes via callback.
- Let the service unpublish flagged comments via callback.
- Sign outbound moderation payloads with a secret key.
- Verify inbound callbacks with a signature check.
- Exclude system/base fields from moderation.
- Moderate string and long-text field types.
- Include image/file fields in a moderation set.
- Attach CMS metadata (nid/cid) so callbacks can target content.
- Gate moderation on presence of access and secret keys.
- Configure moderation from the admin config section.
- Integrate AI moderation into a UGC workflow.
- Keep flagged content out of public view automatically.
- Batch-moderate a backlog with the scan form.
- Restrict moderation configuration to site administrators.
