<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File View Access enables/disables the file view permission for files.

---

File View Access adds a **`file view access` permission** intended to gate viewing of files. It depends on
core File, provides its own permissions, in the Fields package.

Its access handler returns `allowedIfHasPermission('file view access')` for `public`-scheme file entities.
For download gating, Drupal's standard mechanism is the **private scheme** with `hook_file_download`.

---

- Add a 'file view access' permission.
- Use the private scheme for files that must be restricted.
- Gate private downloads via hook_file_download.
- Depend on core File.
- Provide its own permissions.
- Restrict files properly elsewhere.
- Handle file access.
- Configure the permission.
- Move sensitive files to private.
- Handle the module.
- Guard files correctly.
- Provide file access.
