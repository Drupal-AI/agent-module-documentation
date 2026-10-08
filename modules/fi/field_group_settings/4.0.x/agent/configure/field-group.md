<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Settings field group

There is no module settings page. Everything is configured through the **Field Group** UI on an
entity's *Manage form display* tab (`admin/structure/…/form-display`).

## Add the group

1. On *Manage form display*, click **Add field group**.
2. Choose format **Settings** (this module's formatter, plugin id `settings`, form context only),
   give it a label, save.
3. In the group's settings (gear on the group row) set **Roles that can view** — the
   `visible_for_roles` checkboxes. Leaving it empty means the group is visible to **no one**
   (`isVisible()` returns FALSE when the setting is empty).
4. Drag fields under the group, move the group into the visible region, and **Save**.

On the actual entity form the grouped fields render inside a hidden panel; a gear button
(`button[data-open-next-field-group-settings]`, floated right by `css/settings.css`) toggles the
`open` class on `.field-group-settings__inner` via `js/toggle.js` — pure client-side, no reload.

## Settings & storage

- Only setting: `visible_for_roles` (a list of role ids). Schema:
  `field_group_settings.field_group_formatter_plugin.settings` (extends
  `field_group.field_group_formatter_plugin.base`), key `visible_for_roles` (sequence of strings).
- Stored inside the form-display config, e.g.
  `core.entity_form_display.node.article.default` → `third_party_settings.field_group.group_settings`
  (the field_group entry) with `format_type: settings` and
  `format_settings.visible_for_roles: {…}`.
- Roles whose permissions include `bypass field_group_settings field visibility` are shown in the
  settings form **pre-checked and disabled** (`settingsForm()`), and are always treated as allowed
  in `settingsSummary()` / `isVisible()` regardless of the stored list.

## Visibility logic (`Settings::isVisible()`)

```
if current_user has 'bypass field_group_settings field visibility' -> visible
if visible_for_roles empty                                          -> hidden
if current_user roles ∩ visible_for_roles is non-empty              -> visible, else hidden
```

The result is applied as the group's `#access`, so a disallowed user does not get the fields in
the form at all (not merely hidden with CSS).

## Render element & theme (custom code)

- Render element: `['#type' => 'field_group_settings', …]` (`src/Element/Settings.php`) — supplies
  the `#process`/`#pre_render`/`#theme_wrappers` for the panel wrapper.
- Theme hook `field_group_settings` → `templates/field-group-settings.html.twig`, preprocessed by
  `template_preprocess_field_group_settings()` in `templates/theme.inc` (exposes `children`).
- Override the look by overriding that template or the `field_group_settings` library CSS.
