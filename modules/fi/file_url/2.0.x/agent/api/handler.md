<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API: FileUrlHandler, RemoteFile, dereference route

## `FileUrlHandler` (service `file_url.handler`, all methods static)

Class `Drupal\file_url\FileUrlHandler`. Converts between file objects and the URI strings the
field stores.

```php
// File object → public dereference URL. Throws \Exception if passed a RemoteFile.
$url = \Drupal\file_url\FileUrlHandler::fileToUrl($file);
// => "<dereference_host or $base_url>/file-dereference/<fid>"

// Stored value → the right file object.
$file = \Drupal\file_url\FileUrlHandler::urlToFile($value);
//  - numeric  -> File::load($value)
//  - matches /file-dereference/(\d+) -> File::load(that id)
//  - otherwise -> RemoteFile::load($value)  (a URI-backed pseudo entity)

// Is this reference a remote (external) file?
$is_remote = \Drupal\file_url\FileUrlHandler::isRemote($file);   // $file instanceof RemoteFile
```

`fileToUrl()` reads `file_url.settings.dereference_host`; when empty it falls back to the
global `$base_url`.

## `RemoteFile` entity

`Drupal\file_url\Entity\RemoteFile` extends `Drupal\file\Entity\File` with:
- `ContentEntityNullStorage` — **no database row is written**; it exists only in memory.
- `id()` returns the **file URI** (not a numeric id).
- `RemoteFile::load($uri)` returns `File::create(['uri' => $uri])` — i.e. it wraps any URI.
- `createFileUrl()` returns the URI unchanged (a remote file already is a URL).

This is what lets a remote URL travel through the same entity-reference field machinery as an
uploaded file.

## Dereference route / controller

`file_url.dereference` → path `/file-dereference/{file}`, `_access: 'TRUE'`. Controller
`FileUrlRedirect::redirectToFile(FileInterface $file)` returns a `RedirectResponse` to
`$file->createFileUrl()`. The `{file}` param is upcast from the numeric fid, so the public
link stays stable even if the underlying file's real URI changes.

## Field item list behavior (`FileUrlFieldItemList`)

Extends `EntityReferenceFieldItemList`. On `postSave`/`delete`/`deleteRevision` it maintains
`file.usage` records **only for local files** (`!isRemote()`); remote URLs are never added to
`{file_usage}`. `referencedEntities()` resolves each stored `target_id` through
`FileUrlHandler::urlToFile()`.

## Selection plugin

`file_url_default:file` (`FileUrlSelection`, extends core `DefaultSelection`, group
`file_url_default`) — its `validateReferenceableEntities()` accepts both dereference URLs and
remote URIs, so autocreate/validation works for either kind of reference.
