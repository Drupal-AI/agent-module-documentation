<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Proofwright CRA Evidence builds a CycloneDX software bill of materials (SBOM) of the site's Drupal core, modules and themes and sends it to a Proofwright console as evidence for EU Cyber Resilience Act readiness.

---

`SbomBuilder` assembles the inventory into CycloneDX JSON; `ConsoleClient` POSTs it to `{console}/api/v1/sbom` with the licence key as a Bearer token. The client is TLS-safe by design: it refuses any console URL that is not `https://` (a localhost/127.0.0.1 loopback is the only non-HTTPS exception, for local testing), so the licence key and inventory never travel in clear text. Configuration at `/admin/config/system/proofwright` (restricted `administer proofwright` permission) holds the console URL and key and triggers the send. The default console is `https://console.proofwright.eu`. The module carries no `version:`/`project:` keys in its repository (injected at release) to satisfy security-advisory coverage.

Set up by enabling the module, entering your console URL and licence key, and sending the SBOM (manually or on a schedule) so your compliance console has current evidence of the site's software composition.

---
- Generate a CycloneDX SBOM of core, modules and themes.
- Send the SBOM to a Proofwright console for CRA evidence.
- Authenticate the upload with a Bearer licence key.
- Enforce HTTPS on the console URL (loopback excepted).
- Keep an up-to-date software inventory for compliance.
- Point at a self-hosted or the default EU console.
- Refresh evidence after each deployment.
- Track module/theme versions for vulnerability correlation.
- Support EU Cyber Resilience Act readiness workflows.
- Restrict SBOM sending to `administer proofwright` holders.
- Test locally against a loopback console over http.
- Produce machine-readable inventory for auditors.
- Avoid leaking the inventory by rejecting non-HTTPS targets.
- Store the console connection settings once and reuse.
- Feed SBOMs into a supply-chain security tool.
- Prove software composition to customers or regulators.
- Re-send after adding or updating a module.
- Centralize SBOMs from many Drupal sites in one console.
