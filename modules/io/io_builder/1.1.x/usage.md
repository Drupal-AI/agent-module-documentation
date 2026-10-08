<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IO Builder allows content administrators to build pages using a frontend builder.

---

IO Builder provides a frontend (in-place) page builder — letting content administrators build pages
visually on the front end (drag-and-drop layout/components), with a `io_builder_paragraphs` submodule for
Paragraphs integration. It provides its own permissions.

Use it for visual front-end page building. It is a content-editing/page-building feature. Editing capability
is governed by its permissions plus the underlying entity/field **edit access** — so verify the builder is
only available to users who may edit the content (a front-end builder shouldn't bypass entity/field edit
access), and gate its permission to trusted editors. It has no access-control role beyond that. Configure the
builder.

---

- Build pages with a frontend builder.
- Let admins build pages visually.
- Drag-and-drop layout/components.
- Provide a Paragraphs submodule.
- Provide its own permissions.
- Edit pages in-place on the front end.
- Govern editing by permissions + entity access.
- Not bypass entity/field edit access.
- Gate the builder to trusted editors.
- Have no access-control role beyond that.
- Configure the builder.
- Handle page building.
- Build pages visually.
- Configure permissions.
- Verify who can edit.
- Handle the builder.
- Build front-end pages.
- Configure the page builder.
- Restrict the builder.
- Build pages.
