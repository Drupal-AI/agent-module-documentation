<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# og_prepopulate — URL syntax, widget alter and service

## Install

```bash
composer require drupal/og            # hard dependency, not shipped with prepopulate
drush en og_prepopulate -y            # pulls in prepopulate + og
```

`og_prepopulate.info.yml` declares `dependencies: [prepopulate:prepopulate, og:og]`, so without
Organic Groups the module cannot be installed at all.

## Status on Drupal 11 / OG 2.x

**Verified empirically on Drupal 11.4 with `drupal/og` 2.0.2, with `og_prepopulate` enabled:
the automatic URL prefilling does not run.** Two independent reasons:

1. **The hook no longer exists.** `og_prepopulate_field_widget_og_complex_form_alter()` is an
   implementation of `hook_field_widget_WIDGET_TYPE_form_alter()`, which was deprecated in
   Drupal 9.2 and **removed in Drupal 10**. `WidgetBase::formSingleElement()` now invokes
   `field_widget_single_element_form_alter` and
   `field_widget_single_element_<PLUGIN_ID>_form_alter`, so this function is never called.
2. **There is no `og_complex` widget in OG 2.x.**
   `\Drupal::service('plugin.manager.field.widget')->hasDefinition('og_complex')` is `FALSE`.
   The only widget OG 2.0.x ships is `og_autocomplete` ("OG context autocomplete"), and it
   declares `field_types: [entity_reference]`, so it does not even apply to an `og_audience`
   field (field type `og_standard_reference`) — such a field falls back to `options_select` on
   the default form display.

Consequences on this stack:

- `/node/add/<bundle>?og_audience=<nid>` has **no effect**.
- The "already has a value → hide the widget" branch also never runs.
- The parent module's own `hook_form_alter()` **does** still work, so
  `?edit[og_audience][widget][0][target_id]=<nid>` is the syntax that can still reach a field —
  but only if that field's widget renders an `entity_autocomplete` element (the `options_select`
  fallback is a `select`, which the parent populates by `#value`).
- The service `og_prepopulate.populator` is fully functional when you call it yourself — see
  [Service](#service) below. A working Drupal 11 bridge is a two-line module:

  ```php
  function mymodule_field_widget_single_element_form_alter(array &$element, FormStateInterface $form_state, array $context): void {
    if ($form_state->isRebuilding()) { return; }
    $field_name = $context['items']->getName();
    if (!\Drupal::request()->query->has($field_name)) { return; }
    $element['#after_build'][] = 'og_prepopulate_after_build';
  }
  ```

  (`og_prepopulate_after_build()` itself is still a valid callback and calls the service.)

## URL syntax

```
/node/add/article?og_audience=12
```

The parameter name is the **audience field's machine name**, the value is the group entity id.
This is deliberately shorter than the parent module's
`?edit[og_audience][widget][0][target_id]=12`, which also works when `prepopulate` is enabled.
(On Drupal 10/11 only the parent's form is actually reached — see
[Status on Drupal 11 / OG 2.x](#status-on-drupal-11--og-2x).)

## What the module does

```php
// og_prepopulate.module
function og_prepopulate_field_widget_og_complex_form_alter(&$element, FormStateInterface $form_state, $context) {
  if ($form_state->isRebuilding()) { return; }              // step 2+ of a multi-step form
  $field = $context['items'];                                // FieldItemList
  if (\Drupal::request()->query->has($field->getName())) {
    $element['#after_build'][] = 'og_prepopulate_after_build';
  }
  elseif (!$field->isEmpty()) {
    $element['#access'] = FALSE;                             // already set -> hide the widget
  }
}

function og_prepopulate_after_build($element) {
  $field_name = reset($element['#parents']);
  $entity_id = \Drupal::request()->query->get($field_name);
  \Drupal::service('og_prepopulate.populator')
    ->populateForm($element, ['target_id' => $entity_id]);
  return $element;
}
```

Only the `og_complex` widget is targeted (`hook_field_widget_WIDGET_TYPE_form_alter`), so an OG
audience field configured with a plain `entity_reference_autocomplete` widget falls back to the
parent module's behaviour. On Drupal 10/11 **neither** the hook nor the widget exists any more,
so the block above is effectively dead code — the `#after_build` callback and the service it
calls are the only reusable parts.

## Service

```yaml
# og_prepopulate.services.yml
og_prepopulate.populator:
  class: Drupal\og_prepopulate\Populate
  arguments: ['@request_stack', '@entity_type.manager', '@module_handler', '@current_user']
```

`Drupal\og_prepopulate\Populate extends Drupal\prepopulate\Populate` and overrides exactly one
method:

```php
protected function formatEntityAutocomplete($value, array &$element): string {
  $entity = $this->entityTypeManager->getStorage($element['#target_type'])->load($value);
  if ($entity && Og::isMember($entity, $this->currentUser->getAccount())) {
    $element['#value']  = "{$entity->label()} ($value)";
    $element['#access'] = FALSE;          // fill AND hide
    return "{$entity->label()} ($value)";
  }
  return $value;                          // not a member -> raw id, widget stays visible
}
```

So the behavioural differences from the parent are:

| | `prepopulate` | `og_prepopulate` |
|---|---|---|
| Access check | `$entity->access('view label')` | `Og::isMember($entity, $account)` |
| On success | sets `#value` | sets `#value` **and** `#access = FALSE` |
| Trigger | any `edit[...]` query param | `?<field_name>=<id>` on an `og_complex` widget |

Everything else (the 18-type whitelist, `Html::escape()`, never overwriting an existing scalar
`#value`, skipping `#access: FALSE` elements) is inherited unchanged — see the parent's
[api/populate-service.md](../../../../2.5.x/agent/api/populate-service.md).

### Calling it directly (works on Drupal 11)

Verified on a live Drupal 11.4 + OG 2.0.2 site. The element you pass must be the *widget*
element, i.e. `['target_id' => ['#type' => 'entity_autocomplete', …]]`:

```php
\Drupal::service('account_switcher')->switchTo($user);
$element = ['target_id' => ['#type' => 'entity_autocomplete', '#target_type' => 'node']];
\Drupal::service('og_prepopulate.populator')->populateForm($element, ['target_id' => $group->id()]);
\Drupal::service('account_switcher')->switchBack();

// member of $group      → $element['target_id']['#value'] === 'Group label (12)', ['#access'] === FALSE
// NOT a member          → $element['target_id']['#value'] === '12',               ['#access'] unset
```

## Extending it

Subclass `Drupal\og_prepopulate\Populate` and override `formatEntityAutocomplete()` to use a
different membership/permission rule, then point your own service at the class and call it from
your own `#after_build`.
