<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AxioRank Agent Verification (axiorank) — agent index

**Verifies inbound AI-agent requests against the AxioRank endpoint (monitor/enforce), failing open on any error.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^10.1 || ^11 || ^12
- **Configure route:** `axiorank.settings` → `/admin/config/services/axiorank` (perm `administer axiorank`); `axiorank.test_connection` (perm + `_csrf_token`)
- **Key services:** `axiorank.verify_subscriber` (`VerifyRequestSubscriber`, REQUEST prio 28), `axiorank.client`, `axiorank.settings_resolver`, `axiorank.activity`
- **Permission:** `administer axiorank` (restricted)
- **Security:** fail-open by design (timeout/network/non-2xx/malformed → synthetic allow); enforces only when local posture=enforce AND server verdict `enforced`. Cookie/authorization headers never forwarded; verify call uses TLS default, no redirects, 1s timeout. Admin routes permission-gated; test route CSRF-protected. Site key read from settings.php first.

See [configure/settings.md](configure/settings.md)
