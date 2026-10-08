<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extend — layout_builder_operation_link

The module is three hook implementations in `.module` (no services, no API file). To change the
link, hook the same entity-operation pipeline from your own module.

## How the link is generated

`hook_entity_operation(EntityInterface $entity)` returns:

```php
return [
  'layout' => [
    'title'  => t('Layout'),
    'weight' => 50,
    'url'    => Url::fromRoute("layout_builder.overrides.{$entity_type_id}.view", [$entity_type_id => $entity->id()], $route_options),
  ],
];
```

It returns nothing (no link) unless
`\Drupal::service('access_manager')->checkNamedRoute("layout_builder.overrides.$type.view", [$type => $id], $account)`
passes — that single access check enforces "bundle has overrides + user may edit this layout".
`$route_options['language']` is added only when the entity is fieldable, has the
`OverridesSectionStorage::FIELD_NAME` field, and that field definition is translatable.

## Alter, remove, reweight, or relabel the link

Use core's `hook_entity_operation_alter(array &$operations, EntityInterface $entity)` — it runs
after this module has added `$operations['layout']`:

```php
function mymodule_entity_operation_alter(array &$operations, \Drupal\Core\Entity\EntityInterface $entity) {
  if (isset($operations['layout'])) {
    $operations['layout']['title']  = t('Edit layout');   // relabel
    $operations['layout']['weight'] = 5;                   // move earlier in the dropbutton
    // unset($operations['layout']);                       // remove it entirely (e.g. for a bundle)
  }
}
```

To add the link for an entity type that does *not* show it, you would instead ensure Layout
Builder overrides + permissions exist; the link follows automatically.

## The `destination` workaround

`template_preprocess_links()` (implemented as
`layout_builder_operation_link_preprocess_links(&$variables)`) removes the hardcoded
`destination` query parameter from the `layout` link inside `links__dropbutton__operations`.
Views' `EntityOperations::render()` hardcodes `destination`, which would otherwise override Layout
Builder's own post-save redirect (`OverridesEntityForm::redirectOnSubmit()`), sending the editor
back to the listing instead of the saved layout. If you clone/re-render this link elsewhere, keep
that unset or your Save/Cancel redirect will misbehave. (Core issue drupal.org/project/drupal/issues/2950883.)

## Caches

The link is part of rendered operations output. `hook_install()` and `hook_uninstall()` invalidate
the `rendered` cache tag so links appear/disappear immediately after (un)installation. After
toggling Layout Builder overrides on a bundle, run `drush cr` (or invalidate `rendered`) so
listings pick up the change.
