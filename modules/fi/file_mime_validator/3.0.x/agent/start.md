<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Mime Validator (file_mime_validator) — agent index

Adds a server-side upload check that detects a file's real (content-based) MIME type and
compares its category against the category implied by the filename/extension, as
defence-in-depth behind core's extension allow-list. Implemented as a `hook_file_validate()`
implementation that delegates to the `file_mime_validator` service. No module dependencies;
core `^10 || ^11`; package `Security`.

Configure route: `file_mime_validator.file_types_mime_config_form`
(`/admin/config/system/file-mime-validator/file-types-mime-config`). No permissions, drush
commands, or plugin types are defined. Ships a config object + schema.

- **Change which MIME types map to each category (text / image / compression / audio / video)** → [configure/mime-types.md](configure/mime-types.md)
- **Understand or call the validation logic (service, real-MIME detection, hook wiring)** → [api/validator-service.md](api/validator-service.md)

Key facts:
- Service id `file_mime_validator` (class `Drupal\file_mime_validator\Service\FileMimeValidator`); public methods `checkRealMime(File $file): array` and `getFileType(string $mime): string`.
- Wiring: `file_mime_validator_file_validate(File $file)` in `file_mime_validator.module` implements `hook_file_validate()`.
- Real-MIME detection: Symfony `FileinfoMimeTypeGuesser` (PHP `finfo` / libmagic) reading the file's bytes.
- Config object `file_mime_validator.settings` with keys `file_mime_validator_text`, `file_mime_validator_image`, `file_mime_validator_compression`, `file_mime_validator_audio`, `file_mime_validator_video` (each a comma-separated MIME list).
- Logger channel `file_mime_validator` (service `logger.channel.file_mime_validator`).
- Settings form class `Drupal\file_mime_validator\Form\FileTypesMimeConfig`; menu link parent `system.admin_config_system`; route permission `administer`.
- Also implements `hook_help()` for `help.page.file_mime_validator`.
