<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a 'Video' Paragraph bundle that embeds an uploaded or remote (YouTube/Vimeo) video.

---

This sub-module installs the `video` Paragraph type with a media entity-reference field (`field_video`) targeting the `video` and `remote_video` media bundles. Editors add a video from the media library or through a supported remote video platform; it is rendered by the core entity-reference entity view, so the media entity (and its oEmbed/file handling and access) governs the actual output.

---

- Embed an uploaded video (media 'video' bundle) into content.
- Embed a remote video (YouTube/Vimeo/... via media 'remote_video').
- Pick the video from the media library.
- Auto-create a remote_video media item from a pasted URL (if enabled).
- Render via the media entity's own display and formatters.
- Combine with field_settings for animation/classes/id.
- Enable only where editors need video paragraphs.
