# Field widget — `entity_browser_entity_reference_override`

The submodule's whole surface: one Field API **widget** that lets an
`entity_reference_override` field select entities through an **Entity Browser** while keeping the
parent module's per-reference override text.

| Property | Value |
|---|---|
| Plugin id | `entity_browser_entity_reference_override` |
| Label | "Entity browser" |
| Class | `Drupal\entity_reference_override_entity_browser\Plugin\Field\FieldWidget\EntityReferenceOverrideEntityBrowser` |
| Extends | `Drupal\entity_browser\Plugin\Field\FieldWidget\EntityReferenceBrowserWidget` |
| `multiple_values` | `TRUE` (widget handles the whole multi-value field itself) |
| `field_types` | `entity_reference_override` (only) |
| Settings schema | `field.widget.settings.entity_browser_entity_reference_override` → inherits `field.widget.settings.entity_browser_entity_reference` (Entity Browser's own settings: `entity_browser`, `field_widget_display`, `open`, `selection_mode`, cardinality, etc.). **Adds no keys of its own.** |

## Enable it (Manage form display)

The field must already be an **`entity_reference_override`** field (Field UI: add a field, pick
"Entity reference w/custom text" — see the parent docs). Then on the bundle's **Manage form
display**, set that field's widget to **"Entity browser"** and configure the Entity Browser as
usual (choose which browser, display of current selection, selection mode, etc.). Requires both
`entity_browser` and `entity_reference_override` enabled.

Set programmatically on the entity form display:

```php
$fd = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article');           // (entity_type, bundle)
$fd->setComponent('field_my_ref', [
  'type' => 'entity_browser_entity_reference_override',
  'settings' => [
    'entity_browser' => 'my_browser',             // an entity_browser.browser config id
    'field_widget_display' => 'label',
    'open' => TRUE,
    'selection_mode' => 'selection_append',
  ],
])->save();
```

## What the widget renders

`formElement()` calls the parent `EntityReferenceBrowserWidget` to build the standard Entity
Browser element (the "Add/Remove" selection UI plus a `current` items table), then augments it:

- Adds a hidden element `entity_reference_override_default_values` whose `#value` is a
  `serialize()`d map of `{delta => {override, target_id}}` for the current items — used to carry
  override text across the widget's AJAX add/remove rebuilds.
- Adds an **`override`** child (`#type => textfield`, `#size => 40`, `#weight => 10`) to every
  row of `current['items']`, pre-filled from that map.
  - Multi-value field → the override box gets a **`#placeholder`** set to the field's
    `override_label` setting.
  - Single-value field → the override box gets a **`#title`** set to `override_label`.

## Saving & AJAX behavior (the reason this class exists)

- **`massageFormValues()`** — after the parent massages the Entity Browser selection into field
  values, it copies each visible row's `override` (`$values['current']['items'][$delta]['override']`)
  onto `$massagedValues[$delta]['override']`. This visible textfield is the authoritative source
  of the saved override text (not the hidden serialized map).
- **`formElementDefaultValues()` / `submitIsRelevant()` / `formElementsDefaultValuesByTrigger()`**
  — on an AJAX rebuild triggered by *this* field instance (adding via the browser's hidden
  `target_id` element with `#ajax` event `entity_browser_value_updated`, or a `*_remove_*`
  button), the widget re-reads the hidden `entity_reference_override_default_values` element and
  restores each row's override so typed text isn't lost. `submitIsRelevant()` guards against
  reacting to other widget instances on the same form. The map is read with
  `unserialize(..., ['allowed_classes' => FALSE])`.
- **`removeItemSubmit()` / `removeOverrideItemSubmit()`** — when a single item is removed, it
  rebuilds both the hidden default-values map and the `current` values so the remaining rows keep
  their override text (matched to the retained `target_id`s).

Note (integrator caveat, not a setting): `removeOverrideItemSubmit()` parses the retained
target ids with the regex `preg_match_all('/media:(\d+)/', ...)`, i.e. it only re-aligns overrides
by target id for **media** references; for other target types the remove-remap falls back to
positional behavior. Add/normal-save paths are unaffected.

## Cross-reference

The override text, its label, its storage columns and how it is displayed all belong to the
parent field type — this submodule only swaps in the Entity Browser selection UI. See
`modules/en/entity_reference_override/2.0.x/agent/configure/field.md` (field settings +
`override_action` formatters) and
`modules/en/entity_reference_override/2.0.x/agent/plugins/plugins.md` (the plugin ids/classes,
including the reusable `OverrideTextWidgetTrait` used by the parent's own widgets).
