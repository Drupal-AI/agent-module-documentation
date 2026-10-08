<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prepopulate fills form elements with values taken from the URL query string, so a link like `/node/add/article?edit[title][widget][0][value]=Hello` opens the node form with the title already filled in.

---

The module is deliberately tiny: `hook_form_alter()` looks at every form, and if the current request carries an `edit` query parameter it appends `prepopulate_after_build()` to `#after_build`. That callback hands the built form to the `prepopulate.populator` service (`Drupal\prepopulate\Populate`), which walks the `edit[...]` array in parallel with the render array and sets `#value` on matching leaf elements. Nesting in the URL mirrors the render array exactly, which is why Field API fields need the `edit[field_name][widget][0][value]` (or `[target_id]`) shape. Only a fixed whitelist of element types can be filled — `textfield`, `textarea`, `text_format`, `select`, `number`, `email`, `url`, `tel`, `date`, `datetime`, `datelist`, `path`, `machine_name`, `language_select`, `entity_autocomplete`, `inline_entity_form`, plus the `container`/`fieldset` wrappers — and `radios`/`checkboxes` are intentionally excluded so a crafted link cannot silently flip a permission or setting on an admin form. Modules widen that list with `hook_prepopulate_whitelist_alter()`. Values are escaped with `Html::escape()`, existing scalar `#value`s are never overwritten, elements with `#access: FALSE` are skipped, and the populator bails out entirely once a multi-step form starts rebuilding. For `entity_autocomplete` elements the raw id is turned into the `Label (id)` string the widget expects, but only when the referenced entity exists and the user has `view label` access. There is no settings form, no permission and no configuration — the module's whole surface is the URL syntax, the service, and the whitelist alter hook. The `og_prepopulate` submodule reuses the same service for Organic Groups audience fields.

---

- Build "add content" links that arrive with the title, body or a category already filled in.
- Give editors a bookmarklet that opens `/node/add/page` prefilled from the page they were reading.
- Prefill a contact or webform-style form from a marketing email link.
- Pass a campaign or referral code from a landing page into a hidden-ish text field on a signup form.
- Create per-section "Add article to this section" links that preselect the section term.
- Prefill an entity reference field with a specific target node id via `[widget][0][target_id]`.
- Show a friendly `Label (id)` value in an autocomplete widget instead of a bare entity id.
- Prefill several fields at once by chaining `edit[...]` parameters with `&`.
- Preselect a value in a `select` widget (list fields rendered as a drop-down) from the URL.
- Prefill a date or datetime widget on an event creation form.
- Seed a `machine_name` element so a new config entity gets a predictable id.
- Prefill the `path` element (URL alias) on a node form.
- Prefill the language selector on a translation-creation link.
- Prefill nested `inline_entity_form` subforms from a parent entity's context.
- Drive a "duplicate this content" link that carries the source values in the query string.
- Wire a dashboard button that opens a pre-filled issue/ticket node form.
- Prefill user-registration profile fields from an invitation URL.
- Whitelist a custom form element type with `hook_prepopulate_whitelist_alter()` so it too can be prefilled.
- Call `prepopulate.populator`'s `populateForm()` directly from your own `#after_build` for a targeted subform.
- Keep radio buttons and checkboxes un-prefillable on purpose, as a security default.
- Prefill a text-format field (body) while leaving the format selector alone.
- Generate QR codes or short links that open a partially completed submission form.
- Prefill a "report a problem about this page" form with the offending path.
- Let a migration or import tool hand editors half-finished forms to complete by hand.
- Prefill fields for anonymous users without writing any custom form-alter code.
- Chain with Views' "Add content" area links to carry contextual filter values into the new node.

