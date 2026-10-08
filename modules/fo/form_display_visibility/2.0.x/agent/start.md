<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Form Display Visibility (form_display_visibility) — agent index

**Attaches pluggable per-field visibility/access conditions (by role or permission) to entity form-display widgets and enforces them via form `#access`.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** `field_ui`
- **Plugin type:** `FormDisplayVisibilityCondition` — manager `plugin.manager.form_display_visibility_condition` (`FormDisplayVisibilityConditionPluginManager`), interface `FormDisplayVisibilityConditionInterface`, annotation `Annotation/FormDisplayVisibilityCondition`
- **Bundled conditions:** `access_by_role` (`AccessByRole`), `access_by_permission` (`AccessByPermission`)
- **Enforcement:** `form_display_visibility_field_widget_complete_form_alter()` sets `['widget']['#access'] = !$access->isForbidden()` (conditions AND together)
- **Storage:** field-widget third-party settings inside `entity_form_display` config
- **Routes/permissions of its own:** none (uses Field UI's admin pages)

**Security:** Enforcement is real form `#access`, so a forbidden field is removed and its value cannot be submitted by an unauthorised user — not merely visual hiding. Configuration surface is the admin-only Field UI "Manage form display" page. No anonymous or mutating endpoints.

See [extend/conditions.md](extend/conditions.md)
