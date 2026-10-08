<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types defined by UI Patterns

Four plugin managers (all defined in `ui_patterns.services.yml`), plus it **decorates**
core's SDC manager (`plugin.manager.sdc`) so every SDC component becomes UI-Patterns-aware.

| Plugin type | Manager service | Discovery dir | Purpose |
|---|---|---|---|
| `ui_patterns_source` | `plugin.manager.ui_patterns_source` | `Plugin/UiPatterns/Source` | Resolve a value for a prop/slot (textfield, token, entity field, menu, nested component…). Attribute: `#[Source(...)]`. |
| `ui_patterns_prop_type` | `plugin.manager.ui_patterns_prop_type` | `Plugin/UiPatterns/PropType` | Map a component's JSON-schema prop to a Drupal type; validate/normalize values. Attribute: `#[PropType(...)]`. |
| `ui_patterns_prop_type_adapter` | `plugin.manager.ui_patterns_prop_type_adapter` | `Plugin/UiPatterns/PropTypeAdapter` | Adapt a Drupal data structure (e.g. `Attribute`, links) onto a PropType. |
| `ui_patterns_derivable_context` | `plugin.manager.ui_patterns_derivable_context` | `Plugin/UiPatterns/DerivableContext` | Derive extra render contexts (e.g. per referenced entity) for sources. |

## Built-in PropType ids

`string`, `number`, `boolean`, `enum`, `enum_list`, `enum_set`, `identifier`, `links`,
`list`, `slot`, `attributes`. A component prop's `type` in its `*.component.yml` (plus any
`ui_patterns.type_definition`) selects the PropType; that in turn constrains which Source
plugins are offered in the config form.

## Source plugins (the value resolvers)

Static ids: `textfield`, `token`, `number`, `checkbox`, `checkboxes`, `select`, `selects`,
`attributes`, `class_attribute`, `component`, `entity_field`, `entity_reference`,
`entity_link`, `field_label`, `menu`, `breadcrumb`, `path`, `list_textarea`, `url`,
`wysiwyg`, `block`. Entity-field-property sources are **derived** per field:
`entity:field_property:<entity_type>:<field>:<property>`.

Each source declares which PropType(s) it can feed, so the UI only offers compatible
sources for a given prop. To add your own, see [../extend/source-plugin.md](../extend/source-plugin.md).
