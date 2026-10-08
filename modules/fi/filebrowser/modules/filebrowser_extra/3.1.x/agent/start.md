# Filebrowser Extra — agent index

Example submodule of **filebrowser**. Adds a "Modified" column to directory listings and
serves as the reference implementation for Filebrowser's metadata event API. No config, no
routes, no permissions — just two event subscribers.

- **How it adds a column, and how to write your own** →
  [extend/metadata-column.md](extend/metadata-column.md)

Key facts:
- Depends on `filebrowser`. `configure` = null.
- Subscribes to `filebrowser.metadata_info` (declare the column) and
  `filebrowser.metadata_event` (populate it per file).
- Its classes live under namespace `Drupal\filebrowser_extra` in
  `filebrowser/modules/src/EventSubscriber/`.
