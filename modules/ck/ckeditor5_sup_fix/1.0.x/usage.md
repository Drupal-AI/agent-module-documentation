<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A CKEditor 5 plugin that stops the editor from stripping or restructuring `<sup>` (superscript) markup, so footnote-style superscripted links and other legacy sup structures survive editing.

---

CKEditor5 Sup Fix addresses a specific CKEditor 5 regression: content that CKEditor 4 accepted — most
commonly a footnote reference marked up as a superscripted anchor — is mangled by CKEditor 5's
General HTML Support (GHS) when a document is loaded or saved. This module ships a small CKEditor 5
plugin that takes ownership of the `<sup>` element inside the editor's model (registering an `htmlSup`
model element with matching upcast/downcast converters) so the tag round-trips intact, preserving its
`id`, `class`, `name`, and `style` attributes and inline children. It is aimed at sites upgraded from
CKEditor 4 and at government, enterprise, or WCAG-focused sites that depend on semantic `<sup>`
markup. It depends only on core's CKEditor 5 and has no configuration page, routes, or permissions.

Activation is per text format through a "dummy" toolbar button: an editor drags the **Sup Fix Dummy**
button into a format's CKEditor 5 toolbar and saves. No button actually appears in the editor UI (its
component factory returns `null`) — the plugin just loads in the background. As a fallback the module
also attaches its library, via `hook_form_alter`, to any form containing a text-format widget. A
separate, disabled-by-default and explicitly experimental text filter (`sup_link_fix_filter`) can
regex-repair already-mangled `<sup>`/anchor markup server-side; it is not needed when the dummy fix is
in use.

---

- Preserve `<sup>` superscript markup through CKEditor 5 editing instead of having it stripped or restructured.
- Keep footnote-style superscripted anchor links (`<sup><a>…</a></sup>`) intact on save.
- Retain the `id`, `class`, `name`, and `style` attributes on `<sup>` elements.
- Fix the common CKEditor 4 → CKEditor 5 upgrade regression where valid superscript markup is lost.
- Register an `htmlSup` inline model element with upcast/downcast converters that own `<sup>` in the editor.
- Enable the fix per text format by dragging the "Sup Fix Dummy" toolbar button in and saving — no visible editor button.
- Load the plugin library automatically on any form that has a text-format (CKEditor) widget, via `hook_form_alter`.
- Add core's General HTML Support (GHS) with a `sup` allow rule so the element passes the editor's filtering.
- Support semantic/WCAG superscript requirements on government and enterprise sites.
- Optionally repair pre-existing mangled `<sup>`/link markup with the experimental, off-by-default `sup_link_fix_filter` text filter.
- Require nothing beyond Drupal core CKEditor 5 — no contrib dependencies, no Composer libraries, no API keys.
- Run on Drupal 10, 11, and 12 (`core_version_requirement: ^10 || ^11 || ^12`).
