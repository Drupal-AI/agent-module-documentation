<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Format ships the text formats and CKEditor 5 configuration the suite's text components use.

---

A component library's text fields need a text format, and which one decides what an editor can put in them. Ship no format and every project configures its own, usually by copying Full HTML and regretting it; ship a considered one and the components behave predictably.

This submodule provides that: text formats with a CKEditor 5 toolbar matched to what the components are designed to render, and media embedding configured (hence the `media` dependency) so an editor can place an image inside body text through the media library rather than pasting markup.

**Text formats are an access control, and this is the place to say so.** The allowed-HTML list is what stands between an editor and script injection, and a format that permits arbitrary HTML grants effective JavaScript execution to everyone who can use it. Review what these formats allow and which roles can use them before treating them as a convenience — particularly on a site where content editors are not fully trusted administrators.

Also worth knowing: a component that renders markup the format strips will look broken, and the cause is the format rather than the component. That is the first place to check when a text component drops formatting.

---

- Provide a text format for component text fields.
- Configure a CKEditor 5 toolbar for components.
- Embed media inside body text.
- Avoid copying Full HTML per project.
- Match allowed HTML to what components render.
- Review which roles may use a format.
- Prevent script injection through a text format.
- Diagnose a component that drops formatting.
- Restrict a format for less trusted editors.
- Standardise editing experience across components.
- Configure media embedding in the editor.
- Add a button to the component toolbar.
- Audit allowed HTML in the suite's formats.
- Align formats with a design system.
- Keep format configuration in exported config.