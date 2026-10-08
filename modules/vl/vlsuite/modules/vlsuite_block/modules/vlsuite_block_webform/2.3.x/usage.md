<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Webform places a webform as a component inside a layout.

---

A landing page usually ends in a form, and the form is usually a Webform that already exists. This component places it where the page needs it rather than requiring a separate contact page or a hard-coded template.

Because it is a block wrapping a webform, the two sets of configuration stay separate and each stays where it belongs: the form's fields, validation, handlers and confirmation are Webform's, and the placement, section and styling are the layout's. Changing the form does not touch the page; moving the form on the page does not touch the form.

Two things to check. **Access** — a webform has its own access settings, and placing it in a block does not change them, so a form restricted to authenticated users placed on a public landing page will simply not render for anonymous visitors. And **spam protection** — a form on a public landing page will be found by bots, so whatever CAPTCHA or honeypot the site uses needs to apply to it.

---

- Place a form at the end of a landing page.
- Add a signup form to a section.
- Reuse an existing webform in a layout.
- Keep form configuration in Webform.
- Move a form on the page without editing it.
- Style form placement with utility classes.
- Restrict a form block to certain sections.
- Check webform access settings.
- Diagnose a form that does not render.
- Apply spam protection to a public form.
- Place the same form on several pages.
- Translate a placed form.
- Track submissions per landing page.
- Audit which pages carry forms.
- Combine a form with a CTA component.
