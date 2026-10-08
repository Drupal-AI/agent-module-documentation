<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `cloudfront` purger plugin

`src/Plugin/Purge/Purger/CloudFrontPurger.php` — a Purge `@PurgePurger`:

```php
@PurgePurger(
  id = "cloudfront",
  label = "CloudFront Purger",
  configform = "\Drupal\cloudfront_purger\Form\CloudFrontPurgerConfigForm",
  cooldown_time = 0.0,
  multi_instance = FALSE,
  types = {"path", "wildcardpath", "everything"},
)
```

So it handles path, wildcard-path, and "everything" invalidations; it is single-instance.
`getTimeHint()` returns `4.0s`, `hasRuntimeMeasurement()` is TRUE.

## `invalidate(array $invalidations)`

1. `buildInvalidationPaths()` converts the batch into CloudFront path strings:
   - `EverythingInvalidation` → returns `['/*']` immediately (whole distribution).
   - `PathInvalidation` → `'/' . ltrim($expression, ' /')` (leading slash, normalized).
   - `TagInvalidation` → `processTagInvalidation()` which in the **base** module marks it
     `NOT_SUPPORTED` (the `cloudfront_purger_tags` submodule overrides this to add tag support).
   - anything else → `NOT_SUPPORTED`.
2. If no paths → logs "No paths found to purge" and returns.
3. If `cloudfront_purger.settings:disabled` is true → logs and marks all **SUCCEEDED** (no AWS call).
4. Else reads `distribution_id` and calls `CloudFrontInvalidatorInterface::invalidate($paths, $id)`;
   on success marks all `SUCCEEDED`, on exception logs (via `Error::logException`) and marks `FAILED`.

## Services

- `cloudfront_purger.invalidator` → `CloudFrontInvalidator` (implements
  `CloudFrontInvalidatorInterface`). Its `invalidate(array $paths, $distribution_id): string`
  de-dupes paths and calls the AWS SDK:

  ```php
  $this->client->createInvalidation([
    'DistributionId' => $distribution_id,
    'InvalidationBatch' => [
      'CallerReference' => uniqid('', TRUE),
      'Paths' => ['Items' => $paths, 'Quantity' => count($paths)],
    ],
  ]);
  ```
  returns the created invalidation Id.

- `cloudfront_purger.cloudfront_client` (private) → an `Aws\CloudFront\CloudFrontClient` built by
  `cloudfront_purger.cloudfront_client_factory` (`CloudFrontClientFactory::createInstance`), which
  injects config credentials when present (else SDK default chain) and the region/version options.
- `logger.channel.cloudfront_purger` → the module's log channel.

## Extending (how the tags submodule does it)

Subclass `CloudFrontPurger` and override `processTagInvalidation(TagInvalidation $invalidation,
array &$paths)` to add tag → path mapping, and add `"tag"` to the plugin's `types`. That is exactly
what `cloudfront_purger_tags`'s `cloudfront_tags` purger does (hashing tags to `#<hash>` paths). To
change AWS-call behavior, decorate/replace the `CloudFrontInvalidatorInterface` service.

## Running it (no code)

```bash
drush p:purger-add cloudfront        # register the purger
drush p:invalidate path /some/page   # queue+process one path invalidation
```

With `disabled: true` this succeeds without contacting AWS; with `disabled: false` and a valid
`distribution_id` + credentials it issues a real `CreateInvalidation` (which AWS bills per request).
