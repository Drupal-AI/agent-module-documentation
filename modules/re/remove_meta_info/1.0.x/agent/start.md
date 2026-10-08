<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remove Meta Info — agent index

Manages/removes **meta info from the HTML head + HTTP response headers** (generator/version tags) —
reduces information disclosure/fingerprinting. Version **1.0.3**. Core `^8||^9||^10||^11`.

Hardening/defense-in-depth (not a substitute for patching). **Don't remove purposeful tags** (SEO/
canonical, security headers like CSP/XFO) — target only informational ones. No content-access role.
