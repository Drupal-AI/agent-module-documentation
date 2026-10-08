<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media File Formatters (mff) adds two display formatters for core **file** fields: one that uses the parent entity's label as the download link text, and one that renders the file item's **description** either as the link text or as standalone text with no link.

---

The module is display-only: it registers two `@FieldFormatter` plugins that both target the core `file` field type, and provides nothing else (no routes, permissions, services, hooks beyond `hook_help`, or Drush). `MffNameLinkFormatter` (plugin id `mff_name_link_formatter`, label "Name field link text") renders each referenced file as a `#theme => 'file_link'` element whose `#description` (the link text) is the **parent entity's** `label()` rather than the file's own description; an `open_in_new_window` setting adds `target="_blank"` to the link. `MffDescriptionFormatter` (plugin id `mff_description_formatter`, label "File field description text", extending core's `DescriptionAwareFileFormatterBase`) renders the file item's **description**: when its `use_description_as_link_text` setting is on it emits a `file_link` element with the description as link text; when off it emits a `#type => 'processed_text'` element containing just the description (no link), which is handy in Views to surface a file field's description without adding a separate field. Both iterate `getEntitiesToView()` so core's file access and per-item display flags are respected, attach the file's cache tags, and forward any `_attributes` from the field item to the rendered element. Config schema exists for the name-link formatter's `open_in_new_window` setting (`field.formatter.settings.mff_name_link_formatter`). Note: the project README points at the original sandbox (`drupal.org/sandbox/imclean/3051849`), and the open-in-new-window path historically referenced core patch `#2727281`. The formatters are selected per view-display on *Manage display*.

---

- Show a file download link using the node's (parent entity's) title as the link text instead of the raw filename.
- Add "open in a new window" (`target="_blank"`) to a file-field download link.
- Display an uploaded document's **description** on the page without adding a separate field.
- Surface a file field's description text in a **Views** field output rather than creating a new field.
- Render the description as the clickable download link text (description-as-link mode).
- Render the description as plain (processed) text with no link at all.
- Give a "Downloads" or "Attachments" list link text that matches the content's title.
- Present a list of attached PDFs where each link reads as the parent page's name.
- Keep file link text consistent across a bundle by driving it from the entity label.
- Let editors control link wording by editing the file's description field.
- Display attachment captions/descriptions beneath or beside a media/file field.
- Show a document's human-readable description in a teaser or listing view mode.
- Combine with the core file field's description to build accessible, meaningful download links.
- Provide a template-friendly split: use the name as link text while printing `file._referringItem.description` separately in a Twig template.
- Configure per view-display (default, teaser, etc.) so different displays show name-link vs description-only.
- Replace the default "Generic file" formatter when the filename is not a good label.
- Publish reports or forms where the download link should read as the page title.
- Show only descriptive text for a file (e.g. a caption) while hiding the actual download link.
- Honor core file access: files the viewer cannot access are excluded via `getEntitiesToView()`.
- Preserve rendered-field caching by inheriting each file's cache tags.
