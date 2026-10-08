<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Convivial Core is a tiny base module that gives the Convivial CXP distribution a shared admin home page and access permission.

---

Convivial Core (package "Convivial", by Morpht) provides shared base plumbing for the Convivial Content Experience Platform distribution/toolkit. Despite the name it is very small: it registers one admin section landing page at `/admin/config/convivial` (titled "Convivial CXP", rendered by Drupal core's `SystemController::systemAdminMenuBlockPage`), a matching admin menu link under the core Configuration page, and one permission, `access convivial administration pages`, which gates that page. It ships no services, no config objects or schema, no controllers of its own, and makes no external service calls. Its purpose is to be a common parent that other Convivial modules can attach their own settings pages and links to. Core requirement `^9.5 || ^10 || ^11 || ^12`; it requires no modules outside Drupal core.

---

- Install as a dependency pulled in by another Convivial module (you rarely install it directly).
- Enable it to create the shared `/admin/config/convivial` admin section for the Convivial stack.
- Give the "Convivial CXP" menu link a home under core's Configuration (`admin/config`) page.
- Provide the `access convivial administration pages` permission to gate that admin section.
- Grant `access convivial administration pages` to a Convivial site-builder or administrator role.
- Act as the common admin parent that other Convivial modules hang their settings routes on.
- Land site builders on `/admin/config/convivial` to reach all Convivial configuration in one place.
- Serve as the base module for a Convivial-distribution-based site.
- Standardize where Convivial modules register their admin links (parent `system.admin_config`).
- Provide a stable route id (`convivial_core.admin_convivial`) other modules can reference as a menu parent.
- Keep Convivial admin navigation grouped rather than scattered across core config sections.
- Bootstrap a new Convivial site with the shared admin scaffolding it expects.
- Include it in a Composer-managed Drupal site via `drupal/convivial_core`.
- Support Drupal 9.5 through 12 with a single small module.
- Remove or disable it only when no Convivial modules that depend on it remain.
- Use it as a minimal example of registering an admin section page + menu link + permission.
- Audit Convivial admin access by controlling a single permission.
- Extend the Convivial admin area by adding child routes/links under its section.
- Provide a consistent admin entry point across Convivial Components, Enricher, and Profiler modules.
- Keep the site's module list explicit about the Convivial base dependency.
