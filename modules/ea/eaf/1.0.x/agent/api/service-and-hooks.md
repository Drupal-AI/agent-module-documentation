<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FieldAttributeService, hooks & template variables

This is the path from stored attributes to entity markup. EAF ships **no rendering template** — it
only populates preprocess variables; the site theme must apply them.

## `FieldAttributeService` (`eaf.field_attribute.service`)

`src/FieldAttributeService.php`. Constructor args: `eaf.eaf_plugin_manager`, `entity_field.manager`.

- `isAllowed($field_definition): bool` — a sibling field may carry attributes when its type is in
  `ALLOWED_FIELD_TYPES` (`string`, `string_long`, `entity_reference`,
  `entity_reference_revisions`, `link`), it is **not read-only**, and its name is not in
  `FORBIDDEN_FIELD_NAMES` (`default_langcode`, `revision_default`, `revision_uid`,
  `revision_translation_affected`, `path`, `menu_link`, `parent_id`, `parent_type`,
  `parent_field_name`).
- `getAttributeFields(ContentEntityInterface $entity): array` — `{field_name: label}` of every
  `field_attributes_storage` field on the entity (the module generally uses the **first** one).
- `getAttributeFieldDefinition()` / `getAttributeFieldSettings()` — cached lookups of the attribute
  field's definition and its settings, keyed by `type-bundle-fieldname`.
- `getEntityFromFormState()` — returns the paragraph (`getParagraph()`) or entity (`getEntity()`)
  behind a form.
- `getFieldAttributeSectionName()` — returns `EntityAttributes::FIELD_ATTRIBUTES` (`_field_attributes`).
- `fieldWidgetCompleteFormAlter(&$element, $form_state, $context)` — the real work behind the
  `hook_field_widget_complete_form_alter` implementation: for each **non-attribute** field that the
  attribute field's settings enable, it injects per-field attribute widgets (under
  `widget[add_more][_field_attributes]`, with paragraphs-widget special-casing) and per-item widgets
  (under `widget[<delta>][_field_item_attributes]`), each a closed `details` with class
  `field-attribute--details`, and attaches `eaf/eaf.attribute-widget`. This is how attributes for
  *other* fields appear on the entity edit form next to those fields.

## Hooks — `Hook/EafHooks` (OOP `#[Hook]`, service autowired)

| Hook | Purpose |
|---|---|
| `field_widget_complete_form_alter` | Delegates to `FieldAttributeService::fieldWidgetCompleteFormAlter()` (inject field / field-item attribute widgets). |
| `preprocess_field` | Adds `field_attributes`, `field_item_attributes`, `field_name`, `entity_type`, `field_type`, `label_display` to the field template variables, read from the entity's **first** attribute field for this `field_name`. |
| `preprocess_node` | Calls `preprocessEntityCommon()` → sets `$variables['entity_attributes']`. |
| `preprocess_paragraph` | Calls `preprocessEntityCommon()` → sets `$variables['entity_attributes']`. |
| `preprocess_form_element__new_storage_type` | Attaches `eaf/eaf.field-type-icon` (shows the field-type icon when adding a field). |

`preprocessEntityCommon(&$variables, $entity, $section = 'entity_attributes')` finds the first
attribute field, reads its raw value, and sets `$variables['entity_attributes'] =
$value[0]['value'] ?? []` (the decoded attributes array), or an empty `stdClass` if the entity has no
attribute field.

## Consuming the variables in a theme

Because no template ships, a theme applies attributes itself, e.g. in the bundle's Twig:

```twig
{# node.html.twig — entity_attributes was set by preprocess_node #}
{% set eaf_classes = entity_attributes._entity_attributes.classes ?? [] %}
<article{{ attributes.addClass(eaf_classes) }}>
  {{ content }}
</article>
```

Twig autoescaping plus the plugin-side normalization (`EntityCssClass` runs
`Html::cleanCssIdentifier()` on every class, `FullWidth` only ever emits the literal `full-width`)
mean the shipped attributes are already safe CSS identifiers. If you write a custom attribute plugin
that stores free text, sanitize it in that plugin's `setValue()` and/or escape it in your template.

## Libraries

`eaf.libraries.yml` declares two internal **CSS-only** libraries (no external/CDN assets):

- `eaf.attribute-widget` — `css/eaf.attribute-widget.css` (makes the `field-attribute--details`
  widget wrapper full-width in the form). Attached by the widget and by the service.
- `eaf.field-type-icon` — `css/eaf.field-type-icon.css` (field-type icon from `icons/attribute.svg`).
  Attached on the "new storage type" form element.

## Services recap (`eaf.services.yml`)

- `eaf.eaf_plugin_manager` → `EntityAttributePluginManager` (`parent: default_plugin_manager`), aliased
  by class name.
- `eaf.field_attribute.service` → `FieldAttributeService`, aliased by class name.
- `Drupal\eaf\Hook\EafHooks` → autowired hook object.
