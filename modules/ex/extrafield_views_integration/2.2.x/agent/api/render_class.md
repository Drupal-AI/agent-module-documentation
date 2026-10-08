# Exposing an extra field to Views

The module has no configuration — you opt an extra field into Views from **your** module's code.

## 1. Declare the extra field with a `render_class` key

In `hook_entity_extra_field_info()`, add a normal `display` extra field but include the extra
non-core key `render_class` (FQN of a class you provide):

```php
function mymodule_entity_extra_field_info() {
  $extra['node']['article']['display']['mymodule_cta'] = [
    'label' => t('Call to action'),
    'description' => t('Computed CTA link.'),
    'weight' => 0,
    'visible' => FALSE,
    'render_class' => \Drupal\mymodule\ArticleCta::class,   // <-- required by this module
  ];
  return $extra;
}
```

Only `display` extra fields that carry a `render_class` key are picked up; entities in the
`content` group are scanned (config entities are skipped).

## 2. Implement `ExtrafieldRenderClassInterface`

Source: `src/lib/ExtrafieldRenderClassInterface.php`. One **static** method:

```php
namespace Drupal\mymodule;

use Drupal\Core\Entity\EntityInterface;
use Drupal\extrafield_views_integration\lib\ExtrafieldRenderClassInterface;

class ArticleCta implements ExtrafieldRenderClassInterface {
  public static function render(EntityInterface $entity) {
    // Return a string or a render array.
    return ['#markup' => '<a class="cta" href="/go">Read more</a>'];
  }
}
```

Return either a string or a render array; it becomes the Views field output. Because it is
`static`, you get no service injection — use `\Drupal::service(...)` if you need dependencies.
Escape/sanitize your own output (raw strings are not auto-filtered by the handler).

## 3. Add the field in Views

`extrafield_views_integration_views_data_alter()` registers a Views field per qualifying extra
field, keyed `extrafield_views_integration__<field_name>` on the entity type's base table, with
title *"Extrafield &lt;label&gt;"*. Add it like any Views field; it applies to the row's entity.

## How the handler renders

`src/Plugin/views/field/ExtrafieldViewsIntegration.php`
(`@ViewsField("extrafield_views_integration")`, extends `FieldPluginBase`):

```php
public function query() {}                 // no query — pure render-time field
public function render(ResultRow $values) {
  if (class_exists($this->definition['render_class'])) {
    $class = $this->definition['render_class'];
    return $class::render($values->_entity);
  }
  $this->messenger()->addWarning('… render_class: @render_class does not exists.', …);
  return '';
}
```

The `render_class` reaches the handler via the Views-data `field` definition (`'render_class' =>
$extraField['render_class']`). A missing/typo'd class produces an admin warning message and an
empty cell rather than a fatal error.
