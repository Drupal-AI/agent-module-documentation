<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Block Types (EBT): Video provides an `ebt_video` block content type that embeds a single video — either a remote video (YouTube/Vimeo) or a locally uploaded Media video — with EBT design options and, for remote videos, a GLightbox popup.

---

Part of the Extra Block Types family (built on `ebt_core`), this module installs a reusable custom block content type with a Media entity-reference field (`field_ebt_video`, limited to the core `video` and `remote_video` media bundles), an optional WYSIWYG body, and an `ebt_settings` field carrying the EBT design options. Installation is entirely config-driven: `config/install/*` ships the block type, its fields and storage, the form display (a two-tab "Content"/"Settings" layout via `field_group`, with the media reference edited through `media_library_widget`), the default view display, a dedicated `ebt_video` media view mode, and view displays for both media bundles. Remote videos render through the core oEmbed field (`field_media_oembed_video`) with the `glightbox_media_remote_video` formatter (thumbnail + play-button overlay opening a GLightbox popup); local videos render through the core `file_video` formatter on `field_media_video_file`. The module's only PHP is a field-widget subclass (`ebt_settings_video`) delegating to `ebt_core`, and a `hook_requirements` that blocks install until a `remote_video` media type exists. It ships component CSS and a play-button SVG, but no routes, permissions, services, or Drush commands.

Typical setup is to enable the module (which auto-creates the block type, fields, and media view mode), add an EBT Video block via Layout Builder or Block layout, reference a remote or local video Media entity, and adjust the design options in the block's Settings tab.

---
- Enable the module to auto-create the `ebt_video` block type and fields.
- Add an EBT Video block to a page via Layout Builder.
- Place a video block in a region through Block layout.
- Embed a YouTube or Vimeo remote video in a block.
- Embed a locally uploaded video file in a block.
- Open a remote video in a GLightbox popup instead of inline.
- Show a play-button overlay before the video plays.
- Add a WYSIWYG caption/body alongside the video.
- Apply EBT design options (margin, padding, border) to the block.
- Set a background color or background image style on the block.
- Configure edge-to-edge or max-width container for the block.
- Use the dedicated `ebt_video` media view mode for display.
- Reuse the same video block across multiple pages.
- Select an existing Media library video without re-uploading.
- Build a hero-style section with a video and a play button.
- Use responsive breakpoints inherited from EBT Core.
- Combine remote and local videos across different blocks.
- Use it as a standalone block type without other EBT modules.
- Combine with Layout Builder Modal for faster block placement.
- Author video blocks in a two-tab Content/Settings editing form.
