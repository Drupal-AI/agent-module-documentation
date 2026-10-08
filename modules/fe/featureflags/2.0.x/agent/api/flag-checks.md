<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checking flags: manager service, static API, cache context

Source: `src/FlagManager.php`, `src/Entity/FeatureFlag.php`,
`src/Entity/FeatureFlagInterface.php`, `src/FeatureFlagContext.php`,
`featureflags.services.yml`.

## The manager service (`featureflags.manager` = `FlagManager`)

`FlagManager extends \Drupal\Core\State\State`. Constructed with `@keyvalue`,
`@cache.bootstrap`, `@lock`, and in its constructor it rebinds the store to the key-value
collection **`featureflags`** (`$this->keyValueStore = $key_value_factory->get('featureflags')`).
So a flag's state is an ordinary State entry stored in the `key_value` table under collection
`featureflags`, keyed by the flag id — **not** in config, **not** in a cookie/session.

`get($key, $default)` primes the whole collection once (`getAll()`) then defers to `State::get`,
so repeated `get()` calls in a request cost one query. Because it is a full `State` subclass you
also get `set()`, `delete()`, `deleteMultiple()`, `getMultiple()`, `setMultiple()`.

Typical direct use:

```php
$manager = \Drupal::service('featureflags.manager');
$on = (bool) $manager->get('my_flag', FALSE);
$manager->set('my_flag', TRUE);
```

## Static API on `FeatureFlag` (the usual entry point)

`Drupal\featureflags\Entity\FeatureFlag` exposes convenience methods that wrap the manager and
load the entity by id:

- `FeatureFlag::isActive(string $id): bool` — loads the entity; returns `FALSE` if it does not
  exist, otherwise `getState()`. **This is the documented check** used in application code.
- `FeatureFlag::setActive(string $flag_id): ?FeatureFlagInterface` — loads, calls the protected
  `activate()` (`manager->set($id, TRUE)` + invalidate the entity's cache tags), returns the flag
  or `NULL` if it does not exist.
- `FeatureFlag::setInactive(string $flag_id): ?FeatureFlagInterface` — same, with `FALSE`.

Instance methods (`FeatureFlagInterface`):

- `getState(): bool` — `manager->get($this->id(), FALSE)`.
- `setState(bool $state): FeatureFlagInterface` — `manager->set($this->id(), $state)`; returns
  `$this`. (Note: `setState` alone does not invalidate cache tags; `activate()`/`inactivate()` and
  therefore `setActive()`/`setInactive()` do.)
- `getDescription(): ?string`.

Example (matches the project's own docs):

```php
use Drupal\featureflags\Entity\FeatureFlag;

if (FeatureFlag::isActive('my_feature_flag')) {
  // Feature on.
}
else {
  // Feature off.
}
```

## Cache context `featureflags` (`FeatureFlagContext`)

Registered in `featureflags.services.yml` as `cache_context.featureflags` with tag
`{ name: cache.context }`, so it is addressable as the context string **`featureflags:{id}`**
(e.g. `featureflags:new_site`). It is a calculated context taking the flag id as its parameter:

- `getContext(string $flag_id)` returns `'1'` or `'0'` from `flagManager->get($flag_id, FALSE)`.
- `getCacheableMetadata(string $flag_id)` adds a cache tag for the flag.

**Always declare `featureflags:{id}` on output that varies on a flag**, e.g.:

```php
$build['#cache']['contexts'][] = 'featureflags:my_flag';
```

Without it, the first-rendered variant is cached and served regardless of later flag flips — the
classic "the flag does nothing" symptom.

Caveat (source note, not a security issue): `getCacheableMetadata()` adds the tag
`config:feature_flag.flag.{id}`, whereas the entity's real config cache tag is
`config:featureflags.flag.{id}` (config prefix `featureflags.flag`). The strings differ, so
relying on the context's own tag to auto-clear on a flag change is unreliable; prefer
`FeatureFlag::setActive()/setInactive()`, which invalidate the entity's correct cache tags.
