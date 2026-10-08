<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SDC Display lets you render Drupal fields, field groups, and whole view modes through Single Directory Components (SDC), mapping field values onto a component's props and slots from the display configuration UI.

---

The module wires SDC components into the display layer at three levels, all configured on
*Manage display* and stored as `third_party_settings.sdc_display` (or a field group's
`format_settings`). (1) **Per field:** `hook_field_formatter_third_party_settings_form()`
adds an "SDC Display" section to a field formatter; when `enabled` with a chosen
`component.machine_name`, `sdc_display_preprocess_field()` re-renders each field item as a
`#type => component`, feeding the field value into the mapped prop or slot (`mappings`
carry `static` fixed values and one `dynamic.mapped` input). (2) **Per view mode:**
`sdc_display_form_entity_view_display_edit_form_alter()` adds the same controls to the whole
view-mode form, and `sdc_display_entity_view_alter()` replaces the entire entity build with
a single component when the display's `sdc_display.enabled` is true, computing prop/slot
values from the mappings. (3) **Per field group:** it ships a `field_group`
`FieldGroupFormatter` with id `sdc_display` ("Single Directory Component", view context
only) to render a group's fields through a component. Which components appear in each picker
is governed by two component tags declared in `sdc_display.component_tags.yml` (via
`cl_editorial`'s `sdc_tags`): `sdc_display:field_formatter` and `sdc_display:view_mode`.
Forms are built with `cl_editorial`'s schema-driven form generator (`e0ipso/schema-forms`).
It has no admin settings page, permission, entity, or Drush command of its own, and depends
on `cl_editorial` + `sdc_tags`.

---

- Render an Article node's default view mode entirely through a `card` single directory component.
- Display a text field's value inside a component prop instead of the default field markup.
- Map an image field to a component's `image` slot for a designed media card.
- Wire a field group of fields into one component (e.g. a hero) via the `sdc_display` group formatter.
- Feed a taxonomy/reference field value into a component prop for badges or tags.
- Reuse a design-system component library across content types without writing formatters.
- Provide static prop values (title, variant) on a component and overlay one dynamic field value.
- Expose only design-approved components in the field picker via the `sdc_display:field_formatter` tag.
- Expose whole-view-mode components via the `sdc_display:view_mode` tag.
- Render a teaser view mode with a component that matches the front-end framework's markup.
- Bridge Drupal fields to a Storybook/CL-based component library.
- Keep component selection and prop/slot mapping in exported display config for deployment.
- Switch a field's rendering to a component only in a specific view mode.
- Map a field onto a component slot for rich-text content, static text onto other slots.
- Standardise cards/tiles across the site by pointing multiple view modes at one component.
- Avoid custom Twig field templates by mapping fields to component props directly.
- Populate a component's `id`, `entity_type`, and `bundle` automatically on whole-entity rendering.
- Compose a listing where each row's fields render through the same component.
- Prototype a redesign by re-pointing view modes at new components without touching PHP.
- Combine static defaults and dynamic field data to fully populate a component instance.
