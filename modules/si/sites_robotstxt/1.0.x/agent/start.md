<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sites Robots.txt (sites_robotstxt) — agent index

**Per-site robots.txt content for the Sites module, layered on top of RobotsTxt.**

- **Version:** 1.0.x
- **Core:** ^11 || ^12
- **Dependencies:** sites, robotstxt
- **Route:** `sites_robotstxt.settings` → `/admin/config/search/sites-robotstxt` (`_permission: administer robots.txt`)
- **Services:** `sites_robotstxt.route_subscriber` (swaps the RobotsTxt controller), `sites_robotstxt.controller` (reads `@current_site`)
- **Plugin:** `SitesRobotstxt` SiteSetting plugin storing per-site body
- **Security:** No anonymous or mutating endpoints; robots.txt output is read-only and the settings form is gated by `administer robots.txt`. No security findings.
