<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_callback_upgrade — the backport

Entire module logic (`migmag_callback_upgrade.module`):

```php
function migmag_callback_upgrade_migrate_process_info_alter(&$definitions) {
  if (version_compare(\Drupal::VERSION, '9.2.0', 'lt') && !empty($definitions['callback'])) {
    $definitions['callback']['class'] = MigMagCallback::class;
  }
}
```

So the `callback` plugin class is only swapped on cores **older than 9.2.0**.

## `Drupal\migmag_callback_upgrade\MigMagCallback`

Extends core `Callback`. Its `transform()` adds the `unpack_source` option: when
`configuration['unpack_source']` is set, the source **must** be an array, and it is spread as
arguments — `call_user_func_array($this->configuration['callable'], $value)`. Otherwise it
defers to the parent. This is exactly core 9.2's `callback` behaviour.

## On Drupal 9.2+ / 10 / 11

The version gate is false, so **nothing changes** — core's `callback` already supports
`unpack_source`. Verify:

```php
\Drupal::service('plugin.manager.migrate.process')->getDefinition('callback')['class'];
// -> Drupal\migrate\Plugin\migrate\process\Callback  (unchanged; MigMagCallback is NOT used)
```

No configuration, routes, permissions, Drush, or module dependencies.
