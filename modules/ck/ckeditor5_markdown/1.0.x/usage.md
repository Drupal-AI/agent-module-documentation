CKEditor5 Markdown adds a "Paste Markdown" toolbar button to CKEditor 5 that converts pasted or typed Markdown into HTML on demand and inserts it into the editor.

---

The module extends Drupal's core CKEditor 5 editor with one explicit, user-triggered action rather than automatic clipboard detection. When an editor clicks the Markdown button, a modal dialog with a textarea appears; the user pastes or types Markdown and clicks Insert, and the content is converted to HTML entirely in the browser using the bundled `marked` library (GitHub-Flavored Markdown enabled, `breaks: false`) and inserted at the cursor via CKEditor's data pipeline. The module is purely front-end — it ships a single CKEditor 5 plugin (`markdownPaste.MarkdownPaste`) and some CSS, and provides no server-side code, routes, permissions, services, config schema, or storage. Because conversion feeds CKEditor's normal model, the resulting content is limited to what the format's enabled plugins allow, and the saved value is still processed by the text format's usual filters. It exists to work around the known limitations of CKEditor's experimental auto-detect Paste Markdown feature (unreliable detection and conflicts with other paste/autoformat plugins) by making conversion deliberate.

---

- Let content editors compose in Markdown and drop it into a rich-text field without leaving the WYSIWYG editor.
- Convert README or documentation snippets written in Markdown into formatted body copy for a page or article.
- Paste Markdown exported from note apps (Obsidian, Notion, Bear) and get headings, lists, and links as HTML.
- Migrate Markdown-authored blog posts into Drupal nodes through the editor UI.
- Give technical writers a familiar Markdown workflow while still storing standard filtered HTML.
- Insert Markdown tables (GFM) into content where the Table plugin is enabled.
- Turn Markdown task lists / bullet lists into proper `<ul>`/`<ol>` markup.
- Add fenced code blocks from Markdown into content that permits `<pre>`/`<code>`.
- Quickly format inline emphasis (`**bold**`, `*italic*`) and links without clicking toolbar buttons.
- Provide a deliberate alternative to CKEditor's experimental clipboard-sniffing Paste Markdown feature.
- Avoid conflicts between Markdown auto-detection and Paste-from-Office / Paste-from-Google-Docs plugins.
- Standardize on Markdown as an authoring interchange format across a documentation-heavy site.
- Bulk-convert Markdown content pieces one field at a time during a content-entry sprint.
- Let developers paste code documentation written in Markdown into help or knowledge-base nodes.
- Insert Markdown blockquotes into content that has the Block quote plugin enabled.
- Add the button only to selected text formats (e.g. a "Full HTML" editor) via the format's toolbar configuration.
- Offer Markdown paste to editors on any core CKEditor 5 text format without extra PHP dependencies.
- Convert AI/chatbot output (commonly Markdown) into editable HTML inside the CMS.
- Support multilingual editing teams comfortable with Markdown syntax.
- Prototype content quickly by typing Markdown directly into the dialog instead of the toolbar.
- Keep the editor's clipboard behavior untouched, since conversion is opt-in per action.
