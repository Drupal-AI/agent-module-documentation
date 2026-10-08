<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ePub Generator: Viewer (epub_generator_viewer) — agent index

In-browser **epub.js** reader for generated/uploaded ePubs, plus a **response cache** for generated
ePubs. Package `Content`, core `^11.1`. Depends on `epub_generator` (Book assembler used optionally).
Needs the **epub.js** and **JSZip** JS libraries in `/libraries`. License GPL-2.0-or-later.
Version 1.0.x. Configure at `epub_generator_viewer.settings`.

- **Reader controller & formatter, cache subscriber & policy, hooks, settings** →
  [api/viewer.md](api/viewer.md)

## What it is (from source)

- **`EpubViewerController`** (`src/Controller/EpubViewerController.php`): builds the `epub_viewer`
  render array pointing epub.js at the base download routes (same-origin XHR, so download-route access
  applies to the fetch). Routes: node reader + generic entity reader + settings.
- **Formatter `epub_viewer`** (`src/Plugin/Field/FieldFormatter/EpubViewerFormatter.php`,
  `field_types = {file}`): inline reader for `.epub` files via `getEntitiesToView()` (field access
  applied); non-ePub files → `file_link`.
- **Cache**: `EpubResponseCacheSubscriber` (`src/EventSubscriber/`) + pure `EpubCachePolicy`
  (`src/EpubCachePolicy.php`) + dedicated bin `cache.epub_generator_viewer`.
- **Hooks** (`src/Hook/EpubGeneratorViewerHooks.php`): `hook_help`, `hook_theme` (`epub_viewer`),
  `hook_node_insert/update/delete` → invalidate `epub_generator_viewer:book:{bid}`.
- Template `templates/epub-viewer.html.twig`, JS `js/epub-viewer.js`
  (`Drupal.behaviors.epubGeneratorViewer`), libraries in `epub_generator_viewer.libraries.yml`.

## Routes (`epub_generator_viewer.routing.yml`)

- `epub_generator_viewer.node_view` — `/node/{node}/epub-view` → `viewNode`
  (perm `generate epub`, `_entity_access: node.view`, `_custom_access` bundle gate). Task **Read online**.
- `epub_generator_viewer.view` — `/epub/view/{entity_type}/{entity_id}` → `viewEntity`
  (perm `generate epub`; checks `$entity->access('view')` + bundle).
- `epub_generator_viewer.settings` — `/admin/config/content/epub-generator/viewer`
  (perm `administer epub generator`).

## Caching (from source)

- Subscriber wraps GET on `epub_generator.download`, `.node_download`, `epub_generator_markdown.download`
  (extendable via `hook_epub_generator_viewer_cached_routes_alter`). REQUEST priority **28** (after
  RouterListener 32 + access checkers): a hit replays stored bytes; RESPONSE captures a 200
  `BinaryFileResponse`'s bytes if within `cache_max_filesize`.
- `EpubCachePolicy`: cache id = hash of route + raw params + query + content-language + role variant;
  tags = entity tag + config tags + view-display tags (+ `book:{bid}` for books).
- Access is re-enforced on every request before a hit is served (caching happens after access checks),
  so cached bytes never widen access.

## Config (`epub_generator_viewer.settings`)

`cache_enabled`, `cache_max_age` (-1 permanent, 0 disabled), `cache_max_filesize` (bytes),
`cache_vary_by_roles`, `viewer_default_flow`, `viewer_page_height`, `viewer_show_download`
(schema in `config/schema/`, defaults in `config/install/`). `ViewerSettingsForm` also offers a
**Flush cached ePubs** button. `hook_requirements` warns when the JS libraries are missing.

## API (`epub_generator_viewer.api.php`)

- `hook_epub_generator_viewer_cached_routes_alter(&$routes)`
- `hook_epub_generator_viewer_cache_tags_alter(&$tags, $context)`
