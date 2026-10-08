Groups Advanced Filesystem's file-cleanup tools — orphan management, bulk deletion, dead image-style detection, filename sanitisation and file utilities — behind a dedicated admin menu.

---

The Cleanup sub-module of Advanced Filesystem collects the project's housekeeping tools under a "Cleanup" admin menu group. It is a routing-only module: it registers the routes, menu links and local tasks, while the controllers and forms that do the work live in the parent advanced_filesystem module. It surfaces Orphan & Retention settings (how old a managed file must be, and which schemes/extensions/paths to exclude, before it counts as an orphan), a batch Bulk Delete Orphans form, a File Tools form (dedup resolver, metadata stripper, filename sanitiser), and Dead Image Styles reporting with routes to flush or delete stale derivatives per style or in bulk. Every route requires the parent module's restricted "administer advanced filesystem" permission.

---

- Configure the minimum age a managed file must reach before it is treated as an orphan.
- Exclude files from orphan detection by scheme, extension or path pattern.
- Bulk-delete orphaned files (unreferenced managed files) with a Batch API progress bar.
- Detect image styles whose derivatives remain on disk after the style was removed from config.
- List each dead image style with its on-disk derivative count.
- Flush (clear derivatives for) a single dead image style.
- Delete a single dead image style and its derivatives.
- Flush all dead image styles at once.
- Delete all dead image styles at once.
- Sanitise existing filenames to ASCII, stripping spaces and special characters.
- Scan a specific directory and list its files with size and date.
- Detect broken references — file_managed rows whose physical file is missing from disk.
- Strip metadata from files via the File Tools utility.
- Reach the Ghost file scan and Private file access tools from the Cleanup menu group.
- Restrict all cleanup operations to administrators via the "administer advanced filesystem" permission.
