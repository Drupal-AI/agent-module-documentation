<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Metadata Sanitizer strips metadata from uploaded files using exiftool.

---

Metadata Sanitizer **strips metadata from uploaded files using exiftool** — removing EXIF and other
embedded metadata (GPS location, camera/device info, author, editing history) from uploaded images/files, so
that content published from user uploads doesn't leak that hidden data. It depends on core File, ships
`metadata_sanitizer_ai_agents` and `metadata_sanitizer_tool_api` submodules, provides its own permissions and
Drush support, in the Privacy & Security package.

Use it to remove metadata from uploads. This is a **privacy/security-positive** feature (embedded EXIF/GPS is a
real PII leak from user-uploaded images). It is implemented **safely**: it invokes exiftool via Symfony
`Process` with **array arguments** (`['exiftool', '-overwrite_original', '-all=', …, $path]`), so filenames are
passed to execve directly — there is **no shell interpretation and no command-injection** exposure from file
paths (verified). Requirements: the **exiftool binary must be installed** on the server; you can configure
which tags to preserve. It has no access-control role beyond its permission. Configure sanitization and run
it.

---

- Strip EXIF/metadata from uploads.
- Remove GPS/camera/author metadata.
- Prevent hidden-data (PII) leaks.
- Use exiftool via Symfony Process (array args).
- AVOID shell/command injection (verified safe).
- Require the exiftool binary installed.
- Configure tags to preserve.
- Provide Drush support and permissions.
- Ship AI-agents / tool-api submodules.
- Depend on core File.
- Have no access-control role beyond permission.
- Configure sanitization.
- Handle metadata stripping.
- Sanitize uploads.
- Remove metadata.
- Protect uploader privacy.
- Handle EXIF removal.
- Strip file metadata.
- Run the sanitizer.
- Provide metadata sanitization.
