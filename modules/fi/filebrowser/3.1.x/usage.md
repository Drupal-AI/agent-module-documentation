Filebrowser exposes directories on the server's file system to site visitors as an FTP-like, browsable file listing rendered through Drupal. Each listing is a node of the `dir_listing` content type that points at a folder and shows its files with download, upload, rename, delete and zip-archive actions gated by permissions.

---

Filebrowser adds a `dir_listing` node type. Each `dir_listing` node stores a `folder_path` (a stream-wrapper URI such as `public://docs` or `private://reports`) plus a set of per-node rights and presentation options in the module's own `filebrowser_nodes` database table (wrapped by the `Filebrowser` value object and the `filebrowser.storage` service), not in Fields. Viewing the node renders a cached file listing (columns: icon, name, created, size, mimetype, description) built from the folder's contents and stored in the `filebrowser_content` table; the cache refreshes when the node is edited or an action is performed. Global defaults for new listings live in the `filebrowser.settings` config object, edited at `/admin/config/system/filebrowser` (route `filebrowser.settings`). A dynamic permission set (view listings, download files, upload files, rename files, delete files, create folders, download archive, ...) controls what each role may do, and downloads can be served publicly (redirect to the file) or privately (streamed by Drupal). The listing's columns are extensible through a metadata event system (`filebrowser.metadata_info` / `filebrowser.metadata_event`), demonstrated by the bundled `filebrowser_extra` submodule which adds a "Modified" column. Remote file systems (S3, Dropbox) are supported when the Flysystem module and an adapter are configured. On this site the shipped `field.field.node.dir_listing.body` instance is missing (see the note in `agent/configure/dir-listing-node.md`).

---

- Publish a browsable download area for a folder of PDFs or manuals on the site.
- Expose a `private://` directory of files that only certain roles may download.
- Let editors upload files into a folder straight from the listing page.
- Offer a "download all as zip" button for a folder of assets.
- Serve files through Drupal (private download method) so access is permission-checked.
- Give a directory listing a path alias and node access controls like any other node.
- Allow trusted users to create sub-folders inside an exposed directory.
- Let users rename files and edit file descriptions inline.
- Restrict which files appear using a blacklist (e.g. hide `*.git`, `descript.ion`).
- Restrict a listing to a whitelist of file patterns.
- Show or hide subdirectories and let users explore into them.
- Present files as a list view or a thumbnail grid.
- Hide file extensions in the listing for a cleaner presentation.
- Choose which columns (icon, name, created, size, mimetype, description) are visible.
- Set a default sort column and direction for a listing.
- Force downloads (Content-Disposition: attachment) rather than opening in the browser.
- Publish a listing backed by a remote S3 or Dropbox bucket via Flysystem.
- Provide a per-listing accepted-extensions whitelist for uploads.
- Prevent overwriting existing files on upload, or explicitly allow it.
- Add a custom metadata column (e.g. "Modified" date) via the metadata event API.
- Build an internal team file share without granting server/FTP access.
- Replace an Apache autoindex page with a Drupal-themed, access-controlled listing.
- Show statistics (file count, total size) for a listing.
- Override the breadcrumb so it reflects the folder hierarchy being browsed.
- Set global defaults once so every new directory listing inherits them.
