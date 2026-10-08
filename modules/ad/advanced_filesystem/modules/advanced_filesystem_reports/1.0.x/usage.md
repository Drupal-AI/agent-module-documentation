Adds visual storage reports — a storage-growth chart, a folder-size breakdown and a file-dependency graph — for Advanced Filesystem's managed files.

---

The Reports sub-module of Advanced Filesystem provides administrative reporting pages for managed files under Administration › Reports. It is a routing-only module: it registers the report routes, menu links and local tasks, while the controllers and forms that render them live in the parent advanced_filesystem module. The Storage Growth report charts total managed-file size over time and can export the underlying snapshots as CSV or JSON; the Folder Size report breaks down disk usage per directory within each scheme; and the File Dependency report shows which entities reference a file, with a per-file detail page useful for deciding whether a file can be safely deleted. Every route requires the parent module's restricted "administer advanced filesystem" permission.

---

- Chart total managed-file storage growth over time (per scheme, MIME type, date range).
- Configure how often storage snapshots are captured and how long history is kept.
- Clear accumulated storage-growth snapshots.
- Export storage-growth data as CSV for spreadsheets.
- Export storage-growth data as JSON for external tooling.
- See a per-folder breakdown of disk usage within each stream wrapper.
- Identify which directories consume the most space.
- View the dependency graph of files and the entities that reference them.
- Inspect a single file's referencing entities (nodes, blocks, paragraphs, etc.).
- Check whether a specific file can be safely deleted before removing it.
- Audit which files are referenced only by unpublished content.
- Jump directly to edit each entity that references a file.
- Reach all reports from the Advanced Filesystem "Reports" admin menu group.
- Restrict all report access to administrators via the "administer advanced filesystem" permission.
- Combine the reports with the Cleanup and Lifecycle sub-modules for a full storage-management workflow.
