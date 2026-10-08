<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UniversalFileOperations API + events

Service: `universal_file_utils.operations` (`Drupal\universal_file_utils\UniversalFileOperations`).

## Event hooks (wired by the module)
- `HookFileDownload(string $uri)` — invoked from `hook_file_download`, but the `.module` first filters to URIs containing `/system/files/` or `private://`. Loads the file by exact case-sensitive URI, dispatches `UniversalFileDownloadEvent`, returns its headers (array) or `-1` to deny. Logs an error if no exact match.
- `HookFileAccess($file, $operation, AccountInterface $account)` — dispatches `UniversalFileAccessEvent`, returns its `AccessResultInterface`.

Client modules subscribe to those events (extend `UniversalFileAccessSubscriberBase`) and implement the decision methods; call `$event->denyDownload()` to block.

## File helpers
- `fileCopy(int $fid, string $folderName, ?string $subFolderName = NULL): ?FileInterface`
  - Loads file `$fid`; destination `private://{folderName}/{subFolderName}` (subfolder defaults to `Y-m`). Creates the directory, `file_copy()`s, marks permanent, saves.
  - **Caller responsibility:** validate `$folderName`/`$subFolderName` if derived from user input — they are interpolated into the destination path.
- `fileRemove(int $fid): bool` — loads and `->delete()`s the file (also removes file-usage rows). Returns TRUE if deleted or already absent.

## Notes
- No routes/permissions: gate any exposure in the calling module.
- Download handling is limited to private/system files; public files return `[]` (unhandled) from the `.module`.
