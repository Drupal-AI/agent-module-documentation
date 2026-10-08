<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EZ Likes (ez_likes) — agent index

**Adds an accessible Like button with a live count to node full-page views, tracks likes per user/anonymous visitor, and provides a filterable admin report with CSV export.**

- **Version:** 1.0.x — core `^10 || ^11 || ^12`
- **Depends:** node, user, system
- **Config:** `/admin/config/content/ez-likes` (`administer ez likes`)
- **Report:** `/admin/reports/ez-likes` (+ `/export`, `/likers/{nid}`) — `access ez likes report` (restricted)
- **Toggle:** `POST /ez-likes/toggle/{nid}` — button injected via `hook_node_view()` on `full` mode; data in the `ez_likes` table.
- **Security:** admin/report routes permission-gated; the toggle route is `_access: 'TRUE'` but the controller validates a per-node CSRF token (`ez-likes-{nid}`) and requires a published node, so anonymous liking is deliberate and CSRF-guarded. Anonymous de-dup is by client IP (shared-NAT collisions possible).

See [configure/settings.md](configure/settings.md).
