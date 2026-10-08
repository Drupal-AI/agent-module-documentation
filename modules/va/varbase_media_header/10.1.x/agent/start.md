<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Media Header (varbase_media_header) — agent index

Adds a full-width **media "hero" header** (background image / local / YouTube / Vimeo video with the
page title + breadcrumbs overlaid) that site builders switch on **per node bundle and per taxonomy
vocabulary**. Config/feature module from the **Varbase** distribution (Vardot). Package `Varbase`.
Version **10.1.2** (dir `10.1.x`). License GPL-2.0-or-later. Core `~11.4.0`.

- **Dependencies:** `varbase_media:varbase_media`, `varbase_components:varbase_components`
  (varbase_components supplies the `varbase_components:media-header` Twig component the block includes).
- **Settings form + per-bundle activation + the imported fields** →
  [config/settings.md](config/settings.md)
- **The block, the render/preprocess path, and the video JS/templates** →
  [plugins/block.md](plugins/block.md)

## What it provides (from source)

- **1 block plugin:** `VarbaseMediaHeaderBlock` (id `varbase_media_header_block`), in
  `src/Plugin/Block/VarbaseMediaHeaderBlock.php`. Node/term context definitions (both optional).
- **1 settings form:** `VarbaseMediaHeaderSettingsForm` (extends `ConfigFormBase`), route
  `varbase_media_header.settings` at `/admin/config/varbase/varbase-media-header`, requirement
  `_permission: 'administer varbase media header'`. Menu link under `varbase_core.settings_index`.
- **1 permission:** `administer varbase media header` (`varbase_media_header.permissions.yml`).
- **Config object:** `varbase_media_header.settings` (schema in `config/schema/`): keys
  `varbase_media_header_settings` (sequence of enabled entity_type → bundle) and `hide_breadcrumbs` (bool).
- **Hooks** (`src/Hook/VarbaseMediaHeaderHooks.php`, OOP `#[Hook]` attributes): `form_node_form_alter`,
  `form_taxonomy_term_form_alter` (group `field_page_header_style` + `field_media` into a "Media Header"
  details element), `preprocess_block` (blank theme page-title/breadcrumb blocks on media-header pages),
  `theme` (declares `varbase_media_header_block` + `media_oembed_iframe__remote_video__varbase_media_header`),
  and `preprocess_media_oembed_iframe__remote_video__varbase_media_header`.
- **Fields** (imported on activation, not always-on): `field_page_header_style` (`list_string`:
  `standard` / `media_header`) and `field_media` (entity_reference → `media`). Templates in
  `src/assets/config_templates/{node,taxonomy_term}/`; storage in `config/managed/`.
- **Libraries:** `local_video_header`, `youtube_video_header`, `vimeo_video_header` (autoplay/loop JS).
- **Media view mode** `media.varbase_media_header` + optional media view displays in `config/optional/`.
- **Install:** `hook_install()` runs the bundled recipe `recipes/default` (grants the permission to
  `user.role.site_admin`). No update hooks run any unsafe operation (see includes/updates/).
- No routes beyond the settings form, no services beyond the autowired hooks class, no Drush.

## Security

Reviewed adversarially — no finding. Settings route is permission-gated; the block only renders
site media through a core view builder; the `media|raw` in the oEmbed iframe template and the
`provider` query param are the standard core media-oembed pattern (same-origin, trusted providers).
Nothing to flag in public docs.
