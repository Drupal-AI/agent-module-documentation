<!-- SPDX-License-Identifier: GPL-2.0+ -->
Disable Field adds per-field settings that render a field's widget as **disabled** (greyed out, non-editable) on entity add and/or edit forms, optionally scoped to specific user roles.

---

The module is a form alteration, not a new field or access system. On the field-config edit form (`field_config_edit_form`) and the base-field-override form (`base_field_override_edit_form`) it injects a **"Disable Field Settings"** fieldset — but only for users with the `administer disable field settings` permission. There you choose, independently for the **add** form and the **edit** form, one of four modes: *Enable for all users* (`none`), *Disable for all users* (`all`), *Disable for certain roles* (`roles`), or *Enable for certain roles* (`roles_enable`), plus a role multiselect. Choices are stored as **third-party settings** on the field's config entity (`disable_field.add_disable`, `add_roles`, `edit_disable`, `edit_roles`). At form-build time `hook_field_widget_complete_form_alter()` reads those settings, determines whether the current form is an add (`$entity->id()` empty) or edit operation, compares the current user's roles against the configured list, and sets `$field_widget_complete_form['#disabled'] = TRUE` when the field should be locked. The widget is disabled in the browser only — this is a UX/soft control on the form, not a security-grade access check (a disabled input is not submitted, so existing values are preserved).

---

- Make a field read-only on the node edit form while still letting authors set it when creating content.
- Lock a field for everyone on both add and edit forms (display-only via the widget).
- Disable a field for specific roles (e.g. Authenticated) but leave it editable for Editors.
- Enable a field only for specific roles and disable it for everyone else.
- Prevent editors from changing a workflow/status field after initial creation.
- Freeze a computed or externally-synced field's widget so nobody edits it by hand.
- Disable a base field such as **title** via the base-field-override form.
- Keep a "reference code" field editable on add but disabled on edit to stop accidental changes.
- Grey out a field on the add form so a default value is used, while allowing edits later.
- Apply different add-form and edit-form disable policies to the same field.
- Restrict who can edit a price/SKU field on a commerce product form by role.
- Lock a legal/terms field once content exists so it cannot be altered post-publish.
- Provide a lightweight alternative to Field Permissions when you only need to disable, not hide.
- Disable a paragraphs subfield's widget for certain roles.
- Show a field's current value to editors without allowing changes.
- Gate the disable settings themselves behind the `administer disable field settings` permission.
- Standardise which fields are locked across content types by setting each field's third-party settings.
- Ship the disable configuration through exported config (`third_party_settings.disable_field.*`).
- Disable a field for anonymous-adjacent low-trust roles on a public-facing form.
- Keep a media/entity-reference field fixed on edit to preserve associations.
- Enforce that only administrators can edit a sensitive metadata field.
- Temporarily disable a field during a content freeze without removing it from the form.
- Disable fields per role on user-profile or taxonomy-term forms, not just nodes.
