<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Sitemap — agent index

**Per-group XML sitemaps** of group content. Version **3.0.0-beta3**. Core `^10||^11`.

Route anonymous, but each entry is filtered by `access('view', $anonymous)` — restricted content is excluded (disclosure safeguard is per-entry). Depends on `group`.