<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bibliocommons — field formatters

All three formatters attach to plain `string` fields. The stored value is a BiblioCommons ID (a list id for lists, a bib/title id for single titles); it is `intval()`-cast and passed to `BibliocommonsService::getBookList($id, $limit, $type)`, which calls the wsdata `books` (type `lists`) or `book` (type `titles`) WSCall. Empty/failed responses render nothing. Output is built as render arrays with `#theme` and Twig auto-escaping (no raw markup).

## Service
`\Drupal\bibliocommons\BibliocommonsService` (service id `bibliocommons.books_service`), constructor args `@config.factory`, `@key.repository`, `@wsdata`, `@language_manager`.
`getBookList($id, $limit = 6, $type = 'lists')`: reads `bibliocommons.settings`, resolves the API key from the Key repository, sets `api_key`/`library`/`locale` request data, calls wsdata, and for `lists` slices `list.list_items` to `$limit` (0 = all).
Note: the static `create()` in this class passes mismatched args (`http_client` where `config.factory` is expected) and is dead — the service is built from `services.yml` `arguments`, so this bug is not reached.

## Formatters

### `bibliocommons_booklist` — `BookListFormatter`
Renders a list via `#theme bibliocommons_books`. Settings (`defaultSettings`): `limit` (0), `show_more_link` (1). `settingsForm` exposes both. Iterates `list.list_items`; for `url`-type items uses a bundled `icon-bk.png`, for `title`-type builds a Syndetics cover URL (`https://secure.syndetics.com/index.aspx?isbn=...&client=<client_id>&upc=...`) and validates it with `getimagesize()` (fixed Syndetics host), falling back to a per-format `assets/images/icon-<format>.png`.

### `bibliocommons_booklist_collection` — `BookListCollectionFormatter`
Uses `BibliocommonsFormatterTrait`, renders `#theme bibliocommons_books_collection`. Adds list description, list author name + profile link, and per-book toggles (author, subtitle, publication date, my-shelf link, hold link, description). Cover URLs via the trait's `getBookCoverUrl()`; prefers the BiblioCommons jacket-cover URL for French-language titles.

### `bibliocommons_book` — `BookFormatter`
Uses the trait, renders a single title via `#theme bibliocommons_books` with `type=titles`. Calls `getBookList($id, 1, 'titles')` and reads `title` from the response; honors trait toggles (image, large image, title, author, subtitle, publication date, my-shelf link, hold link, description).

## Shared trait — `BibliocommonsFormatterTrait`
- `defaultSettings()` / `settingsForm()`: the `show_*` checkboxes plus `use_large_cover_img`.
- `getSyndeticsCoverUrl()` / `getBookCoverUrl()`: build & validate the Syndetics cover image (host fixed to `secure.syndetics.com`), with medium/large and default-icon fallbacks via recursion.
- `getBookHoldLink($book_id, $library_id)` → `https://<library_id>.bibliocommons.com/holds/select_hold/<book_id>`.
- `getBookMyShelfLink($book_id, $library_id)` → `https://<library_id>.bibliocommons.com/collection/add/my/library?bib=<book_id>&bib_status=past`.

## Formatter config schema
`field.formatter.settings.bibliocommons_booklist` (`config/schema/bibliocommons.schema.yml`) defines only `limit` (number). The trait's `show_*` settings are not schema-declared.

## Templates / theming
`bibliocommons_theme()` (`bibliocommons.module`) registers `bibliocommons_books` (`templates/books-bibliocommons.html.twig`) and `bibliocommons_books_collection` (`templates/books-bibliocommons-collection.html.twig`). These delegate to ui_patterns `book` (`templates/patterns/book/`) and `book_details`. `hook_preprocess_pattern_book` seeds `region_attributes` for image/title/subtitle/author/date/links/description. CSS attached via library `bibliocommons/bibliocommons` (`assets/css/style.css`). Book descriptions are truncated to ~200 chars in the pattern template.
