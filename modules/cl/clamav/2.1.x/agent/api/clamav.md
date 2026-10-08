# ClamAV API

## The `clamav` service (`Drupal\clamav\Scanner`)

Injected as `@clamav` (constructor arg is the `@clamav_config` wrapper). On construction it
instantiates the concrete scanner (`DaemonTCPIP` / `Executable` / `DaemonUnixSocket`) based
on `scan_mode`.

Result constants:

- `Scanner::FILE_IS_UNCHECKED = -1` — not scanned (service unreachable, executable missing, or ERROR response).
- `Scanner::FILE_IS_CLEAN = 0` — scanned, no infection (empty files short-circuit to clean).
- `Scanner::FILE_IS_INFECTED = 1` — virus found.

Scannability constants (return values for the scannable hook):

- `Scanner::FILE_IS_SCANNABLE = TRUE`
- `Scanner::FILE_IS_NOT_SCANNABLE = FALSE`
- `Scanner::FILE_SCANNABLE_IGNORE = NULL`

Public methods:

| Method | Returns | Notes |
|---|---|---|
| `scan(FileInterface $file)` | int | Runs the active scanner; logs infections (always), clean/unchecked per verbosity/outage. Empty files return CLEAN without scanning. |
| `isEnabled()` | bool | `clamav.settings:enabled`. |
| `allowUncheckedFiles()` | bool | TRUE when `outage_action == OUTAGE_ALLOW_UNCHECKED`. |
| `isVerboseModeEnabled()` | bool | `clamav.settings:verbosity`. |
| `isScannable(FileInterface $file)` | bool | Combines scheme rule with all `hook_clamav_file_is_scannable()` implementations. |
| `version()` | string | Version reported by the active ClamAV backend. |
| `Scanner::isSchemeScannable($scheme)` (static) | bool | `local XOR overridden`; empty scheme → TRUE. |

### Scan a file from custom code

```php
/** @var \Drupal\clamav\Scanner $scanner */
$scanner = \Drupal::service('clamav');
if ($scanner->isEnabled() && $scanner->isScannable($file)) {
  $result = $scanner->scan($file);
  if ($result === \Drupal\clamav\Scanner::FILE_IS_INFECTED) {
    // Reject / delete $file. Virus name: the concrete scanner's virus_name().
  }
}
```

## How uploads get scanned automatically

1. `clamav_entity_create()` (in `clamav.module`) sets `$file->clamav_attemptScan = TRUE` on every entity implementing `Drupal\file\FileInterface`.
2. Core dispatches `Drupal\file\Validation\FileValidationEvent` during file validation.
3. `FileValidationSubscriber::onFileValidate()` (service `clamav.file_validation_subscriber`, tagged `event_subscriber`) checks the `clamav_attemptScan` flag, then if `isEnabled() && isScannable()` calls `scan()`:
   - `FILE_IS_INFECTED` → adds a `ConstraintViolation` ("A virus has been detected… will be deleted."), blocking the upload.
   - `FILE_IS_UNCHECKED` → adds a violation **only if** `!allowUncheckedFiles()` (fail-closed); otherwise the file passes.
   - Skipped/disabled files are logged when verbose mode is on.

## Scanner backends (`Drupal\clamav\ScannerInterface`)

Each backend implements `scan()`, `virus_name()`, `version()`. Daemon backends speak the
ClamAV `zINSTREAM` streaming protocol over a socket; `Executable` shells out to `clamscan`
and maps its exit code (0/1/≥2). These are internal — call the `clamav` service, not the
backends, unless you are extending behavior.
