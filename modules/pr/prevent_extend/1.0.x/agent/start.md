<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent Extend — agent index

**Disables the admin Extend (module install/uninstall) menu** (force module changes via deployment). Version
**1.0.9**. Core `^10||^11||^12`.

**Security-hardening** — blocking the Extend UI reduces blast radius if an admin account is compromised (module
install ≈ code execution). Defense-in-depth (file/deploy access can still change modules). No per-content access
role.
