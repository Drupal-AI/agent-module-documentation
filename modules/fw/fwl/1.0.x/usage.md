<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Widget Layout (FWL) lets you set a percentage width and an optional maximum pixel width on each field widget in a form display, so entity edit forms can arrange fields into flexible columns.

---

It implements hook_field_widget_third_party_settings_form() to add 'Width in %' and 'Maximum width in px' inputs to each widget's settings under Manage form display, plus a settings-summary alter to show the chosen values. A small CSS/JS library applies the widths on the actual edit form, and a global settings form at /admin/config/fwl (perm 'administer site configuration') controls module-wide behaviour. Widths are stored as third-party settings on the form display config, so they travel with configuration export. It is a pure editing-experience enhancement — no entities, permissions, or runtime data. Use it to make dense admin forms more compact and readable by placing related fields on the same row.

---

- Place First name and Last name side by side on a form.
- Lay out address fields into a compact multi-column grid.
- Set a field widget to 50% width for two-up rows.
- Cap a text field's width with a max-width in pixels.
- Make long entity edit forms shorter and easier to scan.
- Group related fields on the same row in the node form.
- Improve editor UX on wide monitors.
- Configure widths per field from Manage form display.
- Export field widths with configuration.
- Create a responsive two-column form layout without a theme.
- Tighten up paragraph or inline-entity-form widgets.
- Give date-from / date-to fields equal half-widths.
- Reduce vertical scrolling on complex forms.
- Apply consistent form layouts across content types.
- Show configured widths in the widget settings summary.
- Adjust global behaviour from the FWL settings form.
