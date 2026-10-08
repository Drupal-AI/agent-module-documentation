Filebrowser Extra is a small example submodule that adds a "Modified" (file modification time) column to Filebrowser directory listings, demonstrating how to extend a listing with custom metadata via Filebrowser's metadata event API.

---

Filebrowser Extra ships two event subscribers and nothing else — no config, no forms, no permissions. `MetadataInfoEventSubscriber` listens on the `filebrowser.metadata_info` event and declares a new column keyed `modified` (`['title' => t('Modified'), 'type' => 'integer']`). `MetadataEventSubscriber` listens on the `filebrowser.metadata_event` and fills that column for each file, using `@file_system`, `@date.formatter` and `@entity_type.manager` (injected via its `filebrowser_extra.services.yml` definition) to compute and format each file's modification date. It exists as a copy-paste template: enable it to get a working extra column, or read its two classes to learn the exact subscriber shape needed to add your own metadata (author, checksum, custom flag, ...) to Filebrowser listings. It depends on and is meaningless without the parent `filebrowser` module.

---

- Add a "Modified" (last-changed) date column to every Filebrowser directory listing.
- Learn the exact event-subscriber pattern for adding a custom Filebrowser metadata column.
- Use it as a starting template for a "File owner" or "Uploaded by" column.
- Copy its structure to add a checksum/hash column to listings.
- Add a custom "Category" or "Tag" column driven by your own data source.
- Demonstrate to a team how Filebrowser's `metadata_info` / `metadata_event` events work.
- Show file mtime to users browsing a shared download folder.
- Provide a worked example of injecting `date.formatter` to format a timestamp column.
- Test that Filebrowser's metadata pipeline is wired correctly on a site.
- Extend listings without patching the Filebrowser module itself.
- Base a "file size in KB" custom column on this example's value-populating subscriber.
- Prototype a custom metadata column before writing a bespoke module.
- Add a sortable extra attribute to the file table via the event `type` hint.
- Teach new Drupal developers the Symfony event-subscriber + services.yml pattern.
- Keep custom listing columns in their own module, cleanly separated from core Filebrowser.
