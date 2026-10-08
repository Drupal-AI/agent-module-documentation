<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unaggregated provides a page that bypasses CSS/JS aggregation.

---

Unaggregated provides a **page that bypasses CSS/JS aggregation** — rendering with aggregation disabled so
developers can inspect individual, unminified asset files when debugging front-end issues, without turning
aggregation off site-wide. It provides its own permissions.

Use it to debug assets on a live-ish site without disabling aggregation globally. It is a developer/performance-
debugging tool; its route is gated by its permission (so it doesn't let anonymous users force the slower
unaggregated path) — keep it to **developers**, since forcing unaggregated rendering has a performance cost. It
has no content or access role beyond its permission. Use the unaggregated page for debugging.

---

- Bypass CSS/JS aggregation on a page.
- Inspect individual asset files.
- Debug front-end assets.
- Provide its own permissions.
- Avoid disabling aggregation site-wide.
- Serve developers.
- Gate the route by permission.
- Keep it to developers (perf cost).
- Not let anonymous force the slow path.
- Have no content/access role beyond permission.
- Use it for debugging.
- Handle unaggregated pages.
- Bypass aggregation.
- Configure the permission.
- Debug assets.
- Handle the page.
- Inspect assets.
- Disable aggregation locally.
- Restrict the permission.
- Provide unaggregated debugging.
