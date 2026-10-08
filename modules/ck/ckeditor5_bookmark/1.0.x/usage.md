CKEditor 5 Bookmark exposes the native CKEditor 5 Bookmark (anchor) toolbar button that ships inside Drupal core (10.4+/11.1+) but is not enabled by default.

---

This is a pure configuration/glue module with no PHP code, services, permissions, or config schema of its own. Drupal core 10.4.0 / 11.1.0 bundle CKEditor 5 v44.0.0, which includes the Bookmark plugin (`bookmark.Bookmark`) and the compiled asset at `/core/assets/vendor/ckeditor5/bookmark/bookmark.js`, but core does not register it as an available editor toolbar item. The module supplies a `*.ckeditor5.yml` plugin definition (`ckeditor5_bookmark_enable`) that maps the CKEditor plugin to a Drupal toolbar item labelled "Bookmark", declares the libraries (a small admin CSS library plus the core-provided `ckeditor5.bookmark` JS library), and whitelists the `<a id>` element so bookmark anchors survive text-format filtering. You enable it per text format by dragging the bookmark button into the active toolbar at `/admin/config/content/formats`. Requires core module `ckeditor5`.

---

- Add named bookmarks (anchors) to rich-text content via a toolbar button.
- Let editors create in-page "jump to" targets without editing HTML source.
- Build a table-of-contents that links to bookmarks within a long article.
- Insert `<a id="...">` anchor points through the CKEditor UI instead of source editing.
- Enable the bookmark feature only on specific text formats (e.g. Full HTML).
- Allow anchor links to survive text-format filtering via the `<a id>` allowed element.
- Provide accessible skip-to-section targets inside body content.
- Edit or remove existing bookmarks through the native CKEditor bookmark UI.
- Standardize on core's CKEditor 5 44.0.0 bookmark plugin rather than a third-party anchor plugin.
- Support cross-page deep links that target a specific bookmark id.
- Give documentation/FAQ pages internal anchor navigation.
- Add anchors that other links (menus, fields) can reference with `#id` fragments.
- Keep the editor toolbar minimal by enabling bookmarks only where needed.
- Avoid custom code — enable an anchor feature purely through format configuration.
- Replace the legacy CKEditor 4 anchor workflow with the CKEditor 5 native equivalent.
