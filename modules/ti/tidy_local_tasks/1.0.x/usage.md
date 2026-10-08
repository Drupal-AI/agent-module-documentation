<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tidy Local Tasks tidies Drupal's standard local task tabs (View/Edit/Delete/etc.) by hiding them behind a small button anchored to the side of the viewport. Clicking the button reveals the tabs, keeping them out of the way of the page design until needed.

---

The module is a front-end enhancement: it ships a Twig template plus a JS/CSS library that restyle the local tasks block into a collapsible, sticky control. It has no configuration routes, permissions, services, or server-side logic — it only changes how local tasks are presented.

Use it on themes where the default tabs clash with the layout, or on client-facing sites where you still want editors to reach local tasks but do not want the tabs prominently displayed. Because it is purely presentational, the underlying tabs and their access checks are unchanged; it only hides/reveals what the user could already see.

---

- Hide local task tabs behind a side button.
- Reveal tabs on demand with a click.
- Keep View/Edit/Delete tabs out of the layout.
- Stick the toggle button to the viewport edge.
- Clean up cluttered admin/edit pages.
- Preserve editor access to local tasks.
- Apply a purely front-end presentation change.
- Restyle the local tasks block via a template.
- Ship a JS/CSS library for the toggle.
- Avoid tabs clashing with the theme design.
- Improve client-facing editing UX.
- Leave underlying tab access checks untouched.
- Collapse tabs by default.
- Provide a sticky, unobtrusive control.
- Reduce visual noise for content editors.
- Work without any server-side configuration.
- Keep contextual tasks reachable but hidden.
- Enhance theme polish on authenticated pages.
