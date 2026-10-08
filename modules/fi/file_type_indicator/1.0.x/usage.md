<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File type indicator is an input (text-format) filter that scans links in rendered content and, based on the file extension in the href, adds a CSS class that shows a small file-type icon (e.g. PDF, DOC, ZIP). It ships an icon CSS library and lets you configure which extensions to decorate.

---

- Requires core `filter`; Drupal 9.4+ or 10.
- Enable with `drush en file_type_indicator`.
- At `admin/config/content/formats`, add "Add icon to file link, depends on its extension" to a text format.
- Configure the comma-separated list of file extensions to process (default `pdf,doc,zip`).
- The filter attaches the `file_type_indicator/icons_css` library so icons render.

---

- Show a file-type icon next to download links in body text.
- Decorate links by extension without editing markup.
- Configure which extensions get an icon per text format.
- Apply icons to PDF/DOC/ZIP and other common types.
- Improve UX by signaling what a link downloads.
- Add only a CSS class (safe, DOM-based) to matching links.
- Parse the href path with `parse_url`/`pathinfo` to detect the extension.
- Preserve existing link classes (appends the icon class).
- Attach an icon CSS library automatically.
- Work within any text format's filter pipeline.
- Skip links without a recognizable extension.
- Support editors with no theming knowledge.
- Keep transformations irreversible/output-only.
- Localize/override icons via CSS.
- Use on knowledge bases and document libraries.
- Combine with other content filters.
