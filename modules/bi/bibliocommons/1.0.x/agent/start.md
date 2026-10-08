<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliocommons Book List (bibliocommons) — agent index

Renders BiblioCommons library book lists / single titles into Drupal entities via field formatters. Version 1.0.0-alpha4. Core `^9 || ^10 || ^11`. Package: Web services.

## Dependencies
- `drupal:key`, `drupal:field` (core), `wsdata:wsdata`, `ui_patterns:ui_patterns`.
- Remote: BiblioCommons v1 REST API + Syndetics cover images.

## What it provides
- **Service** `bibliocommons.books_service` (`\Drupal\bibliocommons\BibliocommonsService`) — `getBookList($id, $limit, $type)` calls wsdata `books`/`book` WSCall.
- **Field formatters** (bind to `string` fields):
  - `bibliocommons_booklist` — `BookListFormatter` (list view).
  - `bibliocommons_booklist_collection` — `BookListCollectionFormatter` (list + author/metadata).
  - `bibliocommons_book` — `BookFormatter` (single title).
  - Shared logic in `BibliocommonsFormatterTrait` (cover-URL resolution, hold / my-shelf links).
- **WSEncoder plugin** `ApiRequestEncoder` — appends `library`, `locale`, `api_key` query params to wsdata requests.
- **Route** `system.admin_config_services.bibliocommons` → `BibliocommonsForm` at `admin/config/services/bilbiocommons` (note misspelled path), permission `administer bibliocommons`; menu link `bibliocommons.settings_form`.
- **Config** `bibliocommons.settings` (`api_key` = Key id, `library_id`, `client_id`); wsdata config: `wsserver.bibliocommons_version_1` (endpoint `https://api.bibliocommons.com/v1/`), `wscall.books` (`lists/[ID]`, cache 3600s), `wscall.book` (`titles/[ID]`).
- **Theme hooks** `bibliocommons_books`, `bibliocommons_books_collection`; ui_patterns `book`, `book_details`; CSS library `bibliocommons/bibliocommons`.
- **Permission** `administer bibliocommons`.

## Solution docs
- [config/settings.md](config/settings.md) — install, settings form, config objects, Key setup, wsdata plumbing.
- [fields/formatters.md](fields/formatters.md) — the three formatters, their settings, service, encoder, templates.
