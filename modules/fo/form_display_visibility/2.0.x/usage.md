<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Form Display Visibility lets site builders attach access/visibility conditions to individual field widgets on an entity form display, so a field only appears on the add/edit form for users who satisfy the condition (by role or by permission).

Conditions are plugins managed by `FormDisplayVisibilityConditionPluginManager` (annotation `@FormDisplayVisibilityCondition`, discovered under `Plugin/FormDisplayVisibilityCondition`). Two ship out of the box: `AccessByRole` and `AccessByPermission`. The `.module` adds the condition settings into the field-widget third-party settings form (`hook_field_widget_third_party_settings_form`), stores them per component in the `entity_form_display` config, and — critically — enforces them in `hook_field_widget_complete_form_alter()` by combining every condition's `applyCondition()` `AccessResult` and setting the widget's `#access` to `!$access->isForbidden()`.

Because enforcement sets Drupal's form `#access` (not merely CSS/visual hiding), a forbidden field is removed from the form and its value cannot be submitted by an unauthorised user. `AccessByRole` allows when the current user has any selected role; `AccessByPermission` allows when the user holds the chosen permission; both return `neutral` when not enabled so other conditions still apply. Configuration happens on the standard Field UI "Manage form display" widget settings, so it inherits Field UI's own admin permissions. New conditions can be added by other modules by implementing `FormDisplayVisibilityConditionInterface`.
---
Enforcement uses form `#access`, so hidden fields are genuinely inaccessible (not just visually hidden). Conditions AND together — every enabled condition must not forbid. Requires `field_ui`. Configuration surface is the admin-only Manage form display page.
---
- Hide a field on the node edit form from users lacking a specific permission.
- Restrict editing of a field to selected roles only.
- Show an internal "editorial notes" field only to editors, not authors.
- Gate a "publish options" field behind a custom permission.
- Combine role and permission conditions on the same field (both must pass).
- Configure conditions per field on "Manage form display".
- Apply different visibility per form mode (default vs a custom form mode).
- Keep sensitive fields out of the submitted form data for unauthorised users.
- Limit a taxonomy or workflow field to moderators.
- Let contributors see a reduced form while editors see the full one.
- Restrict a pricing field to a "manage pricing" permission.
- Enable/disable each condition independently via its checkbox.
- Add a project-specific condition plugin implementing the interface.
- Read a widget's condition summary on the Manage form display overview.
- Prevent role-less anonymous-adjacent users from editing privileged fields.
- Scope field access without writing custom `hook_form_alter` code.
- Reuse the same condition config across bundles by exporting form displays.
- Provide per-field access that travels with configuration (in `entity_form_display`).
