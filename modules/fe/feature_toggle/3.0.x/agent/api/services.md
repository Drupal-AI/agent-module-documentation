<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, the Feature object & events

## `feature_toggle.feature_manager` — `FeatureManagerInterface`

CRUD over feature **definitions** (config `feature_toggle.features`). Works with `Feature` value
objects.

| Method | Returns | Notes |
|---|---|---|
| `featureExists(string $name)` | `bool` | |
| `getFeature(string $name)` | `Feature|null` | |
| `getFeatures()` | `Feature[]` | keyed by name |
| `addFeature(FeatureInterface $feature)` | void | throws `\InvalidArgumentException` if it exists |
| `updateFeature(FeatureInterface $feature)` | void | throws if it does **not** exist |
| `deleteFeature(string $name)` | void | removes the config entry **and** the status flag |

## `feature_toggle.feature_status` — `FeatureStatusInterface`

The on/off **status** (key-value collection `feature_toggle`, key `flags`).

| Method | Returns | Notes |
|---|---|---|
| `getStatus(string $name)` | `bool` | `true` only if the flag is set truthy |
| `setStatus(FeatureInterface $feature, bool $status)` | void | writes the flag, dispatches events, clears cache tags |

`getStatusFlags(): array` (on the shared `FeatureUtilsTrait`) returns the whole `[name => bool]`
map.

## The `Feature` value object

`Drupal\feature_toggle\Feature` implements `FeatureInterface`:

```php
$f = new Feature($name, $label, $description = '');
$f->name(); $f->label(); $f->description();
$f->toArray();                 // ['name'=>…, 'label'=>…, 'description'=>…]
Feature::fromArray($data);     // static factory
```

## Events

`setStatus()` dispatches `Drupal\feature_toggle\Event\FeatureUpdateEvent` twice:

- on the constant `FeatureUpdateEvents::UPDATE` = `'feature_toggle.update'` (all features), and
- on `'feature_toggle.update.' . $feature->name()` (that specific feature).

```php
use Drupal\feature_toggle\Event\FeatureUpdateEvents;
use Drupal\feature_toggle\Event\FeatureUpdateEvent;

class MySubscriber implements \Symfony\Component\EventDispatcher\EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [
      FeatureUpdateEvents::UPDATE => 'onUpdate',                 // any feature
      'feature_toggle.update.beta_checkout' => 'onBetaCheckout', // one feature
    ];
  }
  public function onUpdate(FeatureUpdateEvent $event): void {
    $event->feature();  // FeatureInterface
    $event->status();   // new bool status
  }
  public function onBetaCheckout(FeatureUpdateEvent $event): void { /* … */ }
}
```

(Note: the `FeatureUpdateEvents` class only declares the `UPDATE` constant; the per-feature event
name is `UPDATE . '.' . $name`, built at dispatch time.)
