<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Upload Secure Validator (2.2.x)

Blocks file uploads whose real content (detected via PHP `fileinfo`) disagrees with the
MIME type implied by the extension. Works automatically on ALL file uploads by subscribing
to core's `FileValidationEvent` — no per-field setup. The only configuration is a list of
MIME type "equivalence groups" that whitelist legitimate mismatches.

- **How validation works + the service API** → [api/file_upload_secure_validator.md](api/file_upload_secure_validator.md)
- **Configure equivalence groups (settings form, config object, defaults)** → [configure/file_upload_secure_validator.md](configure/file_upload_secure_validator.md)
- **Permission that gates the settings** → [permissions/file_upload_secure_validator.md](permissions/file_upload_secure_validator.md)

Facts an agent needs up front:
- No plugins, no Drush commands, no `.api.php` hooks for other modules.
- Requires the `fileinfo` PHP extension; if absent the validator service is not registered
  (see `FileUploadSecureValidatorServiceProvider`) and `hook_requirements` flags an error.
- Config object: `file_upload_secure_validator.settings`, key `mime_types_equivalence_groups`.
