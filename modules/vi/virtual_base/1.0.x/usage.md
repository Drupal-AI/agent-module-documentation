<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Virtual Base lets an existing Drupal site also be reached under a configurable URL path prefix — a virtual "RewriteBase" — so the same site answers both at the root and under `/<prefix>/…`.
---
The module solves the case where a site is accessed internally at the root but externally through a gateway that exposes it under a fixed path prefix. A path processor (`VirtualBasePathProcessor`) strips the configured prefix from inbound request paths and re-adds it to outbound generated URLs, an event subscriber and a `VirtualBaseManager` service coordinate the prefix and detection (with a request-based cache), and a `virtual_base` cache context ensures rendered/cached output varies correctly by whether the prefix is active. A `VirtualBaseServiceProvider` wires the processor in. A node-form validator prevents setting a path alias equal to the configured prefix.

Because URL rewriting spans the web server too, from 1.0.0-alpha4 the module requires companion `.htaccess` (Apache) `RewriteRule`/`RewriteCond` lines (documented in the README) that set a `VIRTUAL_BASE` environment variable for requests under the prefix; the module reads that to know the active base. You can scope the rewrite to a specific host with an extra `RewriteCond %{HTTP_HOST}` line. Settings live at `/admin/config/system/virtual-base` behind `administer site configuration`.

Typical setup: enable the module, set the path prefix and enable it on the settings form, then add the required rewrite lines to `.htaccess` (optionally host-scoped). After that the site is reachable both normally and under the prefix, with links generated consistently for whichever base the visitor arrived on.

---

- Serve the site under an extra URL path prefix
- Expose an internal root site through a gateway path prefix
- Add a virtual RewriteBase without moving the docroot
- Strip the prefix from inbound request paths for routing
- Re-add the prefix to outbound generated URLs
- Configure the path prefix at /admin/config/system/virtual-base
- Enable or disable the prefix behavior from the settings form
- Restrict the prefix to a specific host via .htaccess HTTP_HOST condition
- Vary cached output by active base using the virtual_base cache context
- Prevent a node path alias from colliding with the configured prefix
- Support both root and prefixed access to the same site simultaneously
- Add the required Apache RewriteRule/RewriteCond lines to .htaccess
- Read the VIRTUAL_BASE env var to detect the active prefix
- Keep links consistent for whichever base a visitor arrived on
- Handle redirect-based Apache env variable rewrites
- Limit configuration to the administer site configuration permission
