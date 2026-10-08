<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# miniOrange Okta User Sync (okta_user_sync) — agent index

**Bi-directional user provisioning/de-provisioning and attribute mapping between Drupal and Okta.**

- **Version:** 1.1.x
- **Core:** ^9.3 || ^10 || ^11
- **Depends on:** user_provisioning
- **Admin routes:** all under `/admin/config/people/okta_user_sync/*` — overview, drupal→okta, okta→drupal, mapping, advance settings, audits/logs, upgrade, trial, support — every route requires `administer site configuration`
- **Service class:** `MoOktaHelper` (Guzzle `http_client`) — `getUserFromOkta()` (SSWS header), `callService()` to `login.xecurify.com`
- **Configure:** `okta_user_sync.overview`

**Security:** All routes admin-gated (`administer site configuration`); no anonymous/public trigger. Okta calls use default Guzzle TLS verification (HTTPS verified). NOTE: the Okta API token is stored in plain config (`okta_user_sync_bearer_token`) and echoed back into the admin form — not a Key entity; protect admin access and config exports.

See [configure/setup.md](configure/setup.md)
