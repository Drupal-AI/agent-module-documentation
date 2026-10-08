<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
No Entity View Display disables entity view displays.

---

No Entity View Display **disables entity view displays** for selected entity types/bundles — so an entity
that is only used as data (e.g. referenced/aggregated, never shown on its own) doesn't build/render a view
display, reducing overhead and hiding an unused canonical rendering. It is in the Fields package.

Use it for data-only entities that shouldn't render. It is a site-building/display feature; it affects rendering
config and it has no access-control role (it disables a display, not access — don't rely on it to hide sensitive
data, which needs real access control). Configure which displays to disable.

---

- Disable entity view displays.
- Skip rendering for data-only entities.
- Reduce rendering overhead.
- Serve site building.
- Hide unused canonical rendering.
- Target types/bundles.
- Affect rendering config.
- NOT be access control (disables a display, not access).
- Use real access control to hide sensitive data.
- Have no access-control role.
- Configure disabled displays.
- Handle view displays.
- Disable displays.
- Configure the displays.
- Skip rendering.
- Handle the display.
- Turn off displays.
- Hide rendering.
- Not rely on it for access.
- Provide display disabling.
