<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Many Selects replaces the browser's native multi-select box — the one where editors have to ctrl-click and can silently lose their whole selection — with a widget built from individual select elements.

---

HTML's `<select multiple>` is one of the worst-performing controls in any content form: selecting more than one option requires a modifier key nobody is told about, a stray click without it wipes every previous choice, and on touch devices the interaction is close to unusable. Drupal's core `options` module offers checkboxes as the alternative, which works until the list runs to hundreds of values. Many Selects takes the third path: render a series of ordinary single-select dropdowns, one per chosen value, so each selection is independent and no click can destroy the others. The implementation is small — `src/Plugin` for the widget, `src/Hook` for the form alterations, `many_selects.services.yml`, and no routes, permissions or configuration of its own. Dependencies are core `options` with PHP 8.1+ and core `^10.2 || ^11`. It also ships a `.tugboat/` directory with a demo setup, so upstream maintains a live preview environment.

---

- Replace a hard-to-use multi-select with clearer controls.
- Stop editors accidentally clearing a multi-value selection.
- Make a multi-value field usable on touch devices.
- Handle a list too long for checkboxes.
- Reduce data-entry errors on categorisation fields.
- Improve accessibility of multi-value selection.
- Let editors add one value at a time.
- Avoid training editors to ctrl-click.
- Apply a better widget without changing the field type.
- Improve a taxonomy reference form.
- Keep the stored data model unchanged.
- Reduce support tickets about lost selections.
- Give a long options list a workable UI.
- Switch widget per form display.
- Improve a migrated form's usability.
- Support keyboard-only selection.
- Present selections in a readable order.
- Make bulk categorisation less error-prone.
