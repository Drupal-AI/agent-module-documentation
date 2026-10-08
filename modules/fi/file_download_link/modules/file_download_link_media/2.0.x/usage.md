File Download Link Media is a submodule of File Download Link that adds a `file_download_link_media` field formatter for **entity reference fields that point at Media**, rendering the referenced media as a direct download link to its source file or image.

---

Where the parent module's formatter works on `file`/`image` fields, this submodule's formatter (`file_download_link_media`, label "File Download Link") targets `entity_reference` field types. Its `isApplicable()` only offers it for reference fields whose `target_type` is `media` and whose referenced media types have source fields of type file and/or image. At render time it loads each referenced media entity, finds its source field, and renders that source field through the parent `file_download_link` formatter (`->view(['type' => 'file_download_link', 'label' => 'hidden', 'settings' => $this->getSettings()])`) — so all the parent's options apply: `link_text` (default "Download"), `link_title`, `aria_label`, `new_tab`, `rel_attribute`, `force_download`, `force_download_filename`, `custom_classes`, plus Token support when the Token module is enabled (file + media token types). Configuration is identical in shape (schema `field.formatter.settings.file_download_link_media`) and is set on the reference field's *Manage display*. It requires the `media` and `file_download_link` modules, has no config page, permissions, or Drush commands.

---

- Render a Media reference field as a "Download" link straight to the media's source file.
- Let editors attach a document via a Media reference and expose it as a forced download.
- Provide download links for image media without embedding the rendered image.
- Force-download a referenced media file using the HTML5 `download` attribute.
- Open a referenced media file in a new tab from a media reference field.
- Use custom link text (e.g. "Download brochure") for a media reference download link.
- Show the media name and file size as the link text via Token.
- Add a `rel` attribute (e.g. `noopener`) to media download links.
- Apply custom CSS classes to media download buttons.
- Present a "downloads" listing that references reusable Media documents.
- Reuse the same media item across nodes while each shows a download link.
- Give an accessible media download link with a title tooltip and ARIA label.
- Set a specific download filename for a referenced media file.
- Offer a rendered media display in one view mode and a forced download in another.
- Turn a media library selection into a straightforward file download for site visitors.
- Handle multi-value media reference fields as a list of download links.
- Keep media governance (via Media entities) while still offering direct downloads.
- Migrate legacy file fields to Media references without losing download-link display.
- Localize the media download link text through the label config value.
- Deploy the media download display via exported entity view display config.
