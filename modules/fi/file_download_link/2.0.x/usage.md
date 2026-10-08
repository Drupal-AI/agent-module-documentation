File Download Link provides a `file_download_link` field formatter for File and Image fields that renders each file as a configurable download link — custom link text, an HTML5 `download` attribute (force download), new-tab/rel attributes, title/ARIA labels, and CSS classes, with optional Token replacement.

---

The module's whole surface is one field formatter plugin, `file_download_link` (label "File Download Link"), applicable to `file` and `image` field types. Instead of the core file link, it emits a `#type => link` to the file's URL (via `file_url_generator`) whose text defaults to "Download" (falling back to the filename when empty). Its formatter settings — stored under `field.formatter.settings.file_download_link` on the entity view display — are `link_text`, `link_title`, `aria_label`, `new_tab` (adds `target="_blank"`, default on), `rel_attribute`, `force_download` (adds the HTML5 `download` attribute, default on), `force_download_filename` (a specific filename for that attribute), and `custom_classes` (space-separated classes cleaned and appended). Every rendered link also gets automatic classes `file-download`, `file-download-<mimetype-group>`, and `file-download-<extension>`. When the Token module is enabled, `link_text`, `link_title`, `aria_label`, `force_download_filename`, and `custom_classes` are run through `Token::replace()` with the file entity and host entity as data (and the field's delta is auto-inserted into field tokens), so you can show e.g. the file description and size; without Token the settings form shows a hint to install it. There is no admin/config page (`configure` is null), no permissions, and no Drush — you configure it entirely on a field's *Manage display*. A submodule, **file_download_link_media**, extends the same idea to Media reference fields.

---

- Render an uploaded PDF/DOCX file field as a "Download" link instead of the default file link.
- Force the browser to download a file rather than open it, via the HTML5 `download` attribute.
- Give the download a specific filename with `force_download_filename` (e.g. a friendly report name).
- Open the file in a new browser tab (`new_tab` / `target="_blank"`).
- Set a `rel` attribute (e.g. `noopener noreferrer`) on the download link.
- Use custom link text like "Download the brochure" instead of the raw filename.
- Fall back to the filename automatically when no link text is provided.
- Add a `title` tooltip and an ARIA label for accessible download links.
- Append custom CSS classes to style download buttons/links.
- Rely on the auto-added `file-download`, `file-download-<type>`, `file-download-<ext>` classes for CSS.
- Show the file description followed by its size using Token (`[node:field:description] ([file:size])`).
- Show an image field's alt text plus size as the link label with Token.
- Render a multi-value file field as a list of download links (delta handled automatically in tokens).
- Provide a download link for an Image field's original file rather than a rendered image.
- Build a "resources" or "downloads" listing view using the formatter on a file field.
- Keep download links consistent site-wide by configuring the formatter per view mode.
- Present attachment fields on articles/pages as tidy download buttons.
- Distinguish file types in CSS (e.g. red icon for PDFs via `file-download-pdf`).
- Offer both an inline preview (default formatter) and a forced download (this formatter) in different view modes.
- Localize/translate the link text through the label config value.
- Export the formatter configuration for deployment (it lives in the display config entity).
- Use Token to inject host-entity fields (e.g. node title) into the download link text.
