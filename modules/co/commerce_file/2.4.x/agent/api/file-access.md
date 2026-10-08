# commerce_file — access & download API

## Access enforcement (two layers, fail-closed)

**1. `hook_ENTITY_TYPE_access()` for files** (`commerce_file_file_access`) — runs on `download`/`view`
of any file:

- `bypass license control` or `administer commerce_license` permission → `neutral()` (defers to core).
- Current user is the file owner → `neutral()`.
- File is not licensable (`LicenseFileManager::isLicensable()` false) → `neutral()`.
- Otherwise → `AccessResult::forbiddenIf()` there is **no** active license for the user that
  `canDownload()`. So a licensable file with no valid license is forbidden.

**2. Download route** `commerce_file.download` → `/commerce-file/{file}/download`
(`FileDownloadController::access()`, `no_cache: TRUE`):

- bypass/admin permission → `allowed()`.
- not licensable → `neutral()` (route `_custom_access` treats non-allowed as denied → fail closed).
- else → `allowedIf()` the user has an active license that `canDownload()` the file.

**3. `hook_file_download()`** (`commerce_file_file_download`) — for core's private-file delivery: for
a permanent, licensable file with an active license it returns headers
`X-Commerce-File-ID` / `X-Commerce-License-ID` (used only for logging; core still runs its own file
access first). No license → returns nothing (core denies).

## `LicenseFileManager` service — `commerce_file.license_file_manager`

Implements `LicenseFileManagerInterface`. Central authority for licensing questions (statically
cached; `resetCache()` clears it, and `hook_entity_presave` resets it when variations/file licenses
are saved).

```php
$m = \Drupal::service('commerce_file.license_file_manager');

$m->isLicensable(File $file): bool;
// TRUE if any product variation references this file via commerce_file.target_id.

$m->getActiveLicenses(File $file, ?AccountInterface $account = NULL, ?PurchasableEntityInterface $pe = NULL): LicenseInterface[];
// Active 'commerce_file' licenses of $account (defaults to current user) for the
// variation(s) referencing the file. accessCheck(FALSE) internally.

$m->canDownload(LicenseInterface $license, File $file, ?AccountInterface $account = NULL): bool;
// TRUE if account may download: bypass/admin -> TRUE; else requires license 'view'
// access + state 'active'; then enforces the download limit via DownloadLogger counts.

$m->getDownloadLimit(LicenseInterface $license): int;   // 0 = unlimited (see setup.md precedence)
$m->shouldLogDownload(LicenseInterface $license, ?AccountInterface = NULL): bool; // false for bypass/admin & non-owners
```

## `DownloadLogger` service — `commerce_file.download_logger`

Implements `DownloadLoggerInterface`. Backed by DB table `commerce_file_download_log`.

```php
$logger->log(LicenseInterface $license, FileInterface $file);   // records uid/fid/license_id/ip/time
$logger->getDownloadCounts(LicenseInterface $license): array;   // [fid => count] for the license's files
$logger->clear(LicenseInterface $license);                      // wipes the log for a license (resets limits)
```

Logging is deferred: `FileResponseSubscriber` subscribes to `KernelEvents::TERMINATE` (priority 100)
and, when a successful response carries the `x-commerce-file-id` / `x-commerce-license-id` headers
and `shouldLogDownload()` is true (license owner, non-admin), calls `log()`. This catches downloads
served via the core file route too, since core doesn't dispatch a pre-download event.

## Computed field

`hook_entity_bundle_field_info` adds a computed, unlimited `licensed_files` file field to
`commerce_license` bundle `commerce_file` (class `ComputedLicensedFiles`) — the files a license
grants, for display/programmatic access.

## Plugin implementations shipped (not new plugin types)

- License type `File` (`commerce_file`), checkout pane `DownloadFile` (`commerce_file_download`),
  entity trait `ProductVariationCommerceFile` (`commerce_file`), field formatter
  `FileDownloadLinkFormatter` (`commerce_file_download_link`), field widget `DownloadLimitWidget`
  (`commerce_file_download_limit`), Views field `DownloadLimit`.
