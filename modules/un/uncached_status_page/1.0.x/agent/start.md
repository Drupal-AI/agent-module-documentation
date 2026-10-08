<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Uncached Status Page (uncached_status_page) — agent index

**A tiny always-uncached `/uncached_status_page/status` page returning "Site is Up!" for uptime monitoring.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Package:** Other

**Route:** `uncached_status_page.status` → `/uncached_status_page/status` (perm `access content`). **Service:** `UncachedStatusPageSubscriber` forces `no-store/no-cache/must-revalidate/max-age=0` + `Expires: 0` on that route's response.

**Security:** anonymous-readable by design (health probes need no auth). The controller returns only the literal string "Site is Up!" — no system status, version, or environment data is disclosed. No mutating endpoints.
