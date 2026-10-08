<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bakery Single Sign-On (bakery) — agent index

**Cross-site SSO** for sites sharing a second-level domain — parent issues a signed+encrypted cookie
child sites trust. Version **3.x** (dev). Core `^10.2 || ^11`.

**Security model:** HMAC-SHA256 signing (`bakery_key`), encrypted payload, freshness check, and
**signature verified before deserialize**.

**The shared `bakery_key` is a master credential** — identical across sites, never in git/DB dumps;
anyone with it forges SSO cookies for any user.