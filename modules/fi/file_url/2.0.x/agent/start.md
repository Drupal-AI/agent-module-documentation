<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File URL — agent index

Provides a **`file_url`** field type: one field that accepts either an uploaded local file
or a pasted remote URL, both stored as a URI string. Extends core File. No admin settings
form (`configure: null`); one global config key `file_url.settings.dereference_host`.

- **Add/configure a `file_url` field, widget (`file_url_generic`) & formatter (`file_url_default`), and the dereference host** →
  [configure/field.md](configure/field.md)
- **Programmatic API: `FileUrlHandler` conversions, the `RemoteFile` entity, the `file-dereference` route & selection plugin** →
  [api/handler.md](api/handler.md)

Key facts:
- Field type `file_url` extends `FileItem`; stores the reference in a **`target_id` varchar(2048)** holding a URI, not a numeric fid.
- Local uploads are stored as `/file-dereference/{fid}`; remote files are stored as the raw URL. `FileUrlHandler::isRemote()` tells them apart.
- The `RemoteFile` entity is a `File` subclass with **null storage** (no DB row), `id()` = its URI.
- Route `file_url.dereference` (`/file-dereference/{file}`) 302-redirects to the real file so external consumers can resolve it.
- Depends only on core `file`. Provides config schema, no permissions, no Drush, no plugin *types*.
