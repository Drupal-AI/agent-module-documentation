<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_facebook_pixel_event_data_alter()`

The module's only hook (`facebook_pixel.api.php`). It is invoked at the **top** of
`FacebookEvent::addEvent()`, before the event is stored, via

```php
$this->moduleHandler->invokeAll('facebook_pixel_event_data_alter', [&$data, $event]);
```

so every implementation sees (and can rewrite) the payload of every event, whoever queued
it.

```php
/**
 * Implements hook_facebook_pixel_event_data_alter().
 */
function my_module_facebook_pixel_event_data_alter(array &$data, $event) {
  if ($event === 'ViewContent') {
    // Replace the SKU with the product id, as the catalogue feed expects.
    /** @var \Drupal\commerce_product\Entity\Product $entity */
    $entity = \Drupal::request()->get('_entity');
    $data['content_ids'][0] = $entity->id();
  }

  if ($event === 'Purchase') {
    $data['my_custom_dimension'] = 'newsletter';
  }
}
```

Signature: `(array &$data, string $event)`.

Events you can expect to see (from this module and `facebook_pixel_commerce`):
`ViewContent`, `CompleteRegistration`, `AddToCart`, `InitiateCheckout`, `Purchase`, plus any
custom name another module passes to `addEvent()`.

Notes and gotchas:

* The parameter is typed `array` in the example, but `addEvent()`'s `$data` defaults to the
  **string** `''` and `CompleteRegistration` passes a scalar uid. Type your implementation
  defensively (`if (!is_array($data)) { return; }`) or you will hit a TypeError on those
  events.
* `invokeAll()` means all implementations run; there is no way to stop propagation.
* The altered payload is what gets `json_encode()`d and XSS-filtered into
  `drupalSettings.facebook_pixel.events`, so keep it JSON-serialisable and free of markup.
* `PageView` is fired purely in JavaScript and never passes through `addEvent()`, so it
  cannot be altered with this hook.
* There is no alter hook for the pixel id, the visibility decision or the `<noscript>` image
  — override `facebook_pixel.settings` in `settings.php` for environment-specific ids.
