<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Product datalayer & extension event

## Install & enable

```bash
drush en eulerian_commerce_product -y
```

Requires the base `eulerian` module (with a configured domain and the page actually tracked) and
`commerce_product`. No config, routes or permissions.

## How it hooks in

`eulerian_commerce_product.module` implements `hook_page_attachments_alter`, delegating to
`Hook\EulerianCommerceProductHooks::pageAttachmentsAlter()`
(`#[Hook('page_attachments_alter')]`, autowired). It:

1. Returns early unless the base module has already set
   `$attachments['#attached']['drupalSettings']['eulerian']['datalayer']` (i.e. the page is tracked).
2. Merges the helper's array into that datalayer with `+=` (existing keys win).

Running on `_alter` guarantees it runs after the base module's `hook_page_attachments`.

## Helper (`Services\CommerceProductHelper::supplyDatalayer()`)

Service `eulerian_commerce_product.helper`, constructed with `@event_dispatcher`, `@request_stack`,
`@current_route_match`.

- Acts only when the route is `entity.commerce_product.canonical` **and** the request has a
  `commerce_product` that is a `ProductInterface`; otherwise returns `[]`.
- `supplyProductDatalayer($product)` returns:

```php
[
  'prdref'  => $product->uuid(),   // product UUID
  'prdname' => $product->label(),  // product title
]
```

- Then dispatches `Event\CommerceProductParamsEvent($product)` and, for each `name => value` set by
  subscribers, appends `'prdparam-' . $name => (string) $value`.

## Extension event (`Event\CommerceProductParamsEvent`)

Fired for every product datalayer build. Methods: `getProduct()`, `getParameters()`,
`getParameter($key)`, `setParameter($key, $value)` (chainable), `setParameters(array)`. Uses
`CacheableResponseTrait`. Subscribe to it to add product attributes (brand, category, price band, …)
that appear in the datalayer as `prdparam-<name>`.

```php
final class MyProductParams implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [CommerceProductParamsEvent::class => 'onBuild'];
  }
  public function onBuild(CommerceProductParamsEvent $event): void {
    $product = $event->getProduct();
    $event->setParameter('brand', $product->get('field_brand')->value ?? '');
  }
}
```

Values are cast to string and land in `drupalSettings` (JSON-encoded by core), then flattened by the
base module's `EA_prepare2Push()` before being pushed to Eulerian.
