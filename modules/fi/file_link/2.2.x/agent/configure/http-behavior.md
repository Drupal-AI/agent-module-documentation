# HTTP fetch behaviour, deferral & validation

File Link fetches `size` and `format` by performing an HTTP request to the target URL. How and
when that happens is tunable per field and site-wide.

## Per-field: immediate vs deferred

- **Immediate (default)** — on save the field validates the link and fetches the file's
  `Content-Length` / `Content-Type` to fill `size` / `format`. If `Content-Length` is missing it
  may GET the body to measure size. A MIME like `text/html; charset=UTF-8` is stored as
  `text/html` (charset stripped).
- **Deferred** (`deferred_request: TRUE`) — the field is **not** validated/fetched on save;
  instead the entity is queued and updated during cron. Good for imports and slow/unreachable
  targets. Check logs for fetch errors.

### Queue worker

`file_link_metadata_update` — `Drupal\file_link\Plugin\QueueWorker\FileLinkMetadataUpdate`.
Runs on cron and updates the queued entities' file_link metadata. (Helper:
`Drupal\file_link\FileLinkQueueItem`.)

## Site-wide `settings.php` flags

```php
// Do not follow HTTP redirects when validating a file_link (default: TRUE / follow).
$settings['file_link.follow_redirect_on_validate'] = FALSE;

// Completely disable ALL outbound HTTP requests when validating/saving file_link fields.
// Recommended for bulk content import operations (default: FALSE).
$settings['file_link.disable_http_requests'] = TRUE;
```

With `disable_http_requests = TRUE`, no size/format is fetched and no validation request is made —
useful to keep migrations fast and offline-safe.

## Validation: the `LinkToFile` constraint

`Drupal\file_link\Plugin\Validation\Constraint\LinkToFile` enforces that the URI points to a
**file** (not a directory) and that its extension is one of the field's `file_extensions` (unless
`no_extension` is TRUE). Together with the inherited link constraints (`LinkAccess`,
`LinkExternalProtocols`, `LinkNotExistingInternal`) this rejects directory links and disallowed
extensions at validation time.

## No admin page

There is **no `configure` route**. All behaviour is set via the field settings
(`file_extensions`, `no_extension`, `deferred_request`), the formatter's `format_size` option,
and the two `settings.php` flags above.
