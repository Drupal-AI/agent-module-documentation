<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure and send the SBOM

1. Enable the module and open `/admin/config/system/proofwright` (`SettingsForm`, perm `administer proofwright`).
2. Set the **console URL** (default `https://console.proofwright.eu`) and the **licence key**.
3. Send — `SbomBuilder` builds CycloneDX JSON of core + modules + themes; `ConsoleClient` POSTs it to
   `{console}/api/v1/sbom` with `Authorization: Bearer <key>`.

## TLS behaviour (ConsoleClient)
- The base URL **must** start with `https://`; otherwise the send fails with "The console URL must use https."
- The only non-HTTPS exception is a loopback host (`http://localhost` or `http://127.0.0.1[:port]`) for local testing.
- `http_errors => FALSE`: HTTP status is inspected and returned as a structured result rather than throwing.
