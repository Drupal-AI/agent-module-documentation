<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create a "Not {bundle}" condition

The module provides the abstract base class
`Drupal\block_visibility_conditions\Plugin\Condition\NotConditionPluginBase`
(extends core `ConditionPluginBase`, implements `ContainerFactoryPluginInterface`). To add a
"Not" condition for any entity type that has a bundle config entity, subclass it and set one
constant — the bundle **config entity type id** (e.g. `node_type`, `taxonomy_vocabulary`,
`commerce_product_type`):

```php
namespace Drupal\my_module\Plugin\Condition;

use Drupal\block_visibility_conditions\Plugin\Condition\NotConditionPluginBase;

/**
 * @Condition(
 *   id = "not_media_type",
 *   label = @Translation("Not Media Type")
 * )
 */
class NotMediaType extends NotConditionPluginBase {
  protected const CONTENT_ENTITY_TYPE = 'media_type';
}
```

That is the entire concrete plugin — the three shipped submodules each contain exactly this shape.
Declare the target entity type's module as a dependency in your `*.info.yml`.

## What the base class does (so you don't re-implement it)
- `__construct` / `create`: injects `entity_type.manager` and `current_route_match`; resolves the
  bundle entity type and the entity type it is the bundle of (`getBundleOf()`).
- `defaultConfiguration()`: `['bundles' => []]`.
- `buildConfigurationForm()`: **removes** the `negate` element and renders a `checkboxes`
  element `bundles` listing every bundle (`label` => id) with a descriptive help text.
- `submitConfigurationForm()`: stores `array_filter($form_state->getValue('bundles'))`.
- `summary()`: human-readable "The {type} is {a, b or c}." string.
- `evaluate()`: returns `TRUE` (block visible) when no bundles are selected, when the current route
  has no entity of that type, or when the current entity's `bundle()` is **not** in the selected
  set; returns `FALSE` (hidden) only on a matching bundle's page. It reads the entity from the
  route parameter (loading it by id if the parameter is scalar).

This "not" logic is why the block still shows on views and other non-entity pages, unlike core's
negated bundle conditions.
