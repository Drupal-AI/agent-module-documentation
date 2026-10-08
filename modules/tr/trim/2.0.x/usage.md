<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Trim automatically strips leading and trailing whitespace from every text value submitted through a content entity form, running before validation so stray spaces never cause errors or get saved.

---

Trim is a tiny, configuration-free module: it has no settings form, no permissions, no plugins, and no services. It works entirely through `hook_form_alter()`, which inspects the form's form object and acts only when the form builds/edits a **content entity** (nodes, users, taxonomy terms, media, comments, custom entities — anything whose entity type is a `ContentEntityType`); config forms are deliberately left untouched. On those forms it prepends its own validation callback, `trim_form_values`, to the front of `$form['#validate']` so it runs first. That callback walks every value in `$form_state` and recursively `trim()`s each string (descending into arrays), then writes the trimmed value back. Because it trims **prior to validation**, a trailing space after a number in an integer field or an accidental space in a required field no longer blocks submission. To guarantee it runs first, `trim_install()` sets the module's system weight to `1001` (heaviest, so its `hook_form_alter` runs last and its `array_unshift`ed validator ends up first). Trim only affects input that passes through Drupal's Form API — it does **not** touch values written via the REST API, migrations, or direct `$entity->save()` calls, and native HTML5 input validation (e.g. `type="number"`, `type="email"`) still runs in the browser before Trim can act.

---

- Strip trailing spaces an editor accidentally pasted after a node title before it is saved.
- Clean leading/trailing whitespace from a plain-text field without writing a custom validator.
- Prevent "value is not a valid number" errors caused by a stray space in an integer field.
- Trim surrounding spaces from a required text field so a lone space no longer counts as "filled in".
- Sanitize whitespace in taxonomy term names entered through the term form.
- Trim whitespace in user-profile text fields (custom `field_*` on the user entity).
- Clean up media entity metadata fields (alt text, credit) on the media edit form.
- Normalize comment author/subject text entered through the comment form.
- Remove accidental whitespace from a custom content entity's fields via its edit form.
- Keep multi-value field deltas clean by trimming each value in the submitted array.
- Standardize data entry across an editorial team without per-field configuration.
- Avoid duplicate-looking taxonomy terms that differ only by a trailing space.
- Trim link-field title text and other nested string values on entity forms.
- Ensure email/username fields have no stray spaces before core validation runs.
- Reduce support tickets caused by "invisible" whitespace in saved content.
- Apply consistent whitespace trimming to every content type at once, site-wide.
- Trim address or contact fields captured on a content entity edit form.
- Clean whitespace from an SEO meta-description text field on the node form.
- Guarantee Trim runs before other validators by relying on its high module weight (1001).
- Leave configuration forms untouched so intentional space-keyed options are preserved.
- Provide a friendlier editing experience where accidental spaces "just work".
- Trim values on inline entity forms that build a content entity edit form.
- Normalize imported-then-edited content when it is re-saved through the UI.
- Complement core's password/tags trimming by extending trimming to all text fields.
