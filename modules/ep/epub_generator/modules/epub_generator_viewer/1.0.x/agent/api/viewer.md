<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reader, formatter & response cache (epub_generator_viewer)

## `EpubViewerController`

`src/Controller/EpubViewerController.php`. Args: `@epub_generator.generator`, `@entity_type.manager`.
Builds an `#theme => 'epub_viewer'` render array (`buildViewer()`) whose `#url` points epub.js at a
base download route; epub.js fetches the book **client-side via same-origin XHR**, so the download
route's own access checks run for the fetch (no new file-serving surface).

- `viewNode(NodeInterface $node)` → source `epub_generator.node_download` (delegates to the book
  assembler for book nodes). Route `epub_generator_viewer.node_view` = `/node/{node}/epub-view`,
  requirements `_permission: generate epub`, `_entity_access: node.view`, and `_custom_access`
  (`access()` = bundle enabled). Local task **Read online**.
- `viewEntity(string $entity_type, int $entity_id)` → source `epub_generator.download`. Route
  `epub_generator_viewer.view` = `/epub/view/{entity_type}/{entity_id}` (perm `generate epub`); the
  method itself checks entity-type validity, `$entity->access('view')`, and `isBundleEnabled()`,
  mirroring `EpubDownloadController`.
- Render array carries full cacheability (entity + config + generated-URL). Template
  `templates/epub-viewer.html.twig` prints values into data attributes (Twig auto-escaped, no `|raw`).

## `EpubViewerFormatter` (id `epub_viewer`)

`src/Plugin/Field/FieldFormatter/EpubViewerFormatter.php`, `FileFormatterBase`, `field_types = {file}`.
`viewElements()` iterates `getEntitiesToView()` (so entity/field access to referenced files is already
applied); ePub files (`isEpub()` = MIME `application/epub+zip` or `.epub` extension) render as
`#theme => 'epub_viewer'` with a relative same-origin URL (`file_url_generator->generateString()` —
private files resolve to `/system/files/…` where `hook_file_download` applies); other files render as
`file_link`. Settings: `height`, `flow` (`paginated`/`scrolled`), `show_download`.

## Response cache

`EpubResponseCacheSubscriber` (`src/EventSubscriber/EpubResponseCacheSubscriber.php`) + `EpubCachePolicy`
(`src/EpubCachePolicy.php`), bin `cache.epub_generator_viewer` (`epub_generator_viewer.services.yml`).

- Cached routes (const `CACHED_ROUTES`): `epub_generator.download`, `epub_generator.node_download`,
  `epub_generator_markdown.download`; extendable via `hook_epub_generator_viewer_cached_routes_alter`.
- **onRequest** (`KernelEvents::REQUEST`, priority **28** — after RouterListener 32 and the access
  checkers): GET + cached route + caching enabled → cache lookup; a hit replays stored body/headers
  (or a `304` when the request `ETag` matches `sha256(body)`) and short-circuits generation. Because
  route access has already run for the current user, a hit never widens access.
- **onResponse** (`KernelEvents::RESPONSE`, priority 0): on a miss, if the response is a 200
  `BinaryFileResponse` within `cache_max_filesize`, read the (not-yet-deleted) temp file's bytes,
  resolve the source (`resolveSource()`: `node`, or `{entity_type}/{entity_id}`, plus book id via the
  optional assembler), build tags (`EpubCachePolicy::buildCacheTags`), run
  `hook_epub_generator_viewer_cache_tags_alter`, and store with `buildExpire()`.
- `EpubCachePolicy`: `buildCacheId()` = `epub_bytes:` + `sha256(serialize([route, sorted raw params,
  sorted query, langcode, variant]))`; `buildRoleVariant()` = sorted role fingerprint (used when
  `cache_vary_by_roles`, else `shared`); `isCacheableSize()`; `buildExpire()` (`-1` permanent);
  `buildCacheTags()` = `entity:id` + `config:epub_generator.settings` +
  `config:epub_generator_viewer.settings` + the bundle's `epub`/`full` view-display config tags
  (+ `epub_generator_viewer:book:{bid}` for books, const `BOOK_TAG_PREFIX`).

## Invalidation & hooks

`EpubGeneratorViewerHooks` (`src/Hook/`): `hook_theme` (`epub_viewer`), and
`hook_node_insert/update/delete` → `invalidateBookOutline()` invalidates
`epub_generator_viewer:book:{bid}` for the outline the saved node belongs to (read via `BookInterface`),
because a book entry is cached under the root node and would otherwise survive child edits. Core
invalidates the node's own entity tag on save (flushes single-node ePubs).

## Settings form

`ViewerSettingsForm` (`src/Form/ViewerSettingsForm.php`, `ConfigFormBase`) at
`/admin/config/content/epub-generator/viewer` (perm `administer epub generator`). Reader group
(`viewer_default_flow`, `viewer_page_height`, `viewer_show_download`) + cache group (`cache_enabled`,
`cache_max_age`, `cache_max_filesize` shown/stored in MB↔bytes, `cache_vary_by_roles`) + a
**Flush cached ePubs** submit that calls `epubCache->deleteAll()`. `hook_requirements`
(`epub_generator_viewer.install`) warns when `libraries/epubjs/dist/epub.min.js` or
`libraries/jszip/dist/jszip.min.js` is missing. CSP note: strict-CSP sites need `frame-src blob:;
child-src blob:` for the sandboxed reader iframes.
