<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Segmentio

Route `segmentio.admin_settings_form` — `/admin/config/system/segmentio` (permission `administer segmentio`). Config object `segmentio.settings`.

## Settings
- **segmentio_write_key** — your Segment source write key. Required; if empty while tracking would run, the module logs an `emergency` "No Write Key has been Configured".
- **segmentio_privacy** (default `1`) — when on, tracking is disabled for requests that send the `DNT` (Do-Not-Track) header (`$_SERVER['HTTP_DNT']`).
- **segmentio_track** — a map/list of `module:hook` callback identifiers (from `hook_segmentio_info()`) to enable. Each enabled entry's `{module}_{hook}` function is invoked to contribute to the tracking `variables`.

## Runtime
`hook_page_attachments()` builds `variables` from queued `track` events plus each enabled callback, then attaches:
```php
$build['#attached']['library'][] = 'segmentio/segmentio';
$build['#attached']['drupalSettings']['segmentio']['segmentio']['write_key'] = <write_key>;
$build['#attached']['drupalSettings']['segmentio']['segmentio']['variables'] = <variables>;
```
Both the write key and the variables (which may include user name/email when the user callback is enabled) are rendered client-side.
