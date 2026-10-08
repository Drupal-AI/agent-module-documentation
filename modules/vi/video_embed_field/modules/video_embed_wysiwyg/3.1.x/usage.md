Submodule of Video Embed Field that adds a CKEditor 5 toolbar button and text-format filter for inserting third-party videos directly into rich-text content, without needing the Media suite.

---

`video_embed_wysiwyg` provides a CKEditor 5 plugin (`videoEmbed`) and a companion input filter (`@Filter` id `video_embed_wysiwyg`, an irreversible transform filter). Authors click the toolbar button, paste a provider URL into a dialog, and the video is embedded inline; the stored markup is a placeholder that the filter converts to a responsive video_embed_field iframe on output. A dialog form (`VideoEmbedDialog`) collects the URL and display settings, guarded by an access check (`_access_video_embed_wysiwyg_filter_in_use`) that only permits the dialog for text formats where the filter is enabled. It reuses the parent module's provider plugins and formatters, so any supported host works and a preview image style (`video_embed_wysiwyg_preview`) is installed. Enable the filter and add the toolbar button on the relevant text format. Requires ckeditor5, editor, field and video_embed_field.

---

- Let authors insert a YouTube video inline while writing an article.
- Embed Vimeo videos in a body field without the Media library.
- Add a "Video embed" button to a CKEditor 5 toolbar.
- Enable video embedding only on specific text formats.
- Paste a video URL into a dialog instead of writing embed HTML.
- Render inserted videos responsively via video_embed_field formatters.
- Provide a preview image style for embedded-video thumbnails.
- Restrict the embed dialog to formats where the filter is active.
- Give a lightweight WYSIWYG video workflow to editorial teams.
- Support any provider added to the parent video_embed_field module.
- Control autoplay/size of embedded videos through filter settings.
- Migrate a legacy inline-video workflow to CKEditor 5.
- Keep body content portable by storing a placeholder, not raw iframes.
- Combine with text-format permissions to gate who can embed videos.
- Embed a YouTube playlist within rich text.
