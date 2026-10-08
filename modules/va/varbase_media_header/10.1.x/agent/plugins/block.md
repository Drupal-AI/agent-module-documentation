<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Header block, render path, hooks & video JS

`src/Plugin/Block/VarbaseMediaHeaderBlock.php` — `VarbaseMediaHeaderBlock extends BlockBase`
(id `varbase_media_header_block`, category "Varbase Media Header"). Two optional context
definitions: `node` (`entity:node`) and `taxonomy_term` (`entity:taxonomy_term`).

## Placement & block form

Place it in a region via Block layout (`/admin/structure/block`). `blockForm()`:

- For every entity type enabled in `varbase_media_header.settings:varbase_media_header_settings`,
  renders a `select` per enabled bundle whose options are that bundle's **media** entity-reference
  fields (`field_definition->getType() == 'entity_reference'` and target_type `media`), plus a
  `-None-` option. Stored as block config `vmh_{entity_type}[{bundle}]` = the chosen field name.
- A `vmh_media_view_mode` select (options from `entityDisplayRepository->getViewModeOptions('media')`)
  — the media view mode used to render the background.

`blockSubmit()` persists `vmh_{entity_type}` and `vmh_media_view_mode` into block configuration.

## build()

1. Resolve the current entity from the route: `entity.node.canonical`,
   `entity.node.latest_version` (loads the latest revision), or `entity.node.preview` (full view
   mode → `node_preview`); otherwise a `taxonomy_term` route parameter.
2. `$process` is TRUE only when the block config maps that bundle to a real field
   (`vmh_{type}[{bundle}] != '_none_'`).
3. Render only when `$process` AND the entity has `field_page_header_style`, it is non-empty, and its
   value **is not `standard`** (i.e. `media_header`).
4. Builds:
   - `$vmh_page_title` from `titleResolver->getTitle()`.
   - `$vmh_page_breadcrumbs` from a freshly created `system_breadcrumb_block` — but only if its
     `access()` allows the current user AND `hide_breadcrumbs` is FALSE.
   - `$vmh_background_media`: loads the referenced `media` entity (current content language via
     `languageManager` + `getTranslation` when a translation exists), renders it with
     `entityTypeManager->getViewBuilder('media')->view($media, $config['vmh_media_view_mode'])` and
     `renderer->render()`; captures `$vmh_media_type` (media bundle) and, for remote video,
     `$provider` from `field_provider`.
5. Returns a render array `#theme => 'varbase_media_header_block'` with `#vmh_page_title`,
   `#vmh_page_breadcrumbs`, `#vmh_background_media`, `#vmh_media_type`, `#provider`, and cache
   metadata. Returns `[]` (nothing) when the style is standard/empty.

`getCacheTags()` adds `node:{id}` / `taxonomy_term:{tid}`; `getCacheContexts()` adds
`url.path`, `url.query_args`, `route`.

## Hooks — `src/Hook/VarbaseMediaHeaderHooks.php`

- `#[Hook('form_node_form_alter')]` / `form_taxonomy_term_form_alter` — for enabled bundles, wrap
  `field_page_header_style` + `field_media` in a collapsible **"Media Header"** `details` group
  (`nodeGroupForm()` / `taxonomyTermGroupForm()`).
- `#[Hook('preprocess_block')]` — on a media-header page (active default theme only), blank the
  content of the core `page_title_block` and, when `hide_breadcrumbs` is FALSE, the
  `system_breadcrumb_block`, so they are not duplicated outside the hero. Adds route/url/theme cache
  contexts.
- `#[Hook('theme')]` — declares `varbase_media_header_block` (variables: page title, breadcrumbs,
  background media, media type, provider) and `media_oembed_iframe__remote_video__varbase_media_header`.
- `#[Hook('preprocess_media_oembed_iframe__remote_video__varbase_media_header')]` — passes the
  request `type`/`provider`/`view_mode` query args, `base_path()`, and the module path to the iframe
  template.

## Templates & video libraries

- `templates/varbase-media-header-block.html.twig` — attaches the local/YouTube/Vimeo library
  based on `vmh_media_type`/`provider`, then `include`s the `varbase_components:media-header` Twig
  component (from the `varbase_components` dependency) with the media, breadcrumbs and title.
- `templates/media-oembed-iframe--remote-video--varbase-media-header.html.twig` — a standard core
  media-oEmbed iframe wrapper (same `{{ media|raw }}` pattern core uses) that loads
  `js/oembed-frame.media-header.{provider}.js` for remote-video autoplay control.
- Libraries (`.libraries.yml`): `local_video_header` (`js/video.media-header.local.js` — autoplay +
  loop on load), `youtube_video_header` / `vimeo_video_header` (depend on
  `varbase_media/youtube_player` / `vimeo_player`; JS drives the player API to autoplay muted + loop).
