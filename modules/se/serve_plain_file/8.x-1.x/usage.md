<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Serve Plain File serves administrator-configured plain-text files (ads.txt, google-site-verification, Facebook domain ownership, sellers.json and similar) at chosen URLs, with the path and content managed as configuration in the Drupal backend.

---

Verification and metadata files often have to live at a fixed URL, and editing the docroot or adding web-server rules for each one is awkward — especially where the docroot is not writable or where SEOs need to change the file without a deploy. Serve Plain File lets an administrator define each file as a `served_file` config entity with a label, URL path, body content, MIME-Type and cache max-age; a dynamic route is registered per path and the controller returns the stored content with the configured Content-Type and cache headers. Because content is admin-authored configuration served at admin-chosen paths — there is no filesystem-path input and no user-supplied content — the served files carry no traversal or upload surface, and the admin screens are gated by the `administer serve plain file` permission. The MIME-Type is restricted to an admin-configurable allowlist and defaults to `text/plain`. Config entities move through Drupal's normal import/export, or can be exempted from config import with Config Ignore so they stay editable in production. Multi-language serving works only with domain-based language negotiation. Verify that a configured path does not unintentionally shadow a real route or file (the add/edit form rejects a path where a real file already exists).

---

- Serve an `ads.txt` file at the site root.
- Serve a `sellers.json` advertising file.
- Serve a Google `google-site-verification` file.
- Serve a Facebook domain-ownership verification file.
- Serve a Bing / Pinterest / other search-engine verification file.
- Serve a small static `humans.txt` or `security.txt`-style file.
- Configure static files entirely in the backend, without shell or FTP access.
- Serve files when the docroot is not writable (immutable/containerized deploys).
- Let SEOs update a verification or ads file without a code deploy.
- Set an explicit `Content-Type` (from the allowlist) on a served file.
- Control the `Cache-Control` max-age of a served file.
- Manage served files as exportable configuration across environments.
- Keep served-file content editable in production using Config Ignore.
- Serve different content per domain in a multilingual, domain-negotiated site.
- Register a URL path that does not correspond to any node or real file.
- Restrict who can create or edit served files via a dedicated permission.
- List, add, edit and delete served files from the admin UI.
- Purge external caches (Varnish/CDN) on change via the `served_file` entity update/delete hooks.
- Confirm a served path does not shadow an existing route or file before publishing.
- Provide a quick per-path text endpoint without writing a custom controller.
