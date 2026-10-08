<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Streamshield

## Setup
1. **Register** at `/admin/config/streamshield/registration` (permission `administer site configuration`) to obtain access/secret keys stored in `streamshield.settings`.
2. **Content types** at `/admin/config/streamshield/content_types` — choose which node/comment types are moderated.
3. **Scan** at `/admin/config/streamshield/scan` — re-process existing content.

## How it works
- `ModerationService::moderate()` / `moderateComment()` return early unless both `access_key` and `secret_key` are set and the content type is enabled.
- Moderatable fields are gathered (system/base fields excluded), signed via `HashService::generateSignature()`, and POSTed to the Streamshield API.
- **Callback:** `POST /streamshield/callback` verifies the request signature, then for `action=unpublish` loads the node (`nid`) or comment (`cid`) from `cms_meta` and unpublishes it.
- **File:** `GET /streamshield/file` verifies a hash over `file_path`/`access_key`/`signature` before returning file bytes.
