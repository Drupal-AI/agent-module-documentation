<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_cache_flush implementation

The module's entire runtime is one function in `cache_flush_time.module`:

```php
function cache_flush_time_cache_flush() {
  $time = \Drupal::service('date.formatter')->format(\time(), 'short');
  \Drupal::messenger()->addStatus(t('Cache flushed at @datetime', [
    '@datetime' => $time,
  ]));
}
```

## Behavior
- Core invokes `hook_cache_flush()` during a full cache rebuild (e.g. `drupal_flush_all_caches()`), which fires from the "Clear all caches" button at `/admin/config/development/performance`, from `drush cache:rebuild` (`drush cr`), and from other programmatic full flushes.
- On each flush it adds a **status** message: `Cache flushed at <datetime>`.
- `<datetime>` = current server time from `\time()` formatted with the `date.formatter` service using the `'short'` date format type (the site's configured Short date format).
- The `@datetime` placeholder is passed through `t()`, so it is rendered as a plain, auto-escaped string.

## Where the message shows
- Drupal messages render on the next page load for the acting session. Interactive UI flushes therefore show it in the admin messages area. A CLI/Drush flush adds the message to the request but there is no page to display it on.

## Install / enable
- `drush en cache_flush_time -y` (or Extend UI). No configuration, no permissions, no settings form (`configure` is null). Depends only on core `system`.
- Uninstall by disabling the module; it leaves no config or stored data behind.

## Customizing
- To change the displayed format, adjust the site's **Short** date format at `/admin/config/regional/date-time`, or fork the hook to pass a different format id / a custom pattern to `DateFormatter::format()`.
