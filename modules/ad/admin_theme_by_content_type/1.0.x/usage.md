<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Force the administration theme on the node add/edit forms of chosen content types, leaving other types on the front-end theme.

---

Administration Theme by Content Type lets you decide, per node bundle, whether the node **add** and **edit** forms render in the site's administration theme instead of the default (front-end) theme. Drupal core only offers a single site-wide "Use the administration theme when editing or creating content" toggle; this module replaces that all-or-nothing choice with a checklist of content types. You pick which bundles get the admin theme on `node/add/{type}` and `node/{node}/edit`, and every other bundle keeps the front-end theme. It works entirely by altering the appearance form (`/admin/appearance`) to add the per-type checkboxes and by an event subscriber that swaps the active theme early in the request for the matching routes. It depends only on core `node` and stores its list in the `admin_theme_by_content_type.settings` config object.

---

- Use the admin theme when editing Article nodes but keep Basic page on the front-end theme.
- Give staff a consistent admin editing UI for structured content types (landing pages, products) while marketing content edits stay themed.
- Let contributor roles create Blog posts in the front-end theme they are familiar with while editors use the admin theme for News.
- Replace core's single site-wide "use admin theme for editing" toggle with a per-content-type choice.
- Show the admin theme on `node/add/{bundle}` create forms for selected bundles only.
- Show the admin theme on `node/{node}/edit` update forms for selected bundles only.
- Keep the front-end theme (with its CSS/JS and preview fidelity) for content types whose editors need to see front-end styling while editing.
- Standardize the editing experience for a subset of bundles without granting the "View the administration theme" behavior globally.
- Combine with role-based permissions: control which roles may see the admin theme via the core system "View the administration theme" permission.
- Migrate a site that used the core global admin-theme-for-editing toggle to a more granular per-type setup.
- Configure the whole thing from one place — the standard `/admin/appearance` (Appearance) form.
- Store the selection as exportable configuration (`admin_theme_by_content_type.settings:node_bundles`) for deployment across environments.
- Apply the admin theme only to specific editorial workflows (e.g. moderated content types) while public-submission types stay front-end themed.
- Avoid writing a custom theme negotiator when you only need per-bundle admin-theme selection for node forms.
- Set the choice with Drush config commands (`drush cset admin_theme_by_content_type.settings node_bundles.0 article`) as part of automated provisioning.
- Give a cleaner editing surface for complex content types with many fields by using the admin theme's form layout.
- Selectively opt bundles in or out after adding a new content type, straight from the Appearance page.
- Support multi-audience sites where both visitors and staff edit content, choosing the theme by content type rather than by role.
- Keep node preview and edit visually aligned with the front-end for design-sensitive content types by leaving them unchecked.
