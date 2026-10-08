<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — AxioRank Agent Verification

**Settings:** `axiorank.settings` → `/admin/config/services/axiorank` (perm `administer axiorank`). Set the site key, base URL, posture (`monitor`|`enforce`), and verification scopes. The `AxiorankSettings` resolver reads the site key/base URL from `settings.php` first (secret hygiene) then stored config.

**Test connection:** `axiorank.test_connection` → `/admin/config/services/axiorank/test` (perm + `_csrf_token: TRUE`) via `TestConnectionController`.

**Runtime:** `VerifyRequestSubscriber::onRequest()` (KernelEvents::REQUEST prio 28) runs on main requests only, calls `Gate::shouldVerify()`, then `AxiorankClient::verify()` (POST `/api/gateway/verify-request`, `Authorization: Bearer <site_key>`, 1s timeout, no redirects, `http_errors=FALSE`). Block happens only when posture=enforce and the verdict's `enforced` is true (403 for `block`, else 401). Every failure path returns `failOpen()` (decision `allow`, `enforced` false).
