<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The purge form — `AssetPurgeManager`

File: `src/Form/AssetPurgeManager.php` (extends `Drupal\Core\Form\FormBase`).
Form id: `asset_purge_manager_page`. Route:
`asset_purge_manager.asset_purge_manager_form` → `/admin/content/asset_purge_manager`
(permission `access Asset Purge Manager page`; task/menu link under `system.admin_content`).

## Install / enable

```
composer require drupal/asset_purge_manager   # no non-core deps
drush en asset_purge_manager -y
```

Then grant permissions at `/admin/people/permissions`:
- `access Asset Purge Manager page` to see the list;
- `Asset Purge Manager` to actually delete (restricted — trusted roles only).

## Services injected (`create()`)

`current_user`, `entity_type.manager`, `file_system`, `messenger`, `pager.manager`,
`pager.parameters`, `stream_wrapper_manager`; `string_translation` is set afterwards via
`setStringTranslation()`. No custom services are defined by the module.

## How the list is built (`buildForm`)

1. A `tableselect` element `files` (`#multiple => TRUE`, `#js_select => FALSE`) with a single
   `File Name` column.
2. The submit button `Delete selected files` is added **only** when
   `currentUser->hasPermission('Asset Purge Manager')`; otherwise the form shows
   "Additional permissions required".
3. `initPaths()` (called from the constructor) resolves:
   - `physicalBasePathStr` = `file_system->realpath(default_scheme . '://')` (rtrimmed);
   - `webBasePathStr` = the stream wrapper's `getExternalUrl()`.
   These + their lengths drive `physicalToShortWebAddress()` (path relative to `public://`) and
   `pyhsicalToWebAddress()` (full public URL).
4. `dirContents($public_dir, $showHiddenFiles = TRUE)` recurses the whole public tree with
   `scandir()` and returns `['path' => <realpath>, 'have_link' => bool]` entries. `have_link`
   is `FALSE` when the directory contains an `.htaccess` with `Require all denied`
   (detected by the static `containsString()` line scan) — those files list without a link.
5. `array_filter($files_arr, [$this, 'writable'])` keeps only `is_writable()` files.
6. Pagination: `num_per_page` comes from `asset_purge_manager.settings`; `pager.parameters
   ->findPage()` + `pager.manager->createPager(count, num_per_page)`; the page slice
   (`array_slice`) becomes the `tableselect` `#options`, **keyed by each file's absolute
   realpath**. Linked rows render `<a href="{public URL}">{path relative to public://}</a>`,
   unlinked rows render the short path as plain text.

## How deletion works (`submitForm`)

- Re-checks `currentUser->hasPermission('Asset Purge Manager')` first — the authoritative gate
  (the route only requires page access, so the delete right is enforced here, not by routing).
- For each truthy selected value `$val` (an absolute realpath option key):
  - `web_short_address = physicalToShortWebAddress($val)` (path relative to `public://`).
  - `file_system->delete($val)` removes the file from disk.
  - `managedFile(default_scheme . ':/' . $web_short_address)` runs an entity query on the `file`
    storage (`->accessCheck()->condition('uri', $uri)`) to see if the reconstructed
    `public://…` URI is tracked in `file_managed`.
    - If managed → `touch($val)` re-creates a zero-byte file; message "Blanked: …".
    - If not managed → the file stays deleted; message "Deleted: …".

### Why the selectable keys are safe from arbitrary-path deletion

The submitted `files` values are `tableselect` option keys. Drupal core's
`FormValidator::performRequiredValidation()` validates that every submitted key for a
`tableselect`/`checkboxes` element exists in `#options`, raising "The submitted value … is not
allowed" otherwise. So a submit can only delete files that were actually listed on the current
page (writable files under `public://`); a forged path not in the rendered options is rejected
before `submitForm()` runs. Deletion is additionally CSRF-protected by the standard Drupal form
token and gated by the `Asset Purge Manager` permission.

## Operational notes

- **Destructive and manual.** There is no "unused/orphaned" detection — every writable public
  file is listed. Deleting a still-needed asset breaks content; back up first and keep the delete
  permission on trusted roles only.
- "Blanking" leaves the `file_managed` row and the on-disk path present but zero bytes, so
  references resolve to an empty file rather than a missing one.
- Only files under the **default (public) scheme** are shown; private/other schemes are not
  scanned. Non-writable files are filtered out and cannot be deleted here.
- Static helpers `dirContents()`, `containsString()` operate purely on server paths (no request
  input); `writable()` and the path translators are protected instance methods.
