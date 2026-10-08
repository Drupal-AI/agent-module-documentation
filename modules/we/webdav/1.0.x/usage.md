<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Expose Drupal-managed files over the WebDAV protocol with access control.

---

WebDAV provides a WebDAV server for Drupal — exposing Drupal-managed files over the HTTP-WebDAV protocol with Drupal-backed authentication and per-resource access control, so clients (file managers, OS mounts) can browse and manage files while Drupal enforces who can access what.

File access is gated by the `access webdav` permission and per-resource checks; ensure the permission and resource access are configured to prevent unauthorized file access. Depends on core `file` and `user`; supports Drupal 11.

---

- Expose files over WebDAV.
- Provide a WebDAV server.
- Enforce Drupal authentication.
- Apply per-resource access control.
- Let clients mount files.
- Gate by the `access webdav` permission.
- Depend on core `file` and `user`.
- Support Drupal 11.
- Configure access carefully.
- Handle WebDAV.
- Serve files.
- Manage files
- Support Drupal.
- Support Drupal.
- Support Drupal.
