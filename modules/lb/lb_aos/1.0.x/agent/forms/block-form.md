<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_aos — the animation setting on Layout Builder block forms

All in `lb_aos.module`. `lb_aos_form_alter(array &$form, FormStateInterface $formState)` acts only
when `$form['#form_id']` is `layout_builder_add_block` or `layout_builder_update_block` (the two
core Layout Builder block dialogs). It appends a details group and a select:

```php
$form['animations'] = ['#type' => 'details', '#title' => t('Animations'), '#open' => FALSE, '#weight' => 0];
$form['animations']['animation_type'] = [
  '#type' => 'select',
  '#title' => t('Type'),
  '#default_value' => $component->get('animation_type'),
  '#options' => [ '' => t('None'), 'fade-up' => …, … ],
];
```

`$component` comes from `$formState->getFormObject()->getCurrentComponent()` — the
`Drupal\layout_builder\SectionComponent` being added/edited. The default value is read back from the
component's `animation_type` key, so re-opening the dialog shows the current selection.

## Options (`animation_type`)
`''` → None, plus the 22 AOS values, exactly as passed to AOS's `data-aos`:
`fade-up`, `fade-down`, `fade-right`, `fade-left`, `fade-up-right`, `fade-up-left`,
`fade-down-right`, `fade-down-left`, `flip-up`, `flip-down`, `flip-right`, `flip-left`,
`zoom-in`, `zoom-in-up`, `zoom-in-down`, `zoom-in-left`, `zoom-in-right`,
`zoom-out`, `zoom-out-up`, `zoom-out-down`, `zoom-out-left`, `zoom-out-right`.
To add/remove animations, edit this `#options` array — the value is passed through verbatim to
`data-aos`, so any value the AOS library understands works.

## Persisting the value
`array_unshift($form['#submit'], '_lb_aos_submit_block_form')` prepends the custom handler so it runs
**before** Layout Builder's default submit (which serialises the section/component into tempstore).
`_lb_aos_submit_block_form()` then does:

```php
$component = $formState->getFormObject()->getCurrentComponent();
$animation = $formState->getValue('animations');
$component->set('animation_type', $animation['animation_type']);
```

So the animation is stored as an extra key on the component's configuration, alongside Layout
Builder's own component data. It is persisted wherever that layout is persisted — the config export
for a default layout, or the entity's `layout_builder__layout` field for a per-entity override. There
is no separate config object and no config schema for this key.
