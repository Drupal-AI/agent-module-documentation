<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sites Robots.txt lets each site in a Sites-module multisite serve its own robots.txt body.

---

The RobotsTxt module replaces Drupal's static robots.txt with an editable, config-stored version, but that content is global. This module adds a `SitesRobotstxt` SiteSetting plugin so the robots.txt body can be overridden per site context. A route subscriber swaps the RobotsTxt controller for the module's own `SitesRobotsTxtController`, which reads the current site's setting (injected `@current_site`) and falls back to the global RobotsTxt config when a site has none. Configuration lives at `/admin/config/search/sites-robotstxt` behind the `administer robots.txt` permission (owned by the RobotsTxt module).

Setup is: enable Sites + RobotsTxt, then set per-site robots.txt content through the Sites site-setting UI. There is no anonymous write surface — the public robots.txt output is read-only and the settings form is permission-gated.
---
- Serve a different robots.txt per site in a Sites multisite
- Override the global RobotsTxt body for one site only
- Fall back to the global robots.txt when a site defines none
- Disallow crawlers on a staging/preview site while allowing them on production
- Add per-site sitemap directives to robots.txt
- Block specific paths for one site's crawlers
- Manage robots.txt content as part of a site's SiteSetting config
- Keep robots.txt content in exportable configuration
- Point crawlers to a per-site XML sitemap
- Restrict indexing on affiliate/microsites individually
- Provide environment-specific crawl rules
- Centralize robots.txt editing under the search config menu
- Combine with RobotsTxt's editable global default
- Delegate robots.txt editing to the `administer robots.txt` permission
- Avoid physical robots.txt files in a shared codebase
- Migrate per-site crawl policy alongside other site settings
