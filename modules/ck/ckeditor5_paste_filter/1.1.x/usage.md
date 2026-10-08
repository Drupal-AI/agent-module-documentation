CKEditor 5 Paste Filter cleans up markup pasted into a CKEditor 5 editor (typically from Microsoft Word or Google Docs) by running the pasted HTML through an ordered list of configurable search-and-replace regular expressions.

---

The module ships a CKEditor 5 plugin (`ckeditor5_paste_filter_pasteFilter`) that hooks into the editor's `ClipboardPipeline` `inputTransformation` event: on every paste it serializes the incoming content to HTML, applies each configured filter in weight order, and feeds the cleaned HTML back into the editor. Each filter is a JavaScript regular expression (the `search` field) plus a `replace` string; the regex is compiled with the flags `gimsu` (global, ignoreCase, multiline, dotAll, unicode), so you enter the pattern without delimiters, and the replacement can reference capture groups like `$1`. It is configured per text format rather than site-wide: on the text format edit form (`/admin/config/content/formats`) whose editor is CKEditor 5, a "Paste filter" vertical tab under "CKEditor 5 plugin settings" exposes a "Filter pasted content" checkbox plus a draggable table of filters. The module provides a sensible default set of ~14 filters that strip Word/Docs cruft — `<o:p>` tags, inline `style`/`face`/`class`/`valign` attributes, `<font>` and `<span>` wrappers, empty `<p>`/`<b>`/`<i>` tags, `&nbsp;`-only paragraphs, and Word `OLE_LINK` anchors — but you can add, reorder, disable, or delete filters to suit your own needs. Config lives in the editor entity's plugin settings (schema `ckeditor5.plugin.ckeditor5_paste_filter_pasteFilter`) and exports with the text format, so behavior is deployable between environments. The plugin is a no-op until enabled per format, and if disabled or filterless it returns `pasteFilter: false` to the client so no processing runs. It is the CKEditor 5 successor to the older CKEditor Paste Filter module and can be installed alongside it during a CKEditor 4→5 transition. Invalid regular expressions are caught client-side and logged to the browser console rather than breaking the paste.

---

- Clean up messy markup pasted from Microsoft Word into a CKEditor 5 field.
- Strip Google Docs styling and wrapper tags on paste.
- Remove inline `style="..."` attributes that pasted content brings in.
- Strip `class`, `face`, and `valign` attributes injected by office suites.
- Delete `<font>` and `<span>` wrapper tags left over from rich-text sources.
- Remove empty `<p></p>`, `<b></b>`, and `<i></i>` tags after a paste.
- Drop `<p>&nbsp;</p>` spacer paragraphs from pasted Word content.
- Remove Word `<o:p></o:p>` office namespace tags.
- Unwrap Word `OLE_LINK` bookmark anchors while keeping their text.
- Enable paste cleanup on a single specific text format (e.g. Basic HTML) only.
- Add a custom search-and-replace rule to fix a recurring paste artifact.
- Use regex capture groups (`$1`) in a replacement to keep part of a match.
- Reorder filters via drag-and-drop so they run in a required sequence.
- Disable an individual default filter without deleting it.
- Remove a filter entirely by clearing both its search and replace fields.
- Start from scratch by clearing the default filters for a bespoke rule set.
- Normalize pasted quotes, dashes, or whitespace with a custom regex.
- Strip a proprietary CMS's paste markup during a content migration.
- Provide different paste-cleaning rules per text format (editor vs. admin).
- Deploy paste-filter configuration between environments via config export.
- Run both CKEditor Paste Filter (CKEditor 4) and this module during a 4→5 upgrade.
- Prevent pasted markup from violating a text format's allowed-HTML rules.
- Catch invalid custom regexes gracefully (logged to console, paste still works).
- Give editors cleaner, more consistent HTML without manual source editing.
