<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Explorer — routes, path containment, download, upload, delete

The explorer lets privileged editors walk the physical `public://` and `private://` roots, download
files/folders, upload into public directories, and delete unmanaged physical items. Every request
that names a path goes through `FileExplorerPathResolver`, which is the module's containment
boundary.

## Routes & permissions (`accessible_file_manager.routing.yml`)

| Route | Path | Controller/Form | Permission |
| --- | --- | --- | --- |
| `.explorer` | `/explorer` | `FileExplorerController::redirectToPrivate` | access files overview |
| `.explorer.private` / `.public` | `/explorer/private` \| `/public` | `::browse` (scheme default) | access files overview |
| `.explorer.download` | `/explorer/{scheme}/download` | `::download` | access files overview |
| `.explorer.zip` | `/explorer/{scheme}/zip` | `::downloadZip` | access files overview |
| `.explorer.public_upload` | `/explorer/public/upload` | `PublicExplorerUploadForm` | upload public explorer files |
| `.explorer.file_properties` | `/explorer/file/{file}/properties` | `FilePropertiesController::view` | access files overview |
| `.explorer.public_file_properties` | `/explorer/public/properties` | `::viewPhysical` | access files overview |
| `.explorer.delete_unmanaged` | `/explorer/{scheme}/delete` | `DeleteUnmanagedFileForm` | delete unmanaged physical files |
| `.explorer.delete_managed_upload` | `/explorer/upload/{file}/delete` | `DeleteExplorerManagedFileForm` | delete unmanaged physical files |
| `.file.rename` | `/{file}/rename` | `RenameFileForm` | rename managed files |

`{scheme}` is regex-constrained to `private|public`; `{file}` to `\d+` and upcast to `entity:file`.
The three restricted permissions (`upload public explorer files`, `delete unmanaged physical
files`, `rename managed files`) and `administer file access rules` carry `restrict access: true`.
All paths are under `/admin/content/accessible-file-manager/…`, so requests also traverse core's
admin-access checks.

## Path containment — `FileExplorerPathResolver::resolve()`

The single choke point for `?path=` values. In order it:

1. Restricts `$scheme` to the `['private','public']` allowlist.
2. `normalizeRelativePath()` rejects: NUL byte or backslash; a leading `/`; a Windows drive prefix
   (`^[A-Za-z]:`); any `://`; and splits on `/` rejecting **empty, `.` and `..` segments** — so no
   traversal, no absolute path, no scheme injection.
3. Resolves the wrapper root via `realpath()`, resolves the target URI's `realpath()`, requires it
   to exist, then `assertInsideRoot()` requires the resolved physical path to equal the root or
   start with `root + '/'` (case-insensitive only on Windows).
4. `assertNoSymbolicLinks()` walks each segment and rejects any that `is_link()`.

Because containment is checked against the **realpath** of both root and target, a symlink or `..`
cannot escape the stream root. `join()` (used when listing a directory) independently rejects
`''`, `.`, `..` and any name containing `/` or `\`.

## Browse — `FileExplorerController::browse()` + `FileExplorer::listDirectory()`

For the private scheme it first ensures the private root guard result (see access/access-rules.md)
and shows a recoverable error build if the root is unavailable. `listDirectory` iterates the
resolved physical dir with `\DirectoryIterator`, classifies each entry (directory/file/link/other),
guesses MIME, batch-loads matching `file_managed` rows by URI (`loadManagedFilesByUri`,
`accessCheck(FALSE)` — read-only listing) and marks module explorer-uploads via a single
`file_usage` query (module `accessible_file_manager`, type `explorer_upload`). Results are sorted
(dirs first, natural case-insensitive) and paged. The ARIA grid is rendered by the
`accessible_file_manager_explorer_grid` theme (`templates/…-file-explorer-grid.html.twig`);
filenames reach it as `#plain_text` / link `#title` render arrays, so they are auto-escaped.

## Download & ZIP

- `download()` resolves the path via `FileExplorer::getFile()` (same resolver, must be a real file)
  and streams a `BinaryFileResponse` with `X-Content-Type-Options: nosniff`, an ATTACHMENT
  `Content-Disposition` and an ASCII-sanitised fallback filename (`asciiFilename`). Response is
  private, max-age 0.
- `downloadZip()` → `FileExplorer::createZip()` builds a bounded temp archive with
  `addDirectoryToZip()`, which **skips symlinks**, enforces the clamped depth/file-count/byte
  limits (throwing `\LengthException` → HTTP 413), and deletes the temp file after send.

## Explorer upload — `PublicExplorerUploadForm`

Only public directories. `buildForm` resolves the target via the path resolver (400 on any
rejection), then builds a core `managed_file` element with `#upload_validators` =
`FileExtension` (allowlist from `explorer_upload_extensions`) + `FileSizeLimit`
(`explorer_upload_max_megabytes`). `submitForm` re-checks each saved file's URI starts with
`public://` before marking it permanent and adding a `file_usage` record
(`explorer_upload`). Extension validation is core's, so core's dangerous-extension munging applies;
the default allowlist contains no executable server types (no `php`/`phtml`).

## Delete unmanaged — `UnmanagedFileDeletion` (via `DeleteUnmanagedFileForm`)

`inspect()` refuses the root (`relative === ''`), refuses deleting **directories in the private
scheme** (`\DomainException`), and — critically — refuses anything that has a `file_managed` row
(exact URI, or `uri LIKE dir/%` for folders): only truly unmanaged physical items are deletable.
For folders it recursively walks entries and refuses if any symlink is present. `delete()` takes a
per-path lock, re-runs `inspect()` inside the lock, then `FileSystem::deleteRecursive`/`delete`, and
logs the actor UID, scheme, relative path, kind, file count and size. `DeleteExplorerManagedFileForm`
+ `ExplorerManagedFileDeletion` handle the inverse case — a managed file that the module itself
uploaded (`explorer_upload` usage). All deletions are confirmation forms (CSRF-protected, explicit
consent). `FilePropertiesController::viewPhysical` also routes its `?path=` through the resolver.
