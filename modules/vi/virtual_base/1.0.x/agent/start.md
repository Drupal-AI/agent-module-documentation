<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Virtual Base (virtual_base) — agent index

**Serves the site under an extra URL path prefix (virtual RewriteBase) via inbound/outbound path processing + a cache context.**

- **Version:** 1.0.x (1.0.0-alpha5) — core `^10 || ^11`.
- **Pieces:** `VirtualBasePathProcessor` (strip/re-add prefix), `VirtualBaseManager` service + `VirtualBaseSubscriber` event subscriber, `virtual_base` cache context, `VirtualBaseServiceProvider`.
- **Config:** `/admin/config/system/virtual-base` (`virtual_base.settings`, permission `administer site configuration`). Node-form validator blocks a path alias equal to the prefix.
- **Requires `.htaccess` edits** (since alpha4): `RewriteRule`/`RewriteCond` lines that set the `VIRTUAL_BASE` env var for `/<prefix>` requests; optionally host-scoped with `RewriteCond %{HTTP_HOST}`.
- **Security:** admin-gated config only; no anonymous or mutating endpoints. Rewriting depends on server-level `.htaccess`. See [configure/prefix.md](configure/prefix.md).
