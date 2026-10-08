# ClamAV Hooks

## `hook_clamav_file_is_scannable(FileInterface $file)`

Decide, per file, whether ClamAV should scan it. Called by `Scanner::isScannable()` after the
default scheme rule; every implementation runs, and the **heaviest** module (highest weight)
wins — each non-IGNORE return overwrites the running decision.

Return one of:

- `Scanner::FILE_IS_SCANNABLE` (`TRUE`) — force this file to be scanned.
- `Scanner::FILE_IS_NOT_SCANNABLE` (`FALSE`) — exempt this file from scanning.
- `Scanner::FILE_SCANNABLE_IGNORE` (`NULL`) — no opinion; leave the current decision unchanged.

### Example — skip image files

```php
use Drupal\clamav\Scanner;
use Drupal\file\FileInterface;

function mymodule_clamav_file_is_scannable(FileInterface $file) {
  $mime = $file->getMimeType();
  if ($mime && str_starts_with($mime, 'image/')) {
    return Scanner::FILE_IS_NOT_SCANNABLE;
  }
  return Scanner::FILE_SCANNABLE_IGNORE;
}
```

Typical use cases from `clamav.api.php`: exempt "safe" types, skip very large files that could
time out, avoid double-scanning files already checked by a CDN/cloud backend, or deliberately
allow storing known-infected files (security research) — while still returning IGNORE for
everything else so other modules keep control.

No other hooks are defined by this module. (It also implements core's
`hook_entity_create` and `hook_requirements` internally — those are not extension points.)
