<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Universal File Utils (universal_file_utils) — agent index

**Developer event layer over `hook_file_download`/`hook_file_access`, plus file copy/remove helpers. Does nothing on its own.**

- **Version:** 3.0.x
- **Core:** ^10 || ^11 · **Package:** File
- **No routes, no permissions, no config.** Consumed programmatically.
- **Service:** `universal_file_utils.operations` (`UniversalFileOperations`): `HookFileDownload`, `HookFileAccess`, `fileCopy`, `fileRemove`
- **Events:** `UniversalFileDownloadEvent`, `UniversalFileAccessEvent` (extend `UniversalFileAccessSubscriberBase`)
- **Hooks:** `hook_file_download` (only `/system/files/` + `private://` URIs), `hook_file_access`, `hook_module_implements_alter`
- **Security:** No HTTP endpoints — file operations are PHP API methods reachable only from other code, so there is no direct path-traversal or arbitrary-file surface exposed by this module and no admin gate to speak of. `fileCopy()` writes into `private://{folderName}/{subFolderName}` and `fileRemove()` deletes by fid; a CALLING module that forwards unsanitized user input as those args owns the validation. Download handling is scoped to private/system files and uses exact URI matching.

See [api/operations.md](api/operations.md)