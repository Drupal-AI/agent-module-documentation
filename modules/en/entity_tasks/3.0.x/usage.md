<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Tasks exposes a block (and optional admin-toolbar item) that displays the local tasks — the View/Edit/Delete/Revisions/Translate tabs — available for the current page.

---

Entity Tasks lets you relocate and restyle Drupal core's local task tabs. Core normally renders the local tasks for the current route (View, Edit, Delete, Revisions, Translate, Manage fields, Webform results, and so on) in one fixed region near the page title. This module gathers those same tabs through core's local-task manager for the currently matched route and re-exposes them in two places: an "Entity tasks block" you can drop into any block region (with an option to pin it to the left or right of the screen), and an admin-toolbar integration offering three display modes — classic (a Tasks tray), expanded (each task as its own toolbar tab), and dropdown (tabs shown on hover). Only tabs the current user is allowed to access are shown, because the tabs come straight from core and keep their own access results; the module adds presentation and placement, not new operations or new access. It ships an "access entity tasks" permission that controls whether the block and toolbar item appear, an "administer entity tasks configuration" permission for the settings form at /admin/config/entity-tasks, and JavaScript that decorates known task types (view, add, edit, delete, translations, webform, webform-results, shortcuts) with SVG icons.

---

- Place the current page's Edit/Delete/Revisions tabs in a sidebar block instead of below the title.
- Give editors a persistent, fixed-position tasks block anywhere in the theme layout.
- Pin the tasks block to the left-hand side of the screen for a vertical operations rail.
- Keep the tasks block on the right (default) as a floating operations panel.
- Add entity operation tabs to the admin toolbar so they follow editors across content pages.
- Use the "classic" toolbar mode to collapse all page tasks into a single Tasks tray.
- Use the "expanded" toolbar mode to surface every available task as its own toolbar icon.
- Use the "dropdown" toolbar mode to reveal the current page's tasks on hover.
- Disable toolbar integration entirely while still using the block.
- Show View/Edit/Delete quick actions with recognizable SVG icons for content editors.
- Speed up moderation by putting Edit and Delete one click away on every node page.
- Expose the Translate tab prominently on multilingual sites.
- Surface the Revisions tab for content teams that review history frequently.
- Surface Webform and Webform results tabs on webform nodes for form managers.
- Restrict who sees the relocated tabs by granting "access entity tasks" to specific roles only.
- Let a site builder change the toolbar display style without touching code, at /admin/config/entity-tasks.
- Improve editor UX on custom themes that hide or restyle the default local-tasks region.
- Provide a consistent tasks affordance across differently themed sections of a site.
- Keep operation tabs visible on long pages by using the fixed-position block.
- Offer a compact hover dropdown of tasks to reduce toolbar clutter.
- Present the same core tabs in a theme-friendly, override-able Twig template.
- Reflect each user's permissions automatically, since inaccessible tabs never appear.
- Add task access for anonymous or authenticated roles independently of admin access.
