<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PCI SRI — agent index

Implements **Subresource Integrity (SRI)** for CSS/JS assets provided by modules/themes (adds `integrity`/
`crossorigin` — browser verifies each asset's hash before executing). Drush commands; provides permissions.
Version **1.1.0**. Core `^10||^11`.

**Positive security** — SRI protects against tampered assets (CDN-compromise/MITM; supports PCI DSS).
Regenerate hashes when assets change (avoid mismatch breakage — the module manages this). No access role.
