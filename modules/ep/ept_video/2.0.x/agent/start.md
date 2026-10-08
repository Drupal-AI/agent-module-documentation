<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Video (ept_video) — agent index

Ships a single **`ept_video`** Paragraphs bundle: a page-section that references a core **Media
Remote Video** (oEmbed) entity and renders it, by default, as a thumbnail opening in a **GLightbox**
overlay player, plus an optional title and body text. Per-paragraph presentation (margin/padding/
border, background color/image/video, edge-to-edge, container width, ID anchor, additional classes,
title tag) comes from the shared EPT design options in `ept_core` (`field_ept_settings`). All
behavior is **config + one template + a widget subclass**; the module has **no PHP hooks, no admin
settings form, no permissions, no Drush, no config schema, no plugin types** of its own — the
rendering hooks and the `ept_settings` field type all live in `ept_core`.

Dependencies: `drupal:media`, `ept_core:ept_core`, `glightbox:glightbox`,
`glightbox_media_video:glightbox_media_video`, `paragraphs:paragraphs`. Core: `^10.1 || ^11 || ^12`.
Version **2.0.0**.

Install note: `hook_requirements()` (`ept_video.install`, install phase only) blocks install until a
**`remote_video`** media type exists (`MediaType` id `remote_video`, source `oembed:video`); create
one at `/admin/structure/media` first. On this site it already exists.

Configure route: **none** (shared defaults live at `ept_core.settings`,
`/admin/config/content/ept-core`).

- **The paragraph type + its 4 fields, form/view displays, media view mode** → [paragraphs/paragraph-type.md](paragraphs/paragraph-type.md)
- **The `ept_settings_video` settings widget (inherited EPT design options)** → [paragraphs/settings-widget.md](paragraphs/settings-widget.md)
- **Rendering: template, GLightbox/oEmbed player, ept_core preprocess & `{{ styles|raw }}`, libraries** → [theme/rendering.md](theme/rendering.md)

Key facts:
- Paragraph bundle: `ept_video` (`paragraphs.paragraphs_type.ept_video`, label "EPT Video").
- Fields (entity type `paragraph`, bundle `ept_video`):
  - `field_ept_video` — `entity_reference` → `media`, **required**, cardinality 1,
    `target_bundles: {remote_video: remote_video}` only. Storage ships in this module
    (`field.storage.paragraph.field_ept_video`).
  - `field_ept_title` — `text_long` (shared storage from ept_core).
  - `field_ept_text` — `text_long` (shared storage from ept_core).
  - `field_ept_settings` — `ept_settings` (field type + storage from ept_core).
- Settings widget plugin: `ept_settings_video` →
  `Drupal\ept_video\Plugin\Field\FieldWidget\EptSettingsVideoWidget` (extends ept_core
  `EptSettingsDefaultWidget`; adds nothing but the massageFormValues default — inherits the full EPT
  Design options panel).
- No `src/` beyond that one widget. No `.module` file. No `js/`.
- Template: `templates/paragraph--ept-video--default.html.twig` (registered as theme hook
  `paragraph__ept_video__default` by **ept_core**'s `hook_theme_registry_alter`, not by this module).
- Media view mode `media.ept_video` (label "EPT Video") + view display
  `media.remote_video.ept_video` renders `field_media_oembed_video` with the
  **`glightbox_media_remote_video`** formatter (thumbnail display, lightbox popup).
- Form display: field_group horizontal **Tabs** (Content / Settings); `field_ept_video` uses
  `media_library_widget`; `field_ept_settings` uses `ept_settings_video`.
- Library: `ept_video/ept_video` (`css/ept-video.css` only — the play-button overlay icon).
- Video embedding is via **core Media oEmbed** (`oembed:video` source, provider-allowlisted). This
  module never takes a raw URL and prints it into an iframe/`<video src>` itself.
