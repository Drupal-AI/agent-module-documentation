<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SiteDash — agent index

**Connects to the SiteDash Monitoring and Dashboard service** for site management/monitoring (via Audit Export).
Depends on `audit_export`. Provides permissions. Version **1.0.0-alpha2**. Core `^10||^11`.

Monitoring/integration — **sends site audit/health data to SiteDash** (egress; fingerprinting/operational data —
trusted account); **credentials** as secrets (env/Key, HTTPS). No access role beyond permission.
