# Webform UI build screens

No settings form — Webform UI adds editing routes to each webform. Access is gated by core
Webform permissions (`administer webform`, `edit webform`).

## Key routes (paths under `/admin/structure/webform/manage/{webform}`)
| Route | Path | Purpose |
|---|---|---|
| `entity.webform.edit_form` (core, table lives here) | `/…/{webform}` | Element list (drag/reorder/nest) |
| `entity.webform_ui.element` | `/…/element/add` | Choose an element type to add |
| `entity.webform_ui.element.add_form` | `/…/element/add/{type}` | Configure the new element |
| `entity.webform_ui.element.add_page` | `/…/element/add/page` | Add a wizard page |
| `entity.webform_ui.element.add_layout` | `/…/element/add/layout` | Add a layout container |
| `entity.webform_ui.element.edit_form` | `/…/element/{key}/edit` | Edit an element |
| `entity.webform_ui.change_element` | `/…/element/{key}/change` | Change element type |
| `entity.webform_ui.element.duplicate_form` | `/…/element/{key}/duplicate` | Duplicate |
| `entity.webform_ui.element.delete_form` | `/…/element/{key}/delete` | Delete |
| `entity.webform.source_form` | `/…/{webform}/source` | Raw YAML editor |
| `entity.webform_options.source_form` | `/…/options/manage/{webform_options}/source` | Options YAML |

Element forms are built by `Drupal\webform_ui\Form\WebformUiElement*Form` classes off the
`WebformElement` plugin definition. The Source editor writes the same `elements` YAML you
would deploy as config.
