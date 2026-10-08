<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Regex — agent index

Extends the **Redirect** module with **regex-pattern redirects** (match path families, substitute captured
groups into destinations). Depends on `redirect` (>=1.12); provides permissions. Version **1.0.0-alpha7**.
Core `>=10.2`.

**Security:** (1) regex on request paths = **ReDoS** risk from bad admin patterns — write anchored/efficient
regex; (2) **capture-group destinations + `TrustedRedirectResponse`** could enable an **open redirect** if an
attacker-influenced capture forms an external URL — keep destination hosts fixed, anchor patterns. No
content-access role.
