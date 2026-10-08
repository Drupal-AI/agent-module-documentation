<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cool Editor Tabs restyles Drupal's local task tabs (View / Edit / Translate / Delete / Revisions) into a floating, icon-based pop-up: a gear toggle fixed to the bottom-right of the screen expands the tabs as circular icon buttons for authenticated editors.

---

The module targets the local-tasks row that editors use on every content operation. Rather than restyling the horizontal strip in place, it moves it out of the flow entirely: `hook_page_attachments()` attaches a CSS-driven library (plus configured colours as `:root` custom properties) for any authenticated user holding the **`use cool editor tabs`** permission, drawing a fixed gear button at the bottom-right corner; a tiny `once()` behaviour toggles `aria-expanded` on the list so the tabs fan out as icon buttons on click. The actual tab markup is only swapped on **non-admin routes** — `_enable_cool_editor_tabs()` returns FALSE on admin routes and for anonymous users, so admin pages keep Drupal's normal tabs and visitors see nothing. On front-end routes, `hook_preprocess_menu_local_task()` replaces each non-active tab's title with an inline SVG (Heroicons v2) chosen by matching the tab's **route name** (`*.edit_form` → edit, `*translation*` → translate, `*metatag*` → metatag, and so on), falling back to the tab title's first letter when nothing matches. Five colours (toggle, toggle-hover, tab, tab-hover, icon) are configurable at *Administration → Configuration → User interface → Cool Editor Tabs*, where a client-side WCAG 2.1 non-text-contrast checker (3:1) grades each combination live. The colour values are re-validated against a strict hex regex at render time before being emitted into an inline `<style>`, so a bad or crafted value is simply dropped rather than injected. The module also registers a Drupal **Icon API** pack and exposes `hook_cool_editor_tabs_icon_alter()` so other modules can map their own routes to icons — including icons from a different pack. It is a maintained fork of the abandoned `better_admin_tabs`. Version **2.0.0**, core **`^11.1`**; the `use cool editor tabs` permission is deliberately declared `restrict access: false` because it only changes presentation and grants no capability.

---

- Turn the local-tasks row into a floating icon menu for editors.
- Keep a node's View / Edit / Delete / Revisions tabs out of the content flow.
- Give editors one gear button that expands to all available tabs.
- Show recognisable icons instead of a long horizontal tab strip.
- Restyle local tasks consistently regardless of the front-end theme.
- Handle a node that carries eight tabs without the row wrapping badly.
- Improve a moderation-heavy editorial workflow's tab clarity.
- Add per-module icons for Metatag, Pathauto, Redirect, Webform, Scheduler.
- Give Content Moderation's "Latest version" tab its own icon.
- Provide a first-letter fallback icon for unmatched contrib tabs.
- Configure toggle and tab colours to match a brand palette.
- Check editor-tab colour contrast against WCAG 2.1 (3:1) before saving.
- Reset all tab colours to their shipped defaults in one click.
- Hide the restyled tabs from anonymous visitors entirely.
- Show tabs only to users granted the `use cool editor tabs` permission.
- Keep normal Drupal tabs on admin routes while restyling front-end ones.
- Map a custom module's route to a built-in icon via the alter hook.
- Supply icons from your own module's Icon API pack for its tabs.
- Reuse the `cool_editor_tabs` icon pack in another module's UI.
- Improve editor orientation on mobile where a tab strip would overflow.
- Assign keyboard accesskeys (edit=b, translate=v, devel=d, delete=x) to common tabs.
- Modernise the editing interface without writing a custom theme.
