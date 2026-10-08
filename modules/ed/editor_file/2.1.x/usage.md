Editor File Upload adds a paperclip toolbar button to CKEditor 5 so content authors can upload a file and insert a link to it directly from the rich-text editor, without a separate file field or FTP.

---

Out of the box, linking to a downloadable file (a PDF, spreadsheet, etc.) in body text means uploading the file elsewhere first and then pasting its URL by hand. This module registers a CKEditor 5 plugin (`editor_file_file`) that provides a **File** toolbar button and an upload dialog: the editor picks or drags a file, it is stored as a managed `file` entity, and a link is inserted carrying `data-entity-type` and `data-entity-uuid` attributes so Drupal tracks the file usage and keeps the link valid. Per text-format settings — configured in the CKEditor plugin settings vertical tab — control whether uploads are enabled, the storage **scheme** (public/private/other stream wrapper), the target **directory**, the **allowed extensions** (required, for security), and a **maximum file size**. It integrates with core's managed-file and file-validation systems and can migrate its settings from the old CKEditor 4 equivalent. It plays well with the Editor Advanced Link module when you need to add title/class/id attributes to the inserted link. The module adds no permissions of its own; access follows the text format's `use` permission.

---

- Let editors upload and link a PDF from within the body field.
- Insert a link to a spreadsheet or document without leaving the editor.
- Attach a downloadable file to an article inline.
- Store editor-uploaded files in the private filesystem for access control.
- Restrict uploads to specific extensions (pdf, docx, xlsx) per text format.
- Cap the maximum size of files uploaded through the editor.
- Choose a custom upload directory for editor files.
- Track file usage automatically via `data-entity-uuid` link attributes.
- Give a specific text format file-upload capability while others lack it.
- Replace a manual "upload then paste URL" workflow for content teams.
- Link to an existing file by URL instead of uploading a new one.
- Provide drag-and-drop file linking in the WYSIWYG.
- Add title/class attributes to file links by pairing with Editor Advanced Link.
- Keep file links valid when the underlying file is moved (uuid tracking).
- Upload files to a remote/CDN stream wrapper if one is configured.
- Enable file uploads only for trusted roles via text-format permissions.
- Standardize where documentation attachments are stored site-wide.
- Migrate CKEditor 4 file-upload settings to CKEditor 5.
- Insert release notes or brochures as inline download links.
- Let authors add a "Download the form" link on a landing page.
- Enforce allowed extensions to prevent unsafe file uploads.
- Offer a paperclip button matching the familiar editor UX.
- Attach meeting minutes or reports to a body field quickly.
