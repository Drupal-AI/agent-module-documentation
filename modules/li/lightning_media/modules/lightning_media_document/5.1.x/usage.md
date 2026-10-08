<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Document is the Lightning Media component that installs a ready-made **Document** media type for locally hosted files (PDFs, Office documents, ODF, Apple iWork, plain text) and teaches core's `file` media source to recognise a document from its extension.

---

Like the other file-based components it is a one-hook module. `hook_media_source_info_alter()` does two things: it sets `$sources['file']['input_match']['field_types'] = ['file']`, declaring which field types the input matcher may look at, and it calls `Override::pluginClass()` to swap core's `file` source class for `Drupal\lightning_media_document\Plugin\media\Source\File`, which is core's class plus `InputMatchInterface` implemented by `FileInputExtensionMatchTrait`. From then on `MediaHelper::getBundleFromInput($file)` will return the Document media type for anything whose extension appears in `field_media_document`'s `file_extensions` — by default a long list covering `txt rtf doc docx ppt pptx xls xlsx pdf odf odg odp ods odt fodt fods fodp fodg key numbers pages`. The rest is `config/optional/`: the `media.type.document` type, the `field_media_document` file field, Lightning Media's `field_media_in_library` boolean, and form/view displays for `default`, `media_library`, `embedded` and `thumbnail`. Because the extension list is broad, Document is often the *fallback* type that claims files the other components do not — which is also why an ambiguous file can raise `IndeterminateBundleException` if two types both accept it.

---

- Add a ready-made Document media type in one `drush en`.
- Let editors drop a PDF into the media library and have Drupal file it as a Document.
- Publish datasheets, whitepapers and brochures as reusable media entities.
- Attach board minutes to a meeting content type through a media reference field.
- Serve Word and Excel templates to staff from the media library.
- Offer ODF/LibreOffice documents on a public-sector site.
- Support Apple Pages/Numbers/Keynote uploads out of the box.
- Restrict what editors may upload by trimming `field_media_document`'s `file_extensions`.
- Add a niche extension (e.g. `csv`, `zip`) to the allowed list for a specific project.
- Cap document upload size with the source field's `max_filesize`.
- Hide draft documents from the media library with `field_media_in_library`.
- Give documents an `embedded` view display used when inserted into body text.
- Give documents a `thumbnail` view display for the library grid.
- Bulk-upload a folder of PDFs with Lightning Media Bulk Upload.
- Reference document media from paragraphs, Layout Builder blocks or Views.
- Use `MediaHelper::createFromInput($file)` in custom code to get a Document media entity for a PDF.
- Validate an uploaded document against the Document type's own rules with `lightning_media_validate_upload()`.
- Give an entity browser widget a document-only `target_bundles` configuration.
- Migrate a legacy file field to media entities with `document` as the target bundle.
- Change where document files are stored via the source field's `file_directory` setting.
- Grant `create document media` to a limited editorial role.
- Translate document titles and descriptions on a multilingual site.
- Use the Document type as the catch-all so unusual uploads still land somewhere sensible.
- Combine with Search API attachments to index the text inside uploaded PDFs.
