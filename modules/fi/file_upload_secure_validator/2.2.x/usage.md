File Upload Secure Validator (FUSV) hardens Drupal file uploads by checking that a file's real content, detected with PHP's `fileinfo` extension, matches the MIME type implied by its extension, blocking uploads whose content has been disguised (e.g. a PHP or executable file renamed to `.txt` or `.pdf`).

---

FUSV registers an event subscriber on core's `FileValidationEvent`, so every file that flows through Drupal's file validation pipeline (any file field, media upload, or programmatic `File` validation) is inspected automatically with no per-field configuration. For each file it compares the MIME type guessed from the filename (`File::getMimeType()`) against the MIME type guessed from the actual bytes (Symfony's `FileinfoMimeTypeGuesser`). If the two agree the file passes; if they differ it consults a configurable list of "MIME type equivalence groups" and passes the file only when both MIME types belong to the same group. Otherwise it adds a constraint violation that rejects the upload and logs the mismatch to the `file_upload_secure_validator` logger channel. Equivalence groups are edited on a single admin form (a CSV-like textarea) at `/admin/config/media/file_upload_secure_validator`, gated by one permission. Sensible default groups ship in `config/install` for CSV, XML, SVG, gettext `.po`, certificate/PKCS, and Office (DOCX/XLSX) files, which legitimately resolve to overlapping or generic MIME types such as `application/octet-stream`. The module registers its validator service only when the `fileinfo` extension is present (a service provider removes it otherwise) and reports the extension's availability through `hook_requirements`. It defines no plugins, no Drush commands, and no hooks for other modules to implement.

---

- Block uploads where the file content does not match its declared extension (falsified-extension attacks).
- Stop a PHP script renamed to `.txt`, `.jpg`, or `.pdf` from being accepted by a file field.
- Add content-sniffing security to every existing file field without touching each field's settings.
- Protect media library and media entity uploads through the same core file validation event.
- Validate programmatically saved files (custom code that runs core file validation) with no extra wiring.
- Detect real MIME types server-side with the `fileinfo` extension instead of trusting the browser-supplied type.
- Allow CSV files that PHP detects as `text/plain` or `application/octet-stream` via the default CSV equivalence group.
- Allow XML uploads detected as either `text/xml` or `application/xml`.
- Allow SVG images detected as `image/svg+xml` or `image/svg`.
- Allow DOCX/XLSX Office files that sniff as generic `application/octet-stream`.
- Allow certificate and PKCS files (`.pem`, `.crt`, `.p12`, PGP keys, etc.) via the bundled certificate equivalence group.
- Allow gettext `.po` translation files detected as `application/octet-stream`.
- Define your own MIME type equivalence group to whitelist a legitimate file type that is being wrongly rejected.
- Diagnose why a valid file is blocked by reading the logged "guessed X and fileinfo Y" mismatch message.
- Audit disguised-upload attempts through watchdog/dblog entries on the `file_upload_secure_validator` channel.
- Restrict who can edit equivalence groups with the "administer file upload secure validator configuration" permission.
- Manage equivalence groups declaratively by exporting/importing `file_upload_secure_validator.settings` config.
- Verify at install time that the `fileinfo` PHP extension is available (surfaced on the Status Report).
- Fail safe on servers without `fileinfo`: the validator service is not registered rather than throwing errors.
- Harden a site accepting user-generated file uploads (forums, applications, document portals) against content spoofing.
- Complement Drupal's extension allow-list with a content-based check that the extension is truthful.
- Give end users a clear error message ("uploaded file is of type X but the real content seems to be Y") on rejection.
- Call the `file_upload_secure_validator` service's `validate()` method directly from custom code for ad-hoc checks.
