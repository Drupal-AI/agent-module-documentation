<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `state_expirable.state` service

`Drupal\state_expirable\State\StateExpirable`, constructed with `@keyvalue` and `@keyvalue.expirable`. A State-API-shaped wrapper that stores expiring values.

```php
$state = \Drupal::service('state_expirable.state'); // or inject the service
$state->set('mymodule.flag', 'on', 3600);   // expires in 1 hour
$value = $state->get('mymodule.flag', $default);
$state->setMultiple(['a' => 1, 'b' => 2], 300);
$vals = $state->getMultiple(['a', 'b']);
$state->delete('mymodule.flag');
```

Use for short-lived server-side state (feature flags, rate-limit windows, cached lookups). Expiry is handled by the `keyvalue.expirable` backend; see `StateExpirableInterface` for the exact method signatures/TTL argument.
