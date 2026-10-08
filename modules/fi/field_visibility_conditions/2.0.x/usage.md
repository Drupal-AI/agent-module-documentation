Field Visibility Conditions lets you attach Drupal Condition plugins (request path, language, user role, current theme, etc.) to individual fields so a field is shown or hidden on entity forms when its conditions evaluate true.

---

The module adds a **"Field Visibility"** section to every field's config edit form
(`/admin/structure/.../fields/.../edit`) where an admin configures one or more Condition plugins for
that field. It builds on the `conditions_helper` contrib module: `FormAlters` uses
`conditions_helper.form_builder` to render the condition sub-form and stores the chosen conditions as
the field's **third-party settings** under the `field_visibility_conditions` key (config schema
`field.field.*.*.*.third_party.field_visibility_conditions`, a sequence of `condition.plugin.*`).
Which condition plugins are *offered* is controlled globally at
`/admin/config/content/field-visibility-conditions` (route `field_visibility_conditions.settings`,
permission `administer field visibility conditions`, restricted) and stored in
`field_visibility_conditions.settings:enabled_conditions`. At render time, `hook_form_alter`
(and `hook_inline_entity_form_entity_form_alter`) walk the fields on a fieldable entity form, read
each field's stored conditions, evaluate them with `conditions_helper.evaluator`, and set
`$form[$field_name]['#access'] = FALSE` when the result is false — i.e. it removes the field from the
**edit form**. A developer hook, `hook_field_visibility_conditions_available_conditions_alter()`,
lets other modules add/remove available conditions. Note this is a form-building convenience: it
controls whether a field widget appears on a form, not read access to already-stored field data, and
it is not an access-control/security boundary (a field with no conditions is shown normally).

---

- Hide a field on the node edit form unless the request path matches a pattern.
- Show a field only for a specific interface language on entity forms.
- Show or hide a field based on the current user's role (via a role condition plugin).
- Restrict which condition types editors may use, site-wide, from the settings page.
- Conditionally reveal an "extra details" field only in certain contexts.
- Hide seasonal/campaign fields outside their active path or context.
- Vary which fields appear on a form by current theme (e.g. admin vs front-end theme).
- Apply the same visibility logic to fields embedded via Inline Entity Form.
- Keep field visibility rules as portable config on the field's third-party settings.
- Simplify long entity forms by conditionally showing only relevant fields.
- Combine multiple conditions on one field (all must pass) to fine-tune when it shows.
- Add a project-specific condition plugin and expose it for field visibility.
- Remove built-in conditions you don't want editors to use via the alter hook.
- Present role-tailored authoring forms without writing a custom form_alter per field.
- Hide a field on create but not edit (or vice versa) using path/route conditions.
- Reduce editor confusion by hiding fields that are irrelevant in the current context.
- Reuse the `conditions_helper` condition library consistently across fields.
- Configure visibility per field instance (per bundle) rather than globally.
- Gate optional metadata fields behind a language or path condition.
- Toggle availability of new condition plugins centrally as the site grows.
