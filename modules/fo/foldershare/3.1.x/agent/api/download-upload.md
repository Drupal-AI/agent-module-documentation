<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File storage, upload, and the download endpoints

## Where files are stored

`Drupal\foldershare\ManageFileSystem` manages on-disk storage. All module files live under the
subdirectory `FILE_DIRECTORY = 'foldersharefiles'` inside the configured stream (`file_scheme`
setting — `public` by default, or `private`, or `s3`). `getFileUri(File $file, FolderShare $parent)`
builds the final URI from the **root's base path + the folder tree path + the file's real filename**:

- root-level file: `<scheme>://foldersharefiles/homes/<accountName>/<filename>`;
- file in a folder: `<scheme>://<rootBasePath><folderPath>/<filename>`.

So stored files keep their **human-readable name and original extension** (folders exist only in the
DB; the on-disk tree mirrors folder names). `prepareFileDirectories()` creates the directories, and —
for a **public** (non-private, non-s3) scheme — writes a deny-all `.htaccess` into `foldersharefiles/`
via `file.htaccess_writer->write($path, TRUE, TRUE)` (the `TRUE` = private mode = "Require all
denied"), **force-overwriting** it every time so an edited/opened htaccess is reset.

`hook_file_url_alter()` (`foldershare.module`) rewrites any file URL containing `foldersharefiles`
into a URL for the access-checked download route (`/foldershare/file/{id}?prefix=…`), so links Drupal
generates never point at the raw file — they route back through Drupal for an access check. Name
legality (`GetSetNameTrait::isNameLegal()`) rejects names containing `:`, `/`, `\`, so folder/file
names cannot introduce path traversal.

## Uploads

`Plugin/FolderShareCommand/UploadFiles` (`foldersharecommand_upload_files`, `specialHandling={upload}`,
parent access `create`) drives browser/drag-drop uploads. It calls
`FolderShare::addFilesFromFormUpload()` / `addFilesToRootFromFormUpload()` in
`src/Entity/FolderShareTraits/OperationAddFileTrait.php`, which deliberately **re-implements**
`file_save_upload()` and *skips* several core steps (its own comment lists them): it does **not** run
core's plugin validators, does **not** append `.txt` to executable uploads, and does **not** munge
inner extensions (`.tar.gz` → `._tar.gz`) — the code comments state the `.htaccess` in the file
directory is relied on instead. Upload flow: validate PHP upload errors → create a temporary `File`
entity → move it to the final `getFileUri()` path (marking it permanent) → `addFilesInternal()` wraps
it in a FolderShare entity with rename-on-collision.

Extension filtering is **optional** and governed by the `file_restrict_extensions` (default off) and
`file_allowed_extensions` settings, surfaced to the upload form as the `accept=` attribute and applied
via `ManageContentType::getFileSettingsForContentType()` +
`ManageHooks::callHookAllowedFilenameExtensionsAlter()`. Upload size is capped by
`file_upload_size_limit` (0 = PHP limit) via `LimitUtilities`.

## Download endpoints (both access-checked)

### `Controller\FileDownload::download(Request, File $file)` — route `entity.foldershare.file`

Streams a single core `File` entity managed by the module. Two branches by scheme:

- **Private** scheme → invokes `hook_file_download($uri)`; the module's implementation
  (`foldershare_file_download()`) maps the URI to its File, finds the wrapping FolderShare via
  `FolderShare::findFileWrapperId()`, and returns `-1` (access denied) unless
  `$wrapper->access('view') === TRUE`. All hooks returning `-1` → `AccessDeniedHttpException`.
- **Public** (or other) scheme → the controller itself finds the wrapper, rejects hidden/disabled
  items, and requires `$wrapper->access('view')` before streaming. Sets `Content-Disposition` to the
  human filename, no-cache headers, and returns a `BinaryFileResponse`.

### `Controller\FolderShareDownload::download(Request, string $encoded)` — route `entity.foldershare.download`

`{encoded}` is a comma-separated list of FolderShare entity ids. For **every** id it loads the entity
and enforces: exists, not system-hidden, not system-disabled, and `$entity->access('view') === TRUE`
(else `NotFound`/`Conflict`/`AccessDenied`). Then: a single file streams directly; a folder or a
multi-item selection is ZIPed (`FolderShare::createZipArchive()`, name `Download.zip`) and streamed.
S3 files stream via `ManageS3FileSystem::getS3FileObject()`. Post-op it calls
`hook_foldershare_post_operation_download` and logs activity (`ManageLog::activity`).

## Access-control summary for files

Every read path is gated on `->access('view')` of the specific FolderShare entity: the two download
controllers, the private-file hook, and (for mutations) the command validators. The one place raw
files are physically web-reachable is the **public file scheme**, where protection against a
webserver-direct request (bypassing Drupal) rests on the generated deny-all `.htaccess`; the module's
README therefore recommends the **private** file system. Configure the scheme and extension
restriction from the admin settings (config/settings.md).
