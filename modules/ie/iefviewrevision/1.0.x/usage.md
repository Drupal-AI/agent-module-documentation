<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inline Entity Form - View Revisions adds a "Revisions" link beside the Edit and Remove buttons that Inline Entity Form renders for each referenced entity, giving editors quick access to the referenced node's revision history from within the parent form.

---

The module implements `hook_field_widget_form_alter()` and, for entity reference fields whose IEF widget lists existing entities, injects a markup element containing an anchor to `/node/{id}/revisions` (opened in a new tab) for each referenced entity. It reuses a small `children()` helper to find the numeric entity rows in the widget structure.

This is a pure editorial convenience link. The link target is Drupal core's node revisions route, which enforces its own access ("view all revisions" / node access) — the module performs no data access itself and does not bypass revision access control. A user who lacks revision access simply gets the standard 403 when following the link; the button's visibility is not itself an access grant or disclosure. The injected `id` is an integer entity ID, so the markup is not user-controllable text.

---

- Add a Revisions link to inline entity form rows.
- Reach a referenced node's revision history in one click.
- Show the link next to Edit and Remove buttons.
- Open the revisions page in a new browser tab.
- Work with entity reference fields using Inline Entity Form.
- Help editors review changes on referenced content.
- Link to the core `/node/{id}/revisions` route.
- Rely on core node access for revision viewing.
- Require no configuration.
- Apply automatically to complex/multiple IEF widgets.
- Improve editorial workflow for nested content.
- Avoid leaving the parent edit form to inspect history.
- Support any referenced entity exposing an integer ID.
- Add no new routes or permissions of its own.
- Depend on the Inline Entity Form module.
- Keep behavior read-only (just a link).
