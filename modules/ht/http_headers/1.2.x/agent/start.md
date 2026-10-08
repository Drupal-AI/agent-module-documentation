<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Headers — agent index

**Configure HTTP (security) response headers site-wide** — CSP, HSTS, X-Frame-Options, Referrer-Policy,
Permissions-Policy. Provides permissions. Version **1.2.0**. Core `^10||^11||^12`.

**Security-positive** hardening — gate configuration to trusted admins (a bad header can weaken protection/break
the site); test CSP/HSTS before enforcing. No access role beyond permission.
