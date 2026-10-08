# Configure allowed vendor files

Config object **`vendor_stream_wrapper.settings`**, single key **`allowed_file_patterns`** (a
sequence of strings). UI: route `vendor_stream_wrapper.settings` →
`/admin/config/media/vendor-stream-wrapper` (permission `administer site configuration`).

## Why patterns are required

By default **no** file under `vendor/` is downloadable via `/vendor_files/...`. To expose files you
must add safe-list glob patterns. Each line is a glob relative to the vendor directory; `*` is the
only wildcard. Examples:

```
foo/bar/css/*.css      # all .css in vendor/foo/bar/css
foo/bar/js/app.js      # one specific file
somepkg/dist/*.js
```

The settings form is a textarea (one pattern per line); on save it `explode("\n")`s into the
sequence stored at `allowed_file_patterns`. A runtime `hook_requirements()` check shows a **warning**
on the status report when the list is empty.

## How a pattern becomes a rule

The event subscriber (`VendorStreamWrapperEventSubscriber::setAllowedPatternsFromConfig()`):
1. strips characters outside `[a-zA-Z0-9_/.\-*]`,
2. converts each glob to an anchored regex: `'/^' . str_replace('\*', '.*', preg_quote($pattern, '/')) . '$/'`.

So `foo/bar/*.css` → `/^foo\/bar\/.*\.css$/`. A file path matches if any pattern's regex matches
(`VendorStreamWrapperManager::isSafeListed()`).

## Read / write with drush

```bash
drush cget vendor_stream_wrapper.settings

# Allow all CSS in a package to be served:
drush php:eval '
  \Drupal::configFactory()->getEditable("vendor_stream_wrapper.settings")
    ->set("allowed_file_patterns", ["foo/bar/css/*.css", "foo/bar/js/*.js"])
    ->save();
'
```

Patterns are re-read per request (the manager memoizes within a request), so no cache rebuild is
needed for the safe-list to take effect.

## Locating the vendor directory (settings.php)

The wrapper looks for the vendor dir at `$settings['vendor_file_path']` first, then `../vendor`,
then `./vendor`. If your `vendor/` is elsewhere, add to `settings.php`:

```php
$settings['vendor_file_path'] = '/path/to/vendor';
```

If none is found a `VendorDirectoryNotFoundException` is thrown. This is a **settings.php** value,
not module config, and is not editable from the admin UI.
