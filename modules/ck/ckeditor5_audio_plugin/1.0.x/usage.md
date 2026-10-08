CKEditor Audio Plugin adds an "Insert Audio" CKEditor 5 toolbar button that either uploads an audio file or takes an audio URL and embeds it as an HTML5 `<audio controls>` player in rich-text content.

---

The module ships one CKEditor 5 plugin (`ckeditor5_audio_plugin_audio`, class `Drupal\ckeditor5_audio_plugin\Plugin\CKEditor5Plugin\Audio`) that you enable by dragging the "Insert Audio" button onto a text format's CKEditor 5 toolbar at Administration » Configuration » Content authoring » Text formats and editors. The plugin has two modes, chosen by a per-format "Enable audio uploads" checkbox: when uploads are enabled, clicking the button opens a native file picker (`accept="audio/*"`), POSTs the file to the module's `/ckeditor5-audio-upload` route, and inserts an `<audio>` element pointing at the returned public-files URL; when uploads are disabled, it shows a dialog prompting for an audio URL and inserts an `<audio>` referencing that URL. Per-format settings (status, upload directory under the public files scheme, and max file size) are stored in the editor config and validated by `config/schema/ckeditor5_audio_plugin.schema.yml`. The generated markup is a `<div class="audio-container">` wrapping `<audio class="audio-item" src="…" controls>`, so the text format's allowed-HTML must permit those elements/attributes (the plugin declares `<div>`, `<div class>`, `<audio>`, `<audio src class controls>`). The only dependency is core `ckeditor5`.

---

- Add an "Insert Audio" button to a CKEditor 5 toolbar so editors can embed audio without HTML.
- Let content authors upload an MP3/OGG/WAV directly from the editor and drop in a player.
- Embed audio hosted elsewhere by pasting a URL when upload mode is turned off.
- Provide a podcast episode player inside a body field on an article node.
- Attach pronunciation clips to glossary or language-learning entries.
- Add audio narration to accessibility-focused pages alongside text.
- Embed music samples or clips in a review or blog post.
- Insert recorded interview snippets into news content.
- Offer downloadable/streamable audio guides in help or documentation pages.
- Add sound effects or ambience samples to a landing page's rich text.
- Configure a dedicated upload subdirectory (e.g. `inline-audio`) per text format for editor audio.
- Cap editor audio upload size per text format via the "Maximum file size" setting.
- Restrict audio embedding to a trusted "Full HTML"-style format while keeping basic formats clean.
- Give reviewers a quick way to insert audio evidence into moderated content.
- Standardize on an HTML5 `<audio controls>` player rendered natively by the browser (no extra JS player).
- Let editors switch between uploaded and linked audio by toggling the format's upload checkbox.
- Embed audio in course/lesson content built with the CKEditor 5 rich-text editor.
- Add audio testimonials to marketing pages authored by non-technical staff.
- Provide multilingual audio versions of a page by inserting several players in one field.
- Include audio clips in email-preview or newsletter body content edited in CKEditor 5.
