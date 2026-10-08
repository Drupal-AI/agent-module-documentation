<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PCI SRI implements SRI for assets provided by modules and themes.

---

PCI SRI implements Subresource Integrity (SRI) for the CSS/JS assets provided by modules and themes —
adding `integrity` (and `crossorigin`) attributes so the browser verifies each asset's cryptographic hash
before executing it, ensuring assets haven't been tampered with (e.g. by a compromised CDN or MITM). It
provides Drush commands and its own permissions, in the PCI DSS package.

Use it to harden asset delivery with SRI. This is a **positive security** feature: SRI protects against
loading altered scripts/styles (a supply-chain/CDN-compromise and integrity control that supports PCI DSS
requirements). When adopting, be aware SRI requires the served asset to exactly match the recorded hash, so
regenerate/refresh hashes when assets change (aggregation/versioning) to avoid breakage — the module manages
this. It has no access-control role. Configure/generate the SRI hashes.

---

- Implement SRI for module/theme assets.
- Add integrity/crossorigin attributes.
- Verify asset hashes in the browser.
- Protect against tampered assets (CDN/MITM).
- Provide Drush commands and permissions.
- Support PCI DSS requirements.
- Harden asset delivery (positive).
- Refresh hashes when assets change.
- Avoid breakage from hash mismatch.
- Have no access-control role.
- Configure/generate SRI hashes.
- Handle Subresource Integrity.
- Verify script/style integrity.
- Configure SRI.
- Protect asset integrity.
- Generate hashes.
- Handle SRI.
- Add integrity checks.
- Configure the hashes.
- Secure asset delivery.
