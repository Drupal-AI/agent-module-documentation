<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File MIME Type Enforcer enforces matching MIME types between extension-based and content-based detection for uploads.

---

File MIME Type Enforcer **validates that a file's extension matches its real content** — on upload it compares
the MIME type Drupal infers from the **extension** (`ExtensionMimeTypeGuesser`) against the MIME type Symfony's
**fileinfo** detects from the file **content**, and rejects mismatches (with configurable alternative/allowed
mappings). It depends on core File and System.

Use it to harden file uploads. This is a **security-positive** validation layer: MIME/extension mismatch is how
many malicious uploads work (a file named `photo.png` that is actually HTML, an SVG, or a script), and requiring
the content to match the claimed extension blocks that class of upload abuse (stored XSS via HTML/SVG,
disguised executables, etc.). Configure the allowed mappings for legitimate cases (some valid files' detected type
differs from the extension), and combine it with Drupal's core upload restrictions (allowed extensions, private
scheme, no direct execution). It has no access-control role. Configure the MIME enforcement.

---

- Match extension MIME vs content MIME on upload.
- Compare ExtensionMimeTypeGuesser to Symfony fileinfo.
- Reject mismatched uploads.
- Depend on core File + System.
- Serve upload hardening.
- Support configurable allowed mappings.
- BE security-positive (blocks MIME-spoofed uploads).
- Block disguised uploads (a .png that is really HTML/SVG/script → stored XSS/disguised executables).
- Configure allowed mappings for legitimate content-vs-extension differences.
- Combine with core upload restrictions (allowed extensions, private scheme, no execution).
- Have no access-control role.
- Configure the MIME enforcement.
- Handle upload validation.
- Validate MIME.
- Configure the mappings.
- Check uploads.
- Handle the uploads.
- Reject spoofs.
- Harden uploads.
- Provide MIME enforcement.
