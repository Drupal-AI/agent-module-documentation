# The `bpmn_io` Modeler plugin (consumes modeler_api)

bpmn_io **does not define a plugin type**. It *implements* one:
`modeler_api`'s Modeler plugin type (attribute
`Drupal\modeler_api\Attribute\Modeler`, base
`Drupal\modeler_api\Plugin\ModelerApiModeler\ModelerBase`, namespace
`Plugin/ModelerApiModeler`).

## Declaration

`src/Plugin/ModelerApiModeler/BpmnIo.php`:

```php
#[Modeler(
  id: "bpmn_io",
  label: new TranslatableMarkup("BPMN.iO"),
  description: new TranslatableMarkup("BPMN modeler with a feature-rich UI."),
)]
class BpmnIo extends ModelerBase { ... }
```

## What it maps

modeler_api component types ↔ BPMN elements
(`BpmnIo::SUPPORTED_COMPONENT_TYPES`):

| modeler_api `Api::COMPONENT_TYPE_*` | BPMN element |
|---|---|
| START | `bpmn:StartEvent` |
| LINK | `bpmn:SequenceFlow` |
| ELEMENT | `bpmn:Task` |
| GATEWAY | `bpmn:Gateway` (exclusive) |
| SUBPROCESS | `bpmn:SubProcess` |
| ANNOTATION | `bpmn:TextAnnotation` |

Participants/swimlanes and annotations are read as metadata.

## Key interface methods it implements

- `getRawFileExtension()` → `'xml'`; `isEditable()` → `TRUE`.
- `edit($owner, $id, $data, $isNew, $readOnly)` — builds the canvas + toolbar +
  property-panel render array, attaches `bpmn_io/ui` and `drupalSettings.bpmn_io`
  (id, owner plugin id, BPMN XML, element templates, supported types).
- `convert($owner, $model, $readOnly)` — builds an empty model then attaches the
  owner entity's components/annotations/colors as `drupalSettings.bpmn_io_convert`
  so the JS lays out an existing entity that has no diagram yet.
- `configForm($owner)` — AJAX handler returning an `OpenOffCanvasDialogCommand`
  with the clicked element's configuration form (reuses the owner's plugin form;
  entity_autocomplete/number fields are downgraded to textfields for the panel).
- `prepareEmptyModelData(&$id)` — seeds a new diagram from `data/empty.bpmn`,
  substituting generated ids; `generateId()` → `Process_<random>`.
- Delegated to the `Parser` service: `parseData()`, `readComponents()`,
  `updateComponents()`, `getRawData()`, `enable()`, `disable()`, `clone()`,
  plus model getters `getId/getLabel/getTags/getChangelog/getTemplate/getStorage/
  getDocumentation/getStatus/getVersion`.

## Element templates

`PrepareComponents::getTemplates($owner)` turns each of the owner's available
components (events/conditions/actions) into a bpmn-js **element template**
(Camunda-style `camunda:property` / `camunda:field` bindings), so plugin config
fields render as element properties in the palette and property panel.

To provide your **own** modeler instead, implement the same `#[Modeler]` plugin
in your module — bpmn_io is one such implementation to copy from.
