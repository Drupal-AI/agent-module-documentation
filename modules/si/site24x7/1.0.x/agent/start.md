<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site24x7 RUM - agent index

Injects the Site24x7 Real User Monitoring beacon. Version **1.0.0** (1.0.x), core `^9.4 || ^10`, PHP 8.0.

- Config form `/admin/config/system/site24x7` (`site24x7.admin_page`, perm `administer site24x7`): stores `rum_key`, `datacentre` and page/role visibility in `site24x7.settings`.
- `site24x7_page_attachments()` builds the beacon domain per datacentre (`static.site24x7rum.$datacentre/...`) with `appKey={rum_key}` and attaches library `site24x7/site24x7` when visibility conditions pass.
- Visibility service `site24x7.visibility` (`VisibilityMonitor`) is a near line-for-line copy of google_analytics' visibility logic (page + role matching). 403/404 always trackable.
- Permission: `administer site24x7`.

Security: single admin-gated config route; RUM key stored in config and emitted into a public beacon URL (that is its intended use). No external server-side calls, no TLS handling in PHP. Sound.
