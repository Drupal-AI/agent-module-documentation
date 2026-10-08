<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Proofwright CRA Evidence (proofwright) — agent index
**Builds a CycloneDX SBOM of core/modules/themes and posts it (Bearer-authed, HTTPS-only) to a Proofwright console.**

- **Version:** 1.0.x  **Core:** ^10 || ^11
- **Config route:** `proofwright.settings` (`/admin/config/system/proofwright`) — perm `administer proofwright` (restricted).
- **Classes:** `SbomBuilder` (CycloneDX JSON), `ConsoleClient` (POST `{console}/api/v1/sbom`, `Authorization: Bearer <key>`). Default console `https://console.proofwright.eu`.
- **Security:** `ConsoleClient` rejects any non-`https://` console URL except localhost/127.0.0.1 loopback — TLS is enforced, not disabled; `http_errors=false` handled explicitly. Licence key sent only over HTTPS as a Bearer token. Single restricted admin route; no anonymous or inbound endpoints. Sound.

See [configure/send.md](configure/send.md)
