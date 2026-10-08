Media File Delete - Entity Usage plugs the Entity Usage module into Media File Delete's file-usage checks, so a source file that is still referenced by entities tracked in Entity Usage is protected from deletion when its media item is deleted.

---

Media File Delete decides whether it may delete a media item's underlying file by asking a chained file-usage resolver; if any resolver reports usage, the file is kept. Out of the box only core's `file.usage` table is consulted, which misses references that are only tracked by the Entity Usage module (for example media embedded in rich text or linked from fields). This submodule registers an `EntityUsageResolver` service that implements `FileUsageResolverInterface` and is tagged `media_file_delete_file_usage_resolver`, so it joins the chain automatically. Its `getFileUsages()` counts the sources returned by Entity Usage's `listSources($file, FALSE)`, and that count is summed with the other resolvers. The result is that files still referenced anywhere Entity Usage knows about are retained rather than removed. It depends on both `media_file_delete` and `entity_usage`, adds no configuration, permissions, or UI of its own, and simply makes the existing "Also delete the associated file?" option safer on sites that use Entity Usage.

---

- Prevent deleting a file that is still embedded in body text (tracked by Entity Usage) when removing its media item.
- Protect files referenced from fields or other entities that core `file.usage` does not record.
- Extend Media File Delete's in-use guard to cover Entity Usage's broader reference tracking.
- Make bulk media deletion skip files that Entity Usage reports as still referenced.
- Avoid breaking WYSIWYG/media-library embeds when editors clean up media.
- Add Entity Usage's counts on top of core file-usage counts (summed in the chain).
- Enable it alongside Entity Usage to harden file cleanup with no extra configuration.
- Rely on the shared resolver interface so the two modules integrate without custom code.
- Keep shared media assets intact across many pieces of content.
- Turn on the safety net only where Entity Usage is actually installed and tracking references.
- Reduce accidental data loss when the `delete_file_default` option is enabled site-wide.
- Complement core usage tracking for embedded/linked media that core does not count.
- Let editors delete media confidently, knowing referenced files survive.
- Contribute a usage source without writing a custom resolver yourself.
- Ensure files used by tracked entities report usage > 0 so they are retained.
