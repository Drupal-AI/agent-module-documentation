<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Static Content Iframe (SCI) lets you upload a zipped static site (HTML/CSS/JS with an `index.html`) and render it inside an iframe within your Drupal pages, useful for embedding self-contained micro-sites, reports or interactive builds.

---

SCI defines a `static_content` content entity with its own permissions (`add`/`edit`/`delete`/`view static content entities`, plus `administer static content entities` marked restrict-access). Entity routes live under `/admin/structure/static_content` and are governed by `StaticContentAccessControlHandler` (view requires `view static content entities`, etc.). On the edit form, a `managed_file` element accepts a `.zip`, which is extracted via a batch into `public://static/<md5-hash>/`; the entity records the base URI and the discovered `index.html`, then displays it in an iframe with configurable width/height/autoheight. Because the archive is extracted into the public files directory and its `index.html` (with any JavaScript) is served from the site in an iframe, grant the create/edit/view permissions only to fully trusted roles.

---

- Embed a self-contained static micro-site inside a Drupal page.
- Serve a zipped HTML report through an iframe.
- Host an interactive data-viz build without a separate server.
- Upload a static archive and auto-detect its index.html.
- Control iframe width, height and autoheight per entity.
- Manage static content items as first-class entities.
- Restrict who can create/edit/view static content via permissions.
- Provide theme suggestions per static-content item.
- Replace an old archive by re-uploading a new zip.
- Clean up extracted files when an entity is deleted.
- Embed vendor-provided static deliverables in the CMS.
- Show a legacy static page within the current theme.
- List all static content items in an admin collection.
- Grant view-only access to published static builds.
- Keep static assets under public:// for direct serving.
- Limit upload/edit rights to trusted roles.
