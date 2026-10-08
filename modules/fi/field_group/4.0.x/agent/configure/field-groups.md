# Configure field groups

Field Group has **no standalone settings form**. Groups are created inline on core Field UI:

- Form groups: **Manage form display** (`.../form-display`).
- Display groups: **Manage display** (`.../display`).

Use the **Add group** action link (top of the table), pick a **format type**, drag fields
(and other groups) under the group's row, and set the group's per-format settings via the
gear/settings icon.

Manage form display with a Details group ("Article content") and a field dragged under it:
![Field group on Manage form display](../../../../../../../screenshots/field_group/4.0.x/manage-form-display.png)

The **Add field group** form — label, group name, and format type:
![Add field group form](../../../../../../../screenshots/field_group/4.0.x/add-group-form.png)

## Built-in format types (FieldGroupFormatter plugins)

| Format | id | Context | Notes |
|---|---|---|---|
| Fieldset | `fieldset` | form, view | `<fieldset>` with legend |
| Details | `details` | form, view | Collapsible; `open` setting |
| Details sidebar | `details_sidebar` | form | Details rendered in a sidebar region |
| Tab | `tab` | form, view | A single (vertical/horizontal) tab item |
| Tabs | `tabs` | form, view | Container of Tab groups; direction setting |
| HTML element | `html_element` | form, view | Arbitrary wrapper tag + classes/attributes |
| Accordion / Accordion item | `accordion` / `accordion_item` | form, view | From deprecated `field_group_accordion` submodule |

The Details group as rendered on the node form (wrapping its child fields):
![Field group rendered on the node form](../../../../../../../screenshots/field_group/4.0.x/group-on-node-form.png)

## Where it is stored

Groups are saved as **third-party settings** on the display config entity, not a separate
entity. Config keys (schema `field_group.entity_display.schema.yml`):

```yaml
# core.entity_form_display.<entity>.<bundle>.<mode>.third_party.field_group.<group_name>
children: [field_a, field_b, group_child]   # fields/subgroups in the group
label: 'My section'
parent_name: ''            # name of parent group, for nesting
region: content
weight: 0
format_type: details
format_settings: { ... }   # keyed by the format's own schema
```

Because they live in display config, groups export with `drush config:export` and deploy
like any other configuration. Common settings a format exposes: `label`, `open`
(details/accordion), `element`/`show_label`/`attributes`/`classes` (html_element),
`direction` (tabs), `required_fields`.
