<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LGMS is a library guide management system for building, organizing, and sharing research/library guides.

---

Built on node bundles (guide, guide page, guide box) with a dashboard, the module lets library staff create guides, add boxes and box items (media, links, content), reorder pages/boxes, reuse guides, and publish browsable listings by subject, type, and group plus a databases page and printable guide download. Public browsing routes use `access content`; dashboard/creation routes use dedicated permissions (`access dashboard`, `create guide content`); and the guide/box/page mutation forms enforce custom access that checks node `update`/`delete` access on the target node. It targets academic/library sites needing a LibGuides-style tool.

---

- Build LibGuides-style research/library guides.
- Organize guides into pages, boxes, and box items.
- Browse guides by subject, type, and group.
- Provide a staff dashboard for guide management.
- Create guides and guide content from the dashboard.
- Reuse an existing guide as a template.
- Add media items to guide boxes via Media Library.
- Reorder guide pages, boxes, and box items.
- Publish a databases listing page.
- Download/print a guide.
- Gate public browsing behind `access content`.
- Gate the dashboard behind `access dashboard`.
- Gate guide creation behind `create guide content`.
- Enforce node update/delete access on edit/delete forms.
- Serve academic and library sites.
- Support Drupal 10 with Media and Media Library.
