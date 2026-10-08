<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart 404 — agent index

**Logs 404 errors and provides an admin UI to quickly create redirects** for them (fix broken links / SEO).
Depends on `redirect`. Provides permissions. Version **1.1.3**. Core `^10.3||^11||^12`.

Admin/SEO — the 404 log records **requested URLs** (may include attacker-probed paths — gate to trusted
admins); redirects are admin-configured. No access role beyond permission.
