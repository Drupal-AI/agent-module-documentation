# Extrafield Views Integration — manual setup guide

**Extrafield Views Integration** (`extrafield_views_integration`) is a developer
module that makes Drupal core "extra fields" available inside Views. Extra fields
are the display‑only pseudo‑fields that modules add to an entity's *Manage
display* tab (declared in code via `hook_entity_extra_field_info`). Core does not
let you add those to a View — this module bridges that gap so a computed,
code‑driven value can appear as a column in a Views listing.

It works by scanning every content entity type and bundle for `display` extra
fields that declare a special `render_class` key, and registering a Views field for
each one. When you place that field in a View, the module calls your render
class's static `render()` method, handing it the current row's entity, and uses the
returned string or render array as the cell's output. The handler runs no database
query — it is purely a render‑time computed column.

Because the logic lives entirely in a render class you write, there is no admin
settings page, no permissions, and no UI beyond the Views field itself. It is aimed
at developers who want to surface a derived value (a formatted total, a badge, a
call‑to‑action link, aggregated related data) in Views without building a full
custom Views field plugin. Extra fields that do not declare a `render_class` key
are simply ignored.

This guide is written for a **human** (here, a developer) working through the code
and Views UI. If you want terse, token‑cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. You use the module in two places: in your module's PHP
code (to declare the extra field and its render class) and in the **Views UI**
(`/admin/structure/views`) when you add the generated field to a view.

## How to use it

Using the module is a three‑step, code‑plus‑Views workflow.

**1. Declare a `display` extra field with a `render_class` key.** In your own
module, implement `hook_entity_extra_field_info()` and add the non‑core
`render_class` key pointing at a class you provide:

```php
function mymodule_entity_extra_field_info() {
  $extra['node']['article']['display']['mymodule_cta'] = [
    'label' => t('Call to action'),
    'description' => t('Computed CTA link.'),
    'weight' => 0,
    'visible' => FALSE,
    'render_class' => \Drupal\mymodule\ArticleCta::class,
  ];
  return $extra;
}
```

**2. Implement `ExtrafieldRenderClassInterface`.** The class needs one **static**
`render()` method that receives the row's entity and returns a string or a render
array:

```php
namespace Drupal\mymodule;

use Drupal\Core\Entity\EntityInterface;
use Drupal\extrafield_views_integration\lib\ExtrafieldRenderClassInterface;

class ArticleCta implements ExtrafieldRenderClassInterface {
  public static function render(EntityInterface $entity) {
    return ['#markup' => '<a class="cta" href="/go">Read more</a>'];
  }
}
```

Because the method is static, there is no dependency injection — use
`\Drupal::service(...)` if you need services, and sanitize your own output (raw
strings are not auto‑filtered).

**3. Add the field in Views.** The module registers a field named
*"Extrafield &lt;label&gt;"* on the entity's base table. Add it to your view like
any other field; at render time it calls your class against each row's entity. If
the render class is missing or mistyped, the site builder sees a warning message
and an empty cell rather than a fatal error.
