# Services, helper, download route, and the safe-list event

## Services (`vendor_stream_wrapper.services.yml`)

| Service | Role |
|---|---|
| `vendor_stream_wrapper.stream_wrapper` | The `vendor://` wrapper, tagged `{ name: stream_wrapper, scheme: vendor }`. |
| `vendor_stream_wrapper.path_processor` | Inbound `path_processor` (priority 250) for `/vendor_files/...` requests. |
| `vendor_stream_wrapper.manager` | `VendorStreamWrapperManager` — URL resolution + safe-list logic. |
| `vendor_stream_wrapper.event_subscriber` | Loads `allowed_file_patterns` config into the safe list. |
| `vendor_stream_wrapper.asset.css.optimizer_decorator` / `...js...` | Decorate core `asset.css.optimizer` / `asset.js.optimizer`. |
| `logger.channel.vendor_stream_wrapper` | Module log channel. |

## Resolving URIs in code

Procedural helper in `vendor_stream_wrapper.module`:

```php
$url = vendor_stream_wrapper_create_url('vendor://vendor/package/file.css');       // absolute
$rel = vendor_stream_wrapper_create_url('vendor://vendor/package/file.css', FALSE); // root-relative
```

It delegates to `VendorStreamWrapperManager::createUrlFromUri($uri, $include_base_url = TRUE)`:
- non-`vendor://` URIs are returned unchanged;
- `vendor://` URIs are resolved via the stream wrapper's `getExternalUrl()`;
- with `$include_base_url = FALSE` the base path is stripped for embedding.

Deprecation: the misspelled `creatUrlFromUri()` still exists but is **deprecated** (removed in
3.0.0) — use `createUrlFromUri()`.

## Library rewriting

`hook_library_info_alter()` scans every library's `js` and `css` entries; any key starting with
`vendor://` is replaced by `vendor_stream_wrapper_create_url($path, FALSE)` (root-relative), so you
can write `vendor://pkg/file.css` directly in `*.libraries.yml`.

## Download route + safe-list

`vendor_stream_wrapper.routing.yml` declares `vendor_stream_wrapper.vendor_file_download` at
`/vendor_files/{filepath}` (regex `filepath: .+`, permission `access content`), handled by
`VendorFileDownloadController::download()`. Access to an individual file is gated by
`VendorStreamWrapperManager::isSafeListed($file_path)`, which tests the path against the collected
regex patterns.

### The pattern-collection event

`VendorStreamWrapperManager::getSafeListRegexPatterns()` lazily dispatches
`VendorStreamWrapperEvents::COLLECT_SAFE_LIST_REGEX_PATTERNS`
(`'vendor_stream_wrapper.collect_safe_list_regex_patterns'`) with a
`VendorStreamWrapperCollectSafeListRegexPatternsEvent`. Subscribers call
`$event->getVendorStreamWrapperManager()->addSafeListRegexPatterns([$regex, ...])`. To let a module
expose its own vendor assets, subscribe to this event and add already-anchored regex patterns:

```php
public static function getSubscribedEvents(): array {
  return [VendorStreamWrapperEvents::COLLECT_SAFE_LIST_REGEX_PATTERNS => 'addPatterns'];
}
public function addPatterns(VendorStreamWrapperCollectSafeListRegexPatternsEvent $event): void {
  $event->getVendorStreamWrapperManager()->addSafeListRegexPatterns(['/^mypkg\/dist\/.*\.js$/']);
}
```

The module's own subscriber contributes the patterns derived from `allowed_file_patterns` config
(see [configure/patterns.md](../configure/patterns.md)).
