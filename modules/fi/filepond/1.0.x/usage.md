<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FilePond provides FilePond upload library integration for Drupal, with drag-and-drop uploads and image cropping.

---

FilePond integrates the FilePond JavaScript file-upload library into Drupal — providing a modern
drag-and-drop upload widget with previews, and submodules for image cropping, an entity-browser widget, Views
integration and benchmarking. It depends on core File, provides its own permissions, in the Media package.

Use it for a nicer file-upload experience. It is a content-editing/upload feature; uploaded files are managed
files governed by normal file access, and — as with any upload widget — the security depends on Drupal's
**server-side** upload validation (allowed extensions, size limits, file-access), which still applies (the
client-side widget is convenience, not a security boundary). Keep allowed extensions restricted. It has no
access-control role. Configure the FilePond widget on the file field.

---

- Provide a drag-and-drop upload widget.
- Integrate the FilePond library.
- Show upload previews.
- Support image cropping.
- Depend on core File.
- Provide its own permissions.
- Rely on server-side upload validation.
- Keep allowed extensions restricted.
- Treat the client widget as convenience, not security.
- Have no access-control role.
- Configure the FilePond widget.
- Upload files with FilePond.
- Handle drag-and-drop uploads.
- Crop images on upload.
- Configure the widget.
- Provide upload previews.
- Handle file uploads.
- Integrate FilePond.
- Configure uploads.
- Add a modern upload widget.
