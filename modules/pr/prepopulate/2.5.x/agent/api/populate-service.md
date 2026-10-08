<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `prepopulate.populator` service

```yaml
# prepopulate.services.yml
prepopulate.populator:
  class: Drupal\prepopulate\Populate
  arguments: ['@request_stack', '@entity_type.manager', '@module_handler']
  required_cache_contexts: ['languages:language_interface', 'theme', 'user.permissions', 'url.query_args']
```

Implements `Drupal\prepopulate\PopulateInterface`:

```php
public function populateForm(array &$form, $request_slice = NULL): void;
```

- `$form` — a form **or any sub-element** of one (passed by reference, mutated in place).
- `$request_slice` — omit it to use `$request->query->all()['edit']`; pass an array to populate
  a subtree with your own values, or a scalar to set the value of a single leaf element.

Typical custom use (what `og_prepopulate` does):

```php
function mymodule_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  if ($form_id === 'node_article_form' && \Drupal::request()->query->has('ref')) {
    $form['#after_build'][] = 'mymodule_after_build';
  }
}

function mymodule_after_build($form) {
  $id = \Drupal::request()->query->get('ref');
  \Drupal::service('prepopulate.populator')
    ->populateForm($form['field_ref'], ['widget' => [0 => ['target_id' => $id]]]);
  return $form;
}
```

## Algorithm (what `populateForm()` actually does)

1. **Array slice** → for each key in the slice that exists in `$form`, work out the child's
   `#type` by probing, in order: `$element['widget'][0]['value']['#type']`,
   `$element['widget'][0]['target_id']['#type']`, `$element['widget']['#type']`,
   `$element['#type']`. Recurse only when the key is a real render-array child
   (`Element::child()`) and the type is empty **or** in the whitelist.
2. **Scalar slice** → set the leaf:
   - returns immediately if the element has no `#type`;
   - returns if `#value` is already a non-empty scalar (never overwrite);
   - returns if `#access === FALSE`;
   - `$value = Html::escape($request_slice)`;
   - `entity_autocomplete` → `#value = formatEntityAutocomplete()`;
   - `checkbox` → sets `#checked = ($value === 'true')` **and falls through** to also set `#value`;
   - anything else → `#value = $value`.

`formatEntityAutocomplete()` loads `$element['#target_type']` storage, and returns
`"{$entity->label()} ($id)"` when the entity exists **and** `$entity->access('view label')`
passes; otherwise it returns the raw value.

## The whitelist

`protected $whitelistedTypes` (18 entries, altered in the constructor via
`hook_prepopulate_whitelist_alter()`):

```
container, date, datelist, datetime, entity_autocomplete, email, fieldset,
inline_entity_form, language_select, machine_name, number, path, select,
tel, textarea, text_format, textfield, url
```

`radios` and `checkboxes` are **deliberately absent**: a site visitor must not be able to hand an
administrator a link that silently ticks permissions or settings on an admin form. (Note the
`checkbox` case *inside* the leaf switch is only reachable if something whitelists that type.)

Read the live list on a running site:

```bash
drush ev '$s=\Drupal::service("prepopulate.populator");
$p=(new ReflectionClass($s))->getProperty("whitelistedTypes"); $p->setAccessible(TRUE);
print implode(", ", $p->getValue($s)).PHP_EOL;'
```

## Entry point

```php
// prepopulate.module
function prepopulate_form_alter(&$form, FormStateInterface $form_state, $form_id) {
  if ($form_state->isRebuilding()) { return; }          // step 2+ of a multi-step form
  if (\Drupal::request()->query->has('edit')) {
    $form['#after_build'][] = 'prepopulate_after_build';
  }
}
```

`prepopulate_after_build()` then calls `populateForm($form)` with no slice.
