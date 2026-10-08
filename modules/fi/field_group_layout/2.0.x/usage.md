<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Layout extends the Field Group module with a "Layouts" group formatter, letting a field group use any Layout Discovery / Layout API layout (one column, two column, three column, etc.) and place its child fields into the layout's regions on Manage form display and Manage display.

---

The module registers a `field_group` formatter plugin `layouts` (`LayoutFormatter`) available in both the `form` and `view` contexts, plus an overridden `default` formatter. When you set a field group's format to **Layouts**, its settings form adds a "Select a layout" dropdown populated from the core layout plugin manager (`plugin.manager.core.layout`); choosing a layout exposes that layout's regions as sub-groups you drag fields into. At render time `hook_field_group_pre_render_alter()` sets the group's `#theme_wrappers` to `field_group__<layout_id>` and `field_group_layouts`, and `hook_theme()` registers templates for the common core layouts (onecol, twocol, twocol_bricks, threecol_25_50_25, threecol_33_34_33) alongside every discovered theme layout, so the group renders using the layout's own markup/regions. It hooks the Field UI display forms (`entity_form_display_edit_form`, `entity_view_display_edit_form`) to manage the region sub-groups: when the layout changes it remaps fields to the new regions (`_field_group_layout_field_layout_update_handler`), makes region rows non-draggable, and attaches admin CSS. Settings live in the display config's `third_party.field_group` third-party settings (schema adds `field_group.field_group_formatter_plugin.layouts`). No permissions, no Drush, no global config page — configuration is entirely per display via the Field UI. Requires `field_group` and core `layout_discovery`.

---

- Arrange the fields inside a field group into a two- or three-column layout on the node edit form.
- Use a core Layout (onecol/twocol/threecol) as the wrapper for a field group on the display.
- Give an entity's form a multi-column region structure without Layout Builder.
- Organize "Address" fields into columns within a grouped section on the edit form.
- Present a group of fields side-by-side on the rendered node display.
- Reuse any theme- or module-provided Layout Discovery layout for a field group.
- Switch a field group from a plain fieldset/tabs formatter to a region-based layout.
- Move fields automatically into the new layout's regions when you change the selected layout.
- Build a "sidebar + main" arrangement inside a single field group.
- Apply the twocol-bricks layout to alternate field widths in a group.
- Keep field-group layout config in the standard entity display third-party settings (exportable).
- Provide non-draggable, structured regions in the Field UI so editors can't break the layout.
- Use grouped layouts on custom entity types, media, users, or any bundle with field groups.
- Theme each layout region via the registered `field_group__<layout>` templates and suggestions.
- Combine nested field groups with a layout parent group.
- Add a "Default" (fieldset) field-group formatter with open/description/required-fields options.
- Lay out paragraph or media fields in columns on their edit forms.
- Migrate a Display Suite / Layout Builder column need into a lighter field-group-based layout.
- Target theme overrides per entity type, bundle, or group name using the generated theme suggestions.
