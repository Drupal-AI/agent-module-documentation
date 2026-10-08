<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Settings: `/admin/config/system/pagenotfound-redirect` (`administer site configuration`) — set `title`, `message`, and a table of link `label`+`url` rows (AJAX add-row).

Activation: set the site 404 page (`system.site:page.404`) to `/friendly-404`. The controller returns the custom markup with HTTP 404 and `max-age 0`.

Link destinations come from config, not the request. Broken-URL hits are logged to channel `page_not_found_redirect`.
