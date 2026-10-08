<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Module Dependencies improves the module list (Extend) page by making the dependency names shown under each module clickable, so you can jump straight to a dependency.

Use it to navigate large module lists and untangle dependency chains faster.

---

Install with `composer require drupal/better_module_dependencies` and enable it (`drush en better_module_dependencies`).

It attaches a small JavaScript library on the Extend page that rewrites dependency labels into links; there is no configuration form or permission to set.

---

- Make module dependencies clickable on the Extend page.
- Attach a lightweight JavaScript behavior to do the rewrite.
- Speed up navigation between related modules.
- Require no configuration.
- Add no new permissions.
- Add no new routes.
- Work purely as an admin-UI enhancement.
- Support Drupal 8, 9 and 10.
- Help audit dependency relationships.
- Keep a minimal footprint (JS + info).
- Leave module data unchanged.
- Improve the developer/admin experience.
- Function only on administrative module screens.
- Complement the core Extend page.
- Avoid third-party libraries.
- Ease onboarding for complex site builds.
- Provide instant links to each dependency's own page.