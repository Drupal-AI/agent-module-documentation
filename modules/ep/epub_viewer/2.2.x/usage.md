<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Epub Viewer (project `epub_viewer`, machine name `epub_module`) is a field formatter that turns EPUB file-field values into links that open in a bundled in-browser e-book reader — no external library download required.

---

Apply the *Epub Formatter* (`epub_field_formatter`) to a core file field: for items whose MIME type is `application/epub+zip` it outputs a link to `/view-ebook/{fid}`; any other file type falls back to the normal file link. Opening that link hits the viewer route `epub_module.epub` (`EpubController::viewEbook`), which loads the file, builds its absolute URL and renders the reader theme (`epub_view`) with the configured appearance options. The reader itself is a bundled epub.js/JSZip based JavaScript reader plus jQuery UI and icon fonts, all shipped inside the module. Appearance — background, icon and font colours, and whether a download icon appears — is configured at `/admin/config/epub/epubsettings` (route `epub_module.epub_settings_form`, permission *access administration pages*); if the `color_field` module is enabled the colour fields become colour pickers, otherwise they are plain text boxes. To use it: enable the module (`epub_module`), add a file field, set its display formatter to *Epub Formatter*, and upload EPUB files.

---
- Enable in-browser reading of `.epub` e-books on a Drupal site.
- Enable the module from Extend using its machine name `epub_module`.
- Add a file-upload field to a content type to hold `.epub` uploads.
- Set the field's *Manage display* formatter to *Epub Formatter*.
- Turn EPUB file fields into a "Read Ebook on Reader" link.
- Let visitors page through EPUB chapters directly in the browser.
- Serve the reader with no external JavaScript library to install (assets are bundled).
- Fall back to the standard file link for non-EPUB files in the same field.
- Open the reader directly at `/view-ebook/{fid}` for a given file.
- Configure the reader appearance at `/admin/config/epub/epubsettings`.
- Set the reader's background colour.
- Set the reader's icon colour.
- Set the reader's font colour.
- Show or hide the in-reader download icon.
- Use `color_field` to get colour-picker inputs on the settings form.
- Provide a table-of-contents / chapter navigation sidebar in the reader.
- Offer fullscreen reading via the bundled screenfull integration.
- Support Drupal 9.3, 10 and 11 with no other module dependencies.
- Attach EPUB files to nodes, media, or any fieldable entity with a file field.
- Let editors upload ebooks through the normal file-field widget.
