<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bookmark Field (bookmark_field) — agent index

Gives an entity a **stable text identifier** (a "bookmark") and resolves that key to the entity:
a redirect route, a block, a Twig function, two Views argument defaults, and a token. It is a
naming/reference layer, **not** a favorites/flag feature — there is no per-user bookmark list and
no AJAX toggle. Package `Other`. Depends on core **`field`** and **`block`**. Core requirement
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0. No settings page (`configure` = null).

- **The `bookmark` field type, its widget/formatter, storage settings, and the edit-permission caveat** →
  [fields/bookmark-field.md](fields/bookmark-field.md)
- **The service, redirect route/controller, block, Twig function, Views argument defaults, token** →
  [api/reference-by-bookmark.md](api/reference-by-bookmark.md)

## What it actually is (from source)

- **Field type** `bookmark` (`src/Plugin/Field/FieldType/BookmarkFieldType.php`): a single `value`
  varchar column, storage settings `max_length` (255), `is_ascii` (FALSE), `case_sensitive`
  (FALSE); a `Length` max constraint. Default widget & formatter id `bookmark_widget_type`.
- **Widget** `bookmark_widget_type` (`.../FieldWidget/BookmarkWidgetType.php`): one textfield
  (`size`, `placeholder` settings). Its `#access` is gated on the permission
  `bookmark_field edit bookmark`. **Caveat:** that permission is declared via the removed
  `hook_permission()` in `bookmark_field.module`, so on D10/D11 it is never registered — see the
  fields doc.
- **Formatter** `bookmark_widget_type` (`.../FieldFormatter/BookmarkFormatter.php`): prints the
  value with `nl2br(Html::escape(...))` (safe).
- **Service** `bookmark_service` = `BookmarkService` (implements `BookmarkServiceInterface`):
  `loadEntityByBookmark($entity_type, $bookmark, $field_name='field_bookmark')` and
  `renderEntityByBookmark(... , $view_mode='full')`. Load uses `loadByProperties()` (entity query;
  no raw SQL). Render checks `EntityPublishedInterface::isPublished()` **and** `access('view')`.
- **Redirect route** `bookmark_field.redirect` → `/bookmark/redirect/{entity_type}/{bookmark}`,
  `_permission: access content`, `BookmarkController::forward()` → 302 to the entity's
  `entity.<type>.canonical` route (query params preserved) or 404.
- **Block** `bookmark_block` (`src/Plugin/Block/BookmarkBlock.php`): renders one entity via the
  service; config `entity_type`/`field_name`/`view_mode`/`bookmark`.
- **Twig** function `bookmarkFieldRender(entity_type, bookmark, field_name='field_bookmark',
  view_mode='full')` (`src/TwigExtension/BookmarkExtension.php`, service
  `bookmark_service.twig.render`).
- **Views** argument defaults `bookmark_field` (`.../views/argument_default/Bookmark.php`) and
  `bookmark_field_from_url` (`BookmarkFromUrl.php`, reads a URL path component / alias).
- **Token** group `bookmark`, token `[bookmark:<name>]` → a node's URL
  (`bookmark_field_tokens()`), node-only.
- **Config schema** in `config/schema/bookmark_field.schema.yml` (block, widget, field-storage
  settings). No `config/install`, no Drush.

## Caveats

- `bookmark_field_permission()` uses the D7-era `hook_permission()` hook, **removed in Drupal 8+**.
  There is no `bookmark_field.permissions.yml`, so the `bookmark_field edit bookmark` permission is
  not registered — `hasPermission()` on it returns FALSE for everyone except user 1, so the widget
  field is effectively editable only by user 1 (fails closed). Details in the fields doc.
- `loadEntityByBookmark()` returns the **first** match (`current()`); bookmark uniqueness is not
  enforced by the module.
