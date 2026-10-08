<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — how popups reach the page

## Attachment flow (`simple_popup_blocks.module`)
- `hook_page_attachments(&$attachments)` runs on every request. It **skips admin routes**
  (`router.admin_context`).
- It calls `\Drupal::service("config.factory")->listAll("simple_popup_blocks.popup_")` to
  find every popup config object, reads each with `->get()`, and keeps only those with
  `status == 1`.
- For block popups (`type == 0`) the `identifier` is rewritten to `block-<identifier>` with
  `_` replaced by `-`. `visit_counts` is `unserialize()`d and re-joined as a comma string.
  Every scalar value is `Html::escape()`d.
- The surviving popup settings arrays are attached as
  `drupalSettings.simple_popup_blocks.settings` (an array of popups), and the library
  `simple_popup_blocks/simple_popup_blocks` is attached. The config objects' cache tags are
  merged into `#cache['tags']`, so editing a popup's config invalidates the page cache.

So: **enabled popup config → drupalSettings → `js/simple_popup_blocks.js`** does the actual
DOM work (cloning the target element into a modal, wiring triggers, cookies). There is no
render/theme hook and no block plugin of the module's own.

## Library (`simple_popup_blocks.libraries.yml`)
`simple_popup_blocks/simple_popup_blocks`: `css/simple_popup_blocks.css` +
`js/simple_popup_blocks.js`, depending on `core/jquery`, `core/once`, `core/drupal`.

## Routes / controller / forms
- Routes (`.routing.yml`): `simple_popup_blocks.add`, `.manage`, `.edit/{uid}`, `.delete/{uid}` —
  all require the `administer simple_popup_blocks` permission.
- `SimplePopupBlocksController::manage()` builds the admin listing table by iterating the
  `simple_popup_blocks*` config objects (skipping ones with no `uid`).
- `SimplePopupBlocksAddForm` / `EditForm` / `DeleteForm` (all `ConfigFormBase`) write the
  `simple_popup_blocks.popup_<uid>` config objects. There is no service to call — to create a
  popup programmatically, write the config object directly (see `configure/popups.md`).

## Legacy DB table (dead code — do not use)
`simple_popup_blocks.install` defines a `simple_popup_blocks` database table and
`src/SimplePopupBlocksStorage.php` has insert/update/load/delete helpers for it. These are
**leftovers from the 1.x/2.x releases**; the current 3.x add/edit/delete flow and the page
attachment reader both use **config objects**, not this table. Ignore the table when reading
or creating popups.

## No Drush / no plugins / no invited hooks
The module adds no Drush commands, defines no plugin manager or plugin type, and ships no
`*.api.php` (no hooks for you to implement). Its only permission is `administer simple_popup_blocks`.
