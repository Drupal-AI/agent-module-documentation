<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Folder Tree provides an interactive AJAX UI for browsing the server directory and file hierarchy.

---

Folder Tree **provides an AJAX UI for browsing the server directory/file hierarchy** — an admin tool that
renders the server filesystem as an interactive tree, rooted at an admin-configured path (default the Drupal root).
It depends on core System and provides its own permissions.

Use it to browse server files in admin. It is an administration tool that reads the **server filesystem**, and it
is built with proper containment: the browse routes are gated by the `access folder tree` / `administer folder
tree` permissions, and the service **confines browsing to the configured `root_path`** — it resolves the requested
path with `realpath()` (collapsing `..` and symlinks) and only proceeds if `str_starts_with($realPath, $realRoot)`,
so a request can't traverse outside the root. Security notes: because it still exposes filesystem structure/names
to anyone with the permission, **grant `access folder tree` only to trusted administrators**, and set `root_path`
to the narrowest directory needed (not `/`). It has no content role. Configure the root path and permission.

---

- Browse the server directory tree.
- Render an AJAX file hierarchy.
- Root at an admin-configured path.
- Depend on core System + provide permissions.
- Serve administration.
- Read the server filesystem.
- CONFINE browsing to root_path via realpath() + str_starts_with (no traversal).
- Gate routes by access/administer folder tree permissions.
- Still expose filesystem names to permitted users.
- Grant 'access folder tree' only to trusted admins + narrow root_path (not /).
- Have no content role.
- Configure the root path and permission.
- Handle folder browsing.
- Browse folders.
- Configure the root.
- Show the tree.
- Handle the AJAX.
- List directories.
- Restrict the permission.
- Provide a server folder browser.
