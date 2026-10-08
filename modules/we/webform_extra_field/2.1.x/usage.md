<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Extra Field adds a "Webform" pseudo-field to an entity's display. An admin turns it on for chosen bundles, then on Manage Display positions it like a real field and picks which webform to render — so that one form appears on every entity of that bundle in that view mode.

---

This module places a webform through **display configuration**, not through content. It works in two steps and leans on two dependencies: the **Webform** module supplies the forms, and **Extra Field Plus** (part of the Extra Field project) supplies the pseudo-field plumbing and the per-display settings. First, an administrator with *Administer webform extra field* visits **Configuration → System → Webform extra field** (`/admin/config/system/webform-extra-field`) and ticks the entity-type bundles that should be allowed to use it — the setting is a nested map of `entity_type_id → bundle_id → on/off` stored in `webform_extra_field.settings`, consumed through `hook_extra_field_display_info_alter()` to expose the `webform_extra_field_display` plugin only on those bundles. Second, on each enabled bundle's **Manage Display** (per view mode), the **Webform** pseudo-field appears in the disabled region; drag it into a region, and its per-display settings (a **Webform** select) choose exactly one webform by machine id. At render time the plugin's `view()` loads that `Webform` entity and hands it to the standard webform **view builder** (`entityTypeManager()->getViewBuilder('webform')->view($webform)`), so the form is rendered through Webform's own pipeline — meaning it honors the webform's own access rules, open/closed status and confirmation handling exactly as if it were shown on its canonical page. The important consequence is that the choice of form is **fixed in display config**, identical for every entity of the bundle — this is not a per-node reference field, so if you need different forms per node you want Webform's own entity-reference field instead. Nothing in this module passes the host entity into the webform, so submissions are not automatically tagged with which node they came from; if you need that context, add it inside the webform (a hidden element populated from a token/query, or a source-entity aware handler). Practically it fits when a single form is part of what a content type *is* — a feedback form on every article, an enquiry form on every product — placed and reorderable among fields and switchable per view mode with no conditional logic. Requires core `^9 || ^10 || ^11`, Webform `^5 || ^6`, and Extra Field Plus `^3`.

---

- Add the same feedback webform to every Article, positioned under the body.
- Put a fixed enquiry form on every Product page.
- Attach a booking form to all Event nodes via display config.
- Show a contact webform on every staff-profile entity.
- Place a survey form on a content type without adding a reference field.
- Reorder the embedded form among real fields on Manage Display.
- Show the form on the full view mode but not the teaser.
- Enable the Webform pseudo-field only on selected bundles from one settings screen.
- Render a webform on a taxonomy term or user display (any fieldable content entity).
- Swap which webform appears per view mode of the same bundle.
- Add a "report a problem" form to every Basic page.
- Keep the embedded form out of listing/teaser view modes automatically.
- Attach a newsletter-signup webform to every article's footer region.
- Present a rating form beneath every recipe.
- Show a quote-request form on all products of a bundle.
- Embed a webform whose own open/close schedule controls when it accepts input.
- Rely on the webform's own access rules to hide the form from users who cannot submit.
- Add a form to a bundle without editing node bodies or placing blocks by URL.
- Restrict form placement to admins (display config) rather than editorial staff.
- Turn the extra field off site-wide by unticking bundles in the settings form.
- Combine with a hidden webform element to capture page context per submission.
- Use the same form on multiple bundles by enabling the field on each.
