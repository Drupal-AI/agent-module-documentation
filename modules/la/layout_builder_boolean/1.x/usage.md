<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Boolean adds "(Boolean)" versions of every Layout Builder layout that render one of two region sets depending on a boolean/populated field on the entity.

---

Enable the module (it pulls in core **Layout Builder**) and, on any Layout Builder-enabled display, add a section using one of the new **`<layout> (Boolean)`** choices — the deriver generates a Boolean variant of every layout on the site, so each has a **True** copy and a **False** copy of its regions. In the section settings pick a required **"Switch" Field** (any entity field except unsuitable base fields like `title`/`created`/`uid`); when the entity is displayed, if that field is populated and truthy the **True** regions render, otherwise the **False** regions render — and the non-selected branch is left out of the HTML entirely, so this is a *display condition, not access control*. It shines for **site building** on view displays with optional fields (for example: show hand-picked related nodes when a reference field is set, else fall back to a View), and because it can create a lot of extra layouts it pairs well with **Layout Builder Restrictions** and **Layout Builder Styles**. There is no global settings page — everything is configured per section inside the Layout Builder UI.

---

- Install with `composer require drupal/layout_builder_boolean` and enable it (Layout Builder comes with it).
- Turn on Layout Builder for a content type's Manage display, then open the Layout tab.
- Add a section and choose a "(Boolean)" layout variant such as "One column (Boolean)".
- Pick the switch field in the section settings to decide which region set renders.
- Show a promo/callout section only when a "Featured" boolean is checked.
- Hide a section when a checkbox is off by putting its blocks in the False regions.
- Render hand-picked related content when a reference field is populated.
- Fall back to a View of related content when that reference field is empty.
- Use a Link field as the switch so a "Call to action" block shows only when a URL is set.
- Use an Image field as the switch to vary layout when a hero image is present.
- Build both the "has value" and "no value" outcomes into a single entity display.
- Keep two alternative region layouts side by side and let the field pick one.
- Configure different True vs False region contents for the same section.
- Restrict which Boolean layouts appear using Layout Builder Restrictions.
- Combine with Layout Builder Styles to style the rendered branch.
- Prefer it for reusable site-building displays over one-off layout overrides.
- Rely on fail-to-false: an empty or missing switch field renders the False regions.
- Remember it controls rendering, not access — back sensitive content with real access control.
- Verify in the Layout Builder edit UI, where both branches show with a "Section conditioned on" note.
- Test the front-end output to confirm only the intended branch appears in the HTML.
