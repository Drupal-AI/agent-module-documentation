Enables CKEditor 5's markdown-gfm plugin so a chosen text format's editor stores GitHub-Flavored Markdown instead of HTML.

---

CKEditor5 Markdown editor is a thin integration around CKEditor 5's official `@ckeditor/ckeditor5-markdown-gfm` data processor. Enabling the module adds a per-text-format "Markdown output" checkbox to the CKEditor 5 configuration UI (`admin/config/content/formats`); when checked, the editor's data pipeline is switched so the value saved to the field is Markdown source rather than HTML. The conversion between the WYSIWYG view and Markdown happens entirely in the browser (in the CKEditor JS layer) — the module performs no server-side Markdown-to-HTML rendering of its own. Because stored values are now Markdown, you normally pair it with a rendering step: the `markdown_easy` text filter to convert Markdown to HTML on output, or the `markdown_field_formatter` module on the display. The module ships two Drush commands (`ckeditor5_markdown_editor:install` / `:update`) that download the markdown-gfm plugin build from the npm registry into `/libraries/ckeditor5/plugins/markdown-gfm`, plus `hook_requirements()` and `hook_ckeditor5_plugin_info_alter()` that detect whether the plugin files are present and version-matched and warn/hide the plugin if not.

---

- Let editors author content in Markdown while still using the familiar CKEditor 5 WYSIWYG toolbar.
- Store lightweight Markdown source in body/text fields instead of verbose HTML.
- Produce content that is portable to other Markdown-based systems (docs sites, static generators, chat tools).
- Give developer-oriented content teams a Markdown authoring workflow inside Drupal.
- Enable Markdown output on one specific text format while leaving other formats emitting HTML.
- Combine with `markdown_easy` to convert stored Markdown to HTML at render time via a text filter.
- Combine with `markdown_field_formatter` to render stored Markdown as HTML in a field display mode.
- Keep field values diff-friendly and small in configuration/content exports.
- Author GitHub-Flavored Markdown features (fenced code blocks, tables, task lists) supported by the gfm data processor.
- Install the required CKEditor markdown-gfm plugin assets with a single `drush ckeditor5_markdown_editor:install`.
- Update the plugin build to match a newer core CKEditor version with `drush ckeditor5_markdown_editor:update`.
- Surface a status-report warning when the markdown-gfm plugin files are missing or version-mismatched.
- Pin the CKEditor/plugins version used for asset detection via the `ckeditor5_markdown_editor.settings` config.
- Migrate an existing HTML-authored format toward Markdown authoring for new edits.
- Standardize technical documentation content types on Markdown storage.
- Feed clean Markdown into downstream APIs, exports, or headless/decoupled consumers.
- Reduce reliance on Full HTML by letting non-technical editors emit constrained Markdown.
- Toggle Markdown output on or off per format without changing the field or storage schema.
- Support both Drupal 10 and Drupal 11 CKEditor 5 editors from one module.
- Provide a repeatable, Composer-free way to fetch the CKEditor JS plugin into the site's libraries directory.
