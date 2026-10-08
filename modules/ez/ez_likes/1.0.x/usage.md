<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accessible Like button with live count on node full-page views, per-user/anonymous tracking, and an admin report with CSV export.

---

EZ Likes adds an accessible Like button with a live count to node full-page views, tracking one like per authenticated user and per anonymous visitor (by IP + session), plus an admin report with filters, sorting and CSV export.

The button is injected by `hook_node_view()` on the `full` view mode; which content types show it, plus per-path include/exclude lists and a button colour, are set at `/admin/config/content/ez-likes`. Likes are stored in a dedicated `ez_likes` table (nid, uid, ip_address, session_id, created). Toggling posts to `/ez-likes/toggle/{nid}`; the route is `_access: 'TRUE'` but the controller enforces a per-node CSRF token (`ez-likes-{nid}`) and only acts on published nodes, so anonymous liking is intended and CSRF-guarded. Anonymous de-duplication is by client IP, so visitors behind a shared NAT can collide.

The report at `/admin/reports/ez-likes` (permission `access ez likes report`, restricted) lists per-node counts with a filter form, a likers drill-down (`/likers/{nid}`) and CSV export (`/export`). Settings require `administer ez likes`. Typical setup: enable the module, choose content types on the settings form, optionally set include/exclude paths and a colour, then grant the report permission to editors.
---
- Enable a Like button on article and page full views.
- Restrict the button to specific content types.
- Force the button on specific paths via the include list.
- Suppress the button on specific paths via the exclude list.
- Change the button colour to match the theme.
- Let anonymous visitors like content (CSRF-protected).
- Track one like per authenticated user per node.
- View total like counts per node in the admin report.
- Filter the report by node or other criteria.
- Sort the report columns.
- Drill into who liked a given node.
- Export the likes report to CSV.
- Grant editors the report permission without site-admin rights.
- Invalidate cached counts automatically on toggle.
- Show a live-updating count next to the button.
- Seed a session attribute so anonymous CSRF tokens persist.
- Place the button at a high weight below node content.
- Audit like activity over time via the created timestamp.
- Remove a like by toggling again.
- Keep counts accurate with per-node cache tags.
