<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Friendly Captcha key generation

Class: `Drupal\websecurity\EventSubscriber\FriendlyCaptchaKeysSubscriber`
(`src/EventSubscriber/FriendlyCaptchaKeysSubscriber.php`). Registered in `websecurity.services.yml`
with `autowire: true` + `autoconfigure: true` (so it is picked up as an event subscriber). Its only
constructor dependency is `ConfigFactoryInterface`.

## When it runs
- Subscribes to `RecipeAppliedEvent` (`getSubscribedEvents()` → `onRecipeApplied` → `setKeys()`), so it
  fires after **any** recipe finishes applying.
- Also called directly at the end of `websecurity_install()` after the module's own default recipe runs.

## How keys are sourced (exact mechanism)
`setKeys()` gets the editable config object `friendlycaptcha.settings`. If that config does not yet
exist (`$config->isNew()`), it returns without doing anything. Otherwise, for each of the keys
`site_key` and `api_key`:

```php
$value = (string) $config->get($key);
if ($value === '' || str_contains($value, '${')) {
  $config->set($key, Crypt::randomBytesBase64(32));
  $changed = TRUE;
}
```

If any key was empty or still contained a `${` recipe placeholder, it is replaced with a freshly
generated random value from `\Drupal\Component\Utility\Crypt::randomBytesBase64(32)` (32 cryptographically
random bytes, base64-encoded). The config is saved only when something changed.

**These keys are generated locally and stored in Drupal config — they are NOT read from an environment
variable, a Key entity, `getenv()`, `settings.php`, or any external service.** The recipe sets
`friendlycaptcha.settings.api_endpoint: local`, meaning Friendly Captcha's self-hosted (in-Drupal)
puzzle endpoint signs its puzzles with this site key, so each site simply needs its own unique random
pair rather than credentials obtained from the Friendly Captcha SaaS. Existing non-empty, non-placeholder
values are left untouched (the check is idempotent and non-destructive).
