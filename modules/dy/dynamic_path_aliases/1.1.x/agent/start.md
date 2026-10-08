<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Path Rewrites (dynamic_path_aliases) — agent index
**Rewrites entity-type router paths on the fly via inbound/outbound path processors — no path-alias entities.**

- **Version:** 1.1.x
- **Core:** ^9 || ^10 || ^11
- **Configure:** `/admin/config/search/path/rewrite` (`entity.path_rewrite.collection`, permission `administer dynamic path rewrites`, `restrict access: true`) — manages `path_rewrite` config entities.
- **Routes:** config entity collection/add/edit/delete + `dynamic_path_aliases.autocomplete` (`/path-rewrite/autocomplete`, same permission).
- **Mechanism:** `PathRewriteProcessor` (In/Outbound) → `PathRewriteManager` (`getPathByRewrite`/`getRewriteByPath`), cached. Tokens intentionally unsupported.

**Security:** Both routes are permission-gated. The autocomplete `Xss::filter`s the query and uses `escapeLike()` with the query builder (no raw SQL). No anonymous or mutating public endpoints. See [configure/setup.md](configure/setup.md).
