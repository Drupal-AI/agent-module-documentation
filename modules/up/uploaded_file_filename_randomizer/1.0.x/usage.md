<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Uploaded File Filename Randomizer hardens file uploads by replacing every uploaded file's name with a random string, keeping only the original extension — following the OWASP File Upload Cheat Sheet recommendation to rename uploaded files.

---

The module subscribes to core's `FileUploadSanitizeNameEvent`. In `randomizeName()` it takes the incoming filename, pops the extension, and calls `event->setFilename((new Random())->machineName(32) . ".$extension")` — producing a 32-character `a-z0-9` name plus the original extension. It applies globally to all uploads made after the module is enabled; there is no configuration and no permissions. Because it hooks the core sanitize-name event, it works uniformly across managed file uploads.

Randomizing filenames mitigates information disclosure (predictable/guessable filenames), overwrite/collision attacks, and some path/name-based tricks, while leaving the extension (and therefore the effective content type handling) intact. Typical setup is simply enabling the module; every subsequently uploaded file is renamed automatically.

---

- Enable OWASP-recommended random renaming of uploaded files
- Prevent guessable/enumerable uploaded filenames
- Reduce filename-collision and overwrite risks
- Strip user-supplied original names from stored files
- Randomize names for all managed file uploads site-wide
- Keep the original file extension after renaming
- Harden a public-facing file/upload field
- Anonymize filenames of user-submitted attachments
- Apply consistent 32-char random names across upload sources
- Avoid leaking metadata embedded in original filenames
- Layer filename randomization into an upload-security strategy
- Protect webform file-upload attachments' names
- Protect media/library upload filenames
- Enforce renaming without per-field configuration
- Mitigate overwriting of existing files by name reuse
- Comply with an internal file-upload naming policy
