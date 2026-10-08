<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Achla AI Search (achlaai_search) — agent index

**Connects Drupal to the hosted Achla AI Search service and embeds a signed, backend-authorized search widget via the Ownership v2 protocol.**

- **Version:** 0.3.x  •  **Core:** ^10.3 || ^11.3  •  **PHP:** 8.1+ (JSON, OpenSSL, Sodium)
- **Configure:** `/admin/config/services/achlaai-search` (`achlaai_search.settings`)
- **Permission:** `manage achlaai_search connector` (restricted) gates all admin/AJAX routes.
- **Public route:** `POST /achla-ai/ownership/callback` (`_access: 'TRUE'`) — cryptographically authenticated (signature verify + PKCE `hash_equals`), flood-limited, bounded body; not a permission gap.
- **Services:** `achlaai_search.ownership_manager`, `.bounded_request_body_reader`.
- **Security:** Admin routes permission-gated + CSRF on placement validation; the open callback is signature-verified and rate-limited (SOUND — no pasted keys, fail-closed on missing trust anchors).

See [configure/setup.md](configure/setup.md) and [api/callback.md](api/callback.md).
