<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: attaches JS to node forms so the 'Authored on' field shows a 24-hour time picker.
- When: your locale/editors expect 24-hour time and the browser's native widget defaults to 12-hour AM/PM.

---

- Enable the module; no configuration or dependencies.
- It targets the node form automatically via a form_alter hook.

---

- `hook_form_BASE_FORM_ID_alter()` for `node_form` attaches library `authored_on_24_hour_format/set_24_hour_format`.
- The JS (in `js/`) sets the 'Authored on' time input to 24-hour format.
- Applies to all node add and edit forms.
- No routes, permissions, or services are provided.
- Purely an editorial UX tweak for the authored-on datetime widget.
- Works regardless of content type since it hooks the base node form.
- Use it to keep time entry consistent for editors in 24-hour regions.
- hook_help documents the module on its help page.
- The change is client-side only; stored values are unaffected.
- No effect on non-node entity forms.
- Clear caches after enabling so the library attaches.
- Combine with site regional settings for consistent display formatting.
- Lightweight: a single module file plus one JS asset.
- Does not alter validation, only the widget presentation.
- Safe to enable/disable without data migration.
- Version 1.0.x supports Drupal 8/9/10.
