<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a field group to render as a component

There is **no admin settings page** for this module (`configure: null`). Everything is configured
per field group on an entity **view** display.

## UI steps

1. `admin/structure/types/manage/<bundle>/display` (or any entity's Manage Display) → **Add group**.
2. Choose format **Component** and give the group a label. Save. (On the *add* form you only get a
   notice: *"Attention: Component selection and setting are done in the group edit form."* — the
   component picker is not on the add form.)
3. Add fields to the group, then open the group's **settings (gear) edit form**. There the full UI
   Patterns component picker appears under a `ui_patterns` element: pick a **component**, a
   **variant**, and fill each **slot** and **prop** from a source.
4. To fill a slot/prop from the group itself, choose source **"Field group child"** (a slot filled
   with one of the group's children) or **"Field group label"** (the group's label). Any other UI
   Patterns source (field value, entity data, static, etc.) is also available.
5. Save the display. The choice exports with the view display.

## Where it is stored

View display third-party settings, `third_party_settings.field_group.<group_name>`:

```yaml
third_party_settings:
  field_group:
    group_my_card:
      children:
        - field_image
        - body
      parent_name: ''
      label: 'My card'
      format_type: component_formatter          # this module's formatter
      format_settings:
        label: 'My card'
        # field_group base settings (label_as_html, show_empty_fields, id, classes…) also live here
        ui_patterns:                            # the component configuration
          component_id: 'mytheme:card'          # SDC/component plugin id
          variant_id: 'default'
          slots:
            content:
              sources:
                - source_id: field_group_child  # a child's render array into this slot
                  # …source-specific settings, e.g. field_group_child: field_image
          props:
            heading:
              source_id: field_group_label      # group label into a string prop
```

The `format_settings.ui_patterns` shape (`component_id`, `variant_id`, `slots`, `props`) comes from
UI Patterns' `getComponentFormDefault()`; the exact slot/prop source structure is UI Patterns 2.x's
component form, not defined by this module. `format_settings.label_as_html` is a field_group base
setting that `field_group_label` reads (see [plugins/sources.md](../plugins/sources.md)).

## Notes

- The formatter is offered on **view displays only** (`supported_contexts = {"view"}`); it does not
  appear on Manage Form Display.
- This module contributes **no components**. If the component select is empty, no theme or module on
  the site has declared any SDC/UI Patterns component.
- `strict_config_schema` is disabled in the module's own tests — treat the `format_settings` schema
  as loosely validated at this beta stage.
