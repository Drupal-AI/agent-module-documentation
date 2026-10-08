<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Browser widget error highlight

The module's entire behaviour: give the Entity Browser entity-reference widget a red error
highlight on validation failure, matching how core flags standard form elements.

## Install / enable

- `drush en entity_browser_validation` (or via *Extend*). Requires the `entity_browser`
  module (`entity_browser_validation.info.yml` → `dependencies: entity_browser:entity_browser`).
- Nothing else to configure — no settings form, route, or permission.

## The hook (`entity_browser_validation.module`)

`entity_browser_validation_field_widget_single_element_entity_browser_entity_reference_form_alter(array &$element, FormStateInterface $form_state, array $context)`
— an implementation of
`hook_field_widget_single_element_WIDGET_TYPE_form_alter()` targeting the
`entity_browser_entity_reference` widget type.

Steps in the function body:

1. Guard: run only if `$context['items'] instanceof EntityReferenceFieldItemList`
   (`use Drupal\Core\Field\EntityReferenceFieldItemList;`).
2. `$field_name = $item->getFieldDefinition()->getName();`
3. `$parents = $context['form']['#parents'] ?? FALSE;` — when present, the element name becomes
   `$field_name . '[' . implode('][', $parents) . ']'` (e.g. `field_media[subform][0]`);
   otherwise it is just `$field_name`.
4. `$element['#attributes']['name'] = $elementName;` — this is the fix: the entity browser
   `details` wrapper normally has no `name`, so nothing can target it for error flagging.
5. `$element['#attached']['library'][] = 'entity_browser_validation/validation';` — attaches
   the CSS.

The added `name` gives Drupal's standard error-flagging the target it needs, so the widget
receives the same `error` class core puts on failed inputs/selects/textareas (README: "this is
basically done by adding a class 'error' to the field widget, just as core does").

## The CSS library

`entity_browser_validation.libraries.yml`:

```
validation:
  version: VERSION
  css:
    theme:
      css/validation.forms.css: {}
```

`css/validation.forms.css` has a single rule:

```
.form-wrapper details.error {
  color: #a51b00;
  border-width: 1px;
  border-color: #e62600;
  background-color: hsla(15, 75%, 97%, 1);
  box-shadow: inset 0 5px 5px -5px #b8b8b8;
}
```

To restyle the highlight, override `.form-wrapper details.error` in your theme (the module
loads its CSS in the `theme` group so a later theme rule wins).

## Scope & caveats

- Applies only to widgets of type `entity_browser_entity_reference`; other widgets are untouched.
- Purely presentational — it does not add, change, or skip any validation constraint; it only
  makes an already-failing field visible.
- No JavaScript, config schema, or install step ships with the module.
