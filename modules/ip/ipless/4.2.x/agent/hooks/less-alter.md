<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: `hook_less_alter()`

Declared in `ipless.api.php`. Lets a module alter Less information during asset processing.

```php
/**
 * Alter less information.
 *
 * @param array $less
 *   Less information.
 * @param \Drupal\Core\Asset\AttachedAssetsInterface $assets
 *   The attached assets for the current context.
 */
function hook_less_alter(array $less, \Drupal\Core\Asset\AttachedAssetsInterface $assets) {
  // Adjust the Less data before it is compiled.
}
```

For richer control over the actual parser, subscribe to the `ipless.file_compilation` event instead
(see [api/service.md](../api/service.md)) — its `IplessCompilationEvent::getLess()` returns the live
`Less_Parser` so you can add import dirs, variables, etc.
