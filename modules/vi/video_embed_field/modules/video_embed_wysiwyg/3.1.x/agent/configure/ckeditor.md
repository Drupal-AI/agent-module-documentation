# Enable in CKEditor 5

Two pieces must both be on for a text format (**Admin → Config → Content authoring → Text
formats and editors**):

1. **Filter** — enable *Video Embed WYSIWYG* (`@Filter` id `video_embed_wysiwyg`, a
   `TYPE_TRANSFORM_IRREVERSIBLE` filter). It converts the stored placeholder into a responsive
   video_embed_field iframe on output.
2. **Toolbar button** — drag the **Video embed** button (`videoEmbed`) into the CKEditor 5
   toolbar. The CKEditor 5 plugin is declared in `video_embed_wysiwyg.ckeditor5.yml`
   (`videoEmbed.VideoEmbed`), conditioned on the filter being enabled.

Authoring: the button opens the **Video Form** dialog
(route `video_embed_wysiwyg.video_dialog`, form `VideoEmbedDialog`) where the author pastes the
URL and chooses display settings. Access to the dialog is gated by
`_access_video_embed_wysiwyg_filter_in_use` — the format must have the filter enabled.

Installs an image style `video_embed_wysiwyg_preview` for thumbnails
(`config/install/image.style.video_embed_wysiwyg_preview.yml`).
