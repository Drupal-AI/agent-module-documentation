Flmngr adds the Flmngr file manager and image editor to CKEditor and to Drupal file/image fields, wiring itself up automatically through its N1ED dependency.

---

Flmngr is a small integration/bootstrap module: it has no code of its own beyond a help hook and an install hook, and delegates every file-manager feature to the `drupal/n1ed` module it requires. On install it configures N1ED to use the Flmngr integration (API key `FLMN24RR`, `integrationType = flmngr`), adds the Flmngr buttons to CKEditor 4 toolbars, and turns on the file manager for file/image fields. Once enabled it behaves like a standard CKEditor Drupal add-on: it is active in any text format that uses CKEditor and where Flmngr is not switched off, and you configure it per text format on the Text formats admin page. The bundled backend (provided by N1ED) stores files under `public://flmngr`, `public://flmngr-tmp`, and `public://flmngr-cache`, and its browse/upload endpoints require the `administer flmngr files` permission plus a CSRF header token. A paid cloud tier optionally adds Amazon S3 / Azure Blob storage and Unsplash stock-photo search.

---

- Install Flmngr via Composer to get a preconfigured file manager with no manual setup (`composer require drupal/flmngr`).
- Let the install hook auto-attach Flmngr buttons to existing CKEditor 4 toolbars.
- Upload files and images directly from inside the CKEditor editing area.
- Browse and pick previously uploaded files from a visual file-manager dialog.
- Insert images into rich-text content and edit them with the built-in image editor (crop, resize, transform).
- Attach the Flmngr file manager to Drupal file fields so editors upload through the same UI.
- Attach it to image fields the same way (controlled by the `useFlmngrOnFileFields` setting).
- Enable Flmngr for editorial text formats (e.g. Full HTML) while keeping it off restricted formats used in comments.
- Disable Flmngr per text format where a rich file manager is not wanted.
- See the "Flmngr" badge next to formats where it is enabled on the Text formats overview page.
- Configure Flmngr options inside a text format's CKEditor configuration widget (Configuration > Content authoring > Text formats).
- Use it with either CKEditor 4 or CKEditor 5 (buttons must be added to the CKEditor 5 toolbar in Full HTML manually).
- Search over 30K free Unsplash stock photos from within the file manager (optional cloud feature).
- Store managed files on the local server for free under the public files directory.
- Optionally switch storage to an Amazon S3 bucket or Azure Blob container (paid cloud tier).
- Restrict file-manager access to trusted roles via the `administer flmngr files` permission (default: administrators only).
- Toggle between the current and the legacy Flmngr backend from the N1ED settings, if compatibility requires it.
- Get on-screen guidance from the module's help page (`admin/help/flmngr`) describing installation, configuration, and troubleshooting.
- Provide content editors a unified upload/browse experience across both the WYSIWYG editor and field widgets.
- Deploy the file-manager server part automatically — no separate PHP endpoint to install or wire up.
- Keep uploads organized in dedicated `flmngr`, `flmngr-tmp`, and `flmngr-cache` subdirectories of the public filesystem.
- Troubleshoot missing buttons by selecting the correct text format (Full HTML) in the editor's format selector.
