<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ArchiveService — API, routes, config, tables

## Install & enable

```bash
drush en advanced_filesystem_archive -y
```

Requires core `file` and the base `advanced_filesystem` module. Configure at
`/admin/config/media/advanced_filesystem/archive`.

## Service: `advanced_filesystem_archive.service` (`Service\ArchiveService`)

Constructor args (`*.services.yml`): `@config.factory`, `@database`, `@file_system`,
`@file.mime_type.guesser`, `@logger.factory`, `@current_user`.

| Method | Purpose |
|---|---|
| `streamZipDownload(array $fids): StreamedResponse` | Cap FID count/total size, log the request, stream a ZIP of the files. |
| `browseZip(FileInterface $file): array` | List ZIP entries (`name`, `size`, `compressed_size`, `is_dir`, `modified`) without extracting; sorted directories-first. |
| `extractZip(FileInterface $zip, string $scheme='public', string $subdir='adfs_extracted', bool $skipExisting=TRUE, array $mimeFilter=[]): array` | Extract each entry into a managed `File`; returns `{extracted, skipped, failed, files:int[]}`. |
| `getExtractedChildren(int $sourceFid): array` | Lineage rows for children extracted from a ZIP. |
| `getExtractionSource(int $childFid): ?object` | Lineage row for the ZIP a child came from. |
| `getDownloadLog(int $limit=100): array` | Recent rows from `adfs_archive_downloads`. |

### Download details

`streamZipDownload()` reads `max_files_per_download` (500) and `max_zip_size_mb` (2048) from
config, `intval`s + de-duplicates the FIDs, truncates to the file cap, and accumulates
`filesize()` until the size cap is hit. It inserts an audit row into `adfs_archive_downloads`
(`uid`, `fids_json`, `file_count`, `total_size`, `ip`, `created`) and returns a
`StreamedResponse` (`Content-Type: application/zip`, `Content-Disposition: attachment`,
`Cache-Control: no-store`). Inside the callback it `tempnam()`s a file, `ZipArchive::addFile()`s
each included file under its `getFilename()` (appending `_1`, `_2`, … on name collisions),
closes, `fpassthru`s the temp file, then unlinks it.

The `advanced_filesystem_archive.download` form (`ArchiveDownloadForm`) collects the FID
selection into the session; `advanced_filesystem_archive.download_stream`
(`ArchiveDownloadController::stream`, path `/adfs/archive/download`) reads and clears
`adfs_archive_download_fids` from the session and calls the service. That route requires the
download permission **and** `_csrf_token: 'true'`.

### Extract details

`extractZip()` opens the ZIP with `ZipArchive`, prepares `"$scheme://$subdir"`, and per entry:

- skips entries ending `/`, whose basename starts with `.`, or under `__MACOSX/`;
- skips entries whose declared uncompressed size exceeds `max_extract_file_size_mb` (512 MB);
- when `skipExisting`, skips if the destination basename already exists;
- writes `getFromIndex()` to a temp file, applies the MIME-prefix filter if given
  (`file.mime_type.guesser` on the basename vs each `rtrim($prefix,'*')`);
- computes the target as `basename($name)` passed through
  `preg_replace('/[^a-zA-Z0-9._\-]/','_', …)`, then `file_system->copy(tmp, finalUri,
  FileExists::Rename)`;
- creates a managed `File` (status 1, owned by the current user) and records lineage in
  `adfs_archive_extractions` (`source_fid`, `child_fid`, `path_in_zip`, `created`).

`ArchiveExtractForm` supplies the ZIP (a `managed_file` restricted to the `zip` extension,
uploaded to `temporary://`), the destination scheme (`public`/`private`) and subdirectory, the
skip-existing flag, and a newline-separated MIME filter.

## Routes & permissions

| Route | Path | Permission | CSRF |
|---|---|---|---|
| `.settings` | `/admin/config/media/advanced_filesystem/archive` | `administer advanced_filesystem_archive` | form |
| `.download` | `…/archive/download` | `download files as zip advanced_filesystem_archive` | form |
| `.download_stream` | `/adfs/archive/download` | `download files as zip advanced_filesystem_archive` | **`_csrf_token`** |
| `.extract` | `…/archive/extract` | `extract zip advanced_filesystem_archive` | form |
| `.browse` | `/admin/content/files/{file}/archive/browse` | `browse zip advanced_filesystem_archive` | GET (read-only) |
| `.log` | `…/archive/log` | `administer advanced_filesystem_archive` | GET |

`administer advanced_filesystem_archive` is `restrict access: true`. The download/extract/browse
permissions are separate grants so a role can be given one capability without the others.

## Config object `advanced_filesystem_archive.settings`

| Key | Type | Meaning |
|---|---|---|
| `max_files_per_download` | integer | Max files packed into one ZIP download (default 500). |
| `max_zip_size_mb` | integer | Max total ZIP size in MB (default 2048). |
| `max_extract_file_size_mb` | integer | Max size per extracted entry in MB (default 512). |
| `default_extract_scheme` | string | Default extraction scheme (`public`/`private`). |
| `default_extract_subdir` | string | Default extraction subdirectory. |

## DB tables (`hook_schema`)

- `adfs_archive_downloads` — `id`, `uid`, `fids_json`, `file_count`, `total_size`, `ip`,
  `created` (download audit log; indexed on `uid`, `created`).
- `adfs_archive_extractions` — `id`, `source_fid`, `child_fid`, `path_in_zip`, `created`
  (ZIP→managed-file lineage; indexed on `source_fid`, `child_fid`).

Both are created on install and the config object is deleted on uninstall.
