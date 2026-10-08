<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image style usage builds a report showing every place each image style (and responsive image style) is referenced — across all entity view displays and all Views — and separately lists image styles that are not used anywhere.

---

The `ImageStyleUsageController::usage()` method loads all entity view displays and Views, walks their image and responsive-image field settings, and tabulates each usage with links to the relevant display or Views edit form. Styles referenced by no display/view are collected into an "Unused image styles" table so administrators can safely clean them up. The report is exposed at `/admin/config/media/image-styles/usage` and requires `administer image styles`.

This is a read-only reporting/audit tool. It uses `accessCheck(TRUE)` when querying view displays and renders all output through Link/table render elements, so labels are escaped. It defines no mutation routes and only the single admin-gated report route.

---

- List where every image style is used.
- Show usages in entity view displays.
- Show usages in Views field configurations.
- Include responsive image style mappings.
- Identify image styles that are unused.
- Link each usage to its display or Views edit form.
- Help clean up orphaned image styles safely.
- Audit image style configuration across the site.
- Group usages by image style.
- Distinguish image vs responsive-image usages.
- Require `administer image styles` to view.
- Render output as accessible tables with links.
- Use access-checked entity queries.
- Support any entity type and bundle.
- Avoid manually hunting for style references.
- Provide a single reporting page.
