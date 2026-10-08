Adds the CKEditor 5 Media Embed plugin, letting editors embed external media (YouTube, Vimeo, tweets and other oEmbed providers) by pasting a URL into the rich text editor.

---

This submodule of CKEditor 5 Plugin Pack enables CKEditor 5's Media Embed feature in Drupal, adding a toolbar button (and paste-a-URL behavior) that turns a media URL into an embedded, previewable media object inside the content. It relies on oEmbed-style providers so common services such as YouTube, Vimeo and others render inline in the editor and on the published page. Enable the submodule and add the Media Embed button to a text format toolbar at Admin → Configuration → Content authoring → Text formats and editors; the allowed HTML for the format must permit the embed markup. It depends on the base `ckeditor5_plugin_pack` module and ships an icon and CSS. Use it when authors need to drop in videos and social content without dealing with iframes or the core Media Library.

---

- Embed a YouTube video by pasting its URL.
- Embed a Vimeo video inline in an article.
- Add a tweet or social post to body content.
- Let editors paste a media URL and see a live preview.
- Insert video without hand-writing iframe markup.
- Standardize how external media is embedded across content.
- Provide a simple toolbar button for media embedding.
- Embed provider content that supports oEmbed.
- Keep embedded media responsive on the front end.
- Add explainer videos to knowledge-base pages.
- Embed product demo videos on marketing pages.
- Let non-technical authors add rich media safely.
- Add the Media Embed button only to formats that allow it.
- Preview embedded media within the editor before publishing.
- Replace manual iframe pasting with a governed feature.
- Embed conference talk recordings in event pages.
- Add background/tutorial videos to documentation.
- Insert media in table cells or alongside text.
- Provide consistent media embedding UX site-wide.
- Reduce broken embeds by using structured oEmbed handling.
