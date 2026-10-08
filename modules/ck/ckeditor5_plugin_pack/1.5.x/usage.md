CKEditor 5 Plugin Pack is an umbrella project that bundles many free CKEditor 5 plugins (font, highlight, find & replace, word count, media embed and more) for Drupal's CKEditor 5, each shipped as its own submodule sharing a common base module.

---

The base module (`ckeditor5_plugin_pack`) provides the shared plumbing — a settings form, a library version checker, and a settings config handler — that all the individual plugin submodules build on; on its own it also adds a small "Drupal powered by" editor plugin. The real functionality comes from enabling the submodules you need, each of which registers one or more CKEditor 5 plugins (via `*.ckeditor5.yml`) that you then add to a text format's toolbar at Admin → Configuration → Content authoring → Text formats and editors. Because every editor button is opt-in as a separate module, sites only load the JavaScript for the features they actually use. The base module's settings (Admin → Configuration → CKEditor 5 Plugin Pack) control where the CKEditor DLL/library assets are loaded from and whether to block the external CDN, which matters for sites that must self-host all assets. It requires core's Editor and CKEditor 5 modules, and depends on the CKEditor 5 Premium Features module for shared premium plumbing. Notable submodules include Font (family/size/color), Highlight, Find and Replace, Word Count, Text Transformation (autocorrect-style replacements), and Media Embed. Others cover emoji, bookmarks, fullscreen, templates, page break, paste from Markdown, restricted editing, and more.

---

- Add font family, size and text/background color controls to the editor.
- Highlight text with a marker in several colors.
- Give editors a Find and Replace dialog in the WYSIWYG.
- Show a live word/character count under the editor.
- Auto-transform text (e.g. (c) → ©, -- → —, straight → smart quotes).
- Embed media (YouTube, etc.) by pasting a URL.
- Insert emoji from a picker.
- Add bookmarks/anchors within long content.
- Toggle a distraction-free fullscreen editing mode.
- Insert reusable content templates.
- Add page breaks for print/PDF output.
- Paste content written in Markdown and convert it to rich text.
- Enable restricted editing so only certain regions are editable.
- Add a "select all" editor command.
- Indent whole blocks of content.
- Insert and manage layout tables.
- Add extra attributes (rel, target, class) to links.
- Embed raw HTML snippets in content.
- Insert to-do / checklist document lists.
- Auto-insert images when pasting image URLs.
- Add an empty block element for spacing/layout.
- Run a free WProofreader spell/grammar check in the editor.
- Self-host CKEditor assets and block the external CDN for compliance.
- Load only the editor JS for features a format actually uses.
- Build a tailored editor toolbar per text format from modular plugins.
- Standardize authoring tools across many text formats.
