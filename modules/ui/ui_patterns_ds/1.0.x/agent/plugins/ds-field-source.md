<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ds_field` source and the render plumbing

## The source plugin

`src/Plugin/UiPatterns/Source/DsField.php` — `DsField extends SourcePluginBase`, declared with:

```php
#[Source(
  id: 'ds_field',
  label: 'DS Field',
  description: 'Formatted display suite field.',
  prop_types: ['slot'],
  context_definitions: [
    'entity'             => ContextDefinition('entity', required: FALSE),
    'ui_patterns_ds'     => ContextDefinition('any'),            // the DS field name/key
    'ui_patterns_ds:field' => ContextDefinition('any', required: FALSE), // pre-built render array
  ]
)]
```

Because `prop_types` is `['slot']`, this source is selectable for any component **slot** in the
field-template settings form. Its purpose is to feed the current DS field's rendered output into
that slot.

`getPropValue()` resolves the value in two steps:

1. **Prefer the pre-built render array.** If the `ui_patterns_ds:field` context has a non-empty
   array value, return it directly. This is the path taken on every real render, and the only one
   that works for **DS pseudo-fields** (e.g. the "Title" field, whose DS field key `node_title`
   matches no real entity field).
2. **Fall back to a field lookup.** Otherwise, if `ui_patterns_ds` (field name) and `entity` are
   both present and `$entity->hasField($field_name)`, return `$entity->get($field_name)->view()`.
   This is used e.g. while building the Manage-display preview, where only field-name + entity are
   available.
3. If neither works, return `['#plain_text' => 'Unable to render field, please check the field settings.']`.

The two branches are exactly what `tests/src/Kernel/DsFieldSourceTest.php` asserts:
`testGetPropValueRendersMappedField` (lookup branch) and `testGetPropValuePrefersFieldRenderArray`
(render-array branch). Both assert the placeholder string is *never* emitted (issue #3504614).

## How the contexts get populated at render time

`ui_patterns_ds_preprocess_field__component()` in `ui_patterns_ds.module` runs on the `component`
field theme and builds the render element:

```php
$vars['component'] = [
  '#type'        => 'component',
  '#component'   => $ds_config['settings']['component_id'],
  '#ui_patterns' => $ds_config['settings'],
  // plus '#source_contexts' assembled below
];
```

It then assembles `#source_contexts`:

- `entity` — an `EntityContext::fromEntity($entity)`. The entity is discovered defensively: from
  `$vars['element']['#entity']`, `$vars['entity']`, `$vars['object']`, a nested `#parent` chain
  (walked up to 5 levels), or finally the current route's `node` parameter. The comment notes this
  is needed so tokens like `[plain:node:title]` in component attributes (e.g. an `aria-label`) can
  be resolved by the source plugins.
- `ui_patterns_ds` — a `string` context holding `$vars['field_name']` (DS's own field key, which
  may be a pseudo-field name, not a real entity field name).
- `ui_patterns_ds:field` — an `any` context holding `array_column($vars['items'], 'content')`, i.e.
  the field's already-computed per-item render arrays. This is what the source prefers in step 1.

`ui_patterns_ds_preprocess_ds_entity_view()` additionally re-adds the `entity` source context on
the DS entity view when the content element already carries `#source_contexts`/`#ui_patterns` and an
`#entity`, so entity-scoped sources keep working at the entity-view level.

## The context provider service (admin form only)

`src/ContextProvider/DsFieldContext.php` (service `ui_patterns_ds.ds_field`, tag `context_provider`)
implements `getRuntimeContexts()` to supply `ui_patterns_ds:field` **during the settings AJAX
request**. It reads `request_stack` POST, finds the `fields[*]` entry whose
`third_party_settings.ds.ft.id == 'component'`, then keys off `_triggering_element_name` to pull
that field's submitted settings array as the context value. It carries no persisted state; it only
mirrors the in-flight form submission so the component preview can build.

## Template

`templates/component.html.twig` is just `{{ component }}` — it prints the `#type => 'component'`
render array assembled in the preprocess. All escaping is handled by Drupal's render/component
pipeline; the field value is passed as a render array, not as a raw string, so field/formatter
output is auto-escaped as usual.

## Render flow summary

1. DS renders a field whose field template is `ui_pattern_ds_component` → theme `component`.
2. `ui_patterns_ds_preprocess_field__component()` builds `#type => 'component'` with the chosen
   `component_id`, the stored `#ui_patterns` settings, and the three source contexts above.
3. The component's slot configured with the `ds_field` source calls `DsField::getPropValue()`,
   which returns the field's render array (prebuilt, else looked up).
4. `component.html.twig` prints it.
