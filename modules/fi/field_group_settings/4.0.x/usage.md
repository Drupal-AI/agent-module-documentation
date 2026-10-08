<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Settings adds a "Settings" field-group formatter that tucks a group of form fields into a collapsible panel toggled by a floating gear icon, and can restrict which roles even see that panel.

---

The module extends the [Field Group](https://www.drupal.org/project/field_group) module with one
new **form-context** field-group formatter (`FieldGroupFormatter` plugin id `settings`,
`src/Plugin/field_group/FieldGroupFormatter/Settings.php`). On an entity's *Manage form display*
tab you add a field group of type **Settings**, drop fields into it, and on the form those fields
render inside a hidden panel that a gear button (floating right) opens/closes — a lightweight JS
toggle (`js/toggle.js`, adding the `open` class; styled by `css/settings.css`) with no server
round-trip. The formatter's settings form adds a **"Roles that can view"** checkbox set; the group
is wrapped with `#access = isVisible()`, so for a user whose roles are not selected the group (and
its fields) is not rendered at all. A companion permission, **`bypass field_group_settings field
visibility`**, forces the group visible for any role that holds it (those role checkboxes are
shown pre-ticked and disabled in the settings form). The module also registers a render element
(`#type` `field_group_settings`) and a theme hook (`field-group-settings.html.twig` +
`templates/theme.inc`) used to build the wrapper markup. Config lives in the
`entity_form_display` component settings (schema
`field_group_settings.field_group_formatter_plugin.settings`, key `visible_for_roles`).

---

- Hide advanced/secondary form fields behind a collapsible "Settings" panel on an edit form.
- Declutter a long node or entity form by grouping optional fields under a gear toggle.
- Show a settings group only to Administrator/Editor roles and hide it from others.
- Give power users an "advanced options" area that regular authors never see.
- Keep meta/SEO/scheduling fields tucked away until an editor opens the panel.
- Reduce cognitive load on a complex content type's form.
- Group publishing/workflow controls into one togglable section.
- Provide a role-scoped panel of internal-only fields (e.g. editorial notes).
- Combine several field groups, using Settings for the "rarely touched" ones.
- Toggle field visibility purely client-side with no page reload (JS `open` class).
- Use `bypass field_group_settings field visibility` to let admins always see every settings group.
- Apply per-form-mode: show the settings panel in the default form but not in a simplified mode.
- Nest technical configuration fields under a discreet gear icon to keep the form clean.
- Add the render element `#type => 'field_group_settings'` in custom form code to reuse the wrapper.
- Theme the panel/gear via `field-group-settings.html.twig` and `css/settings.css` overrides.
- Standardise where "extra settings" live across many content types.
- Restrict which roles can edit a set of fields by hiding the whole group from them on the form.
- Pair with Field Group's other formatters (tabs/accordion) for a layered form UX.
