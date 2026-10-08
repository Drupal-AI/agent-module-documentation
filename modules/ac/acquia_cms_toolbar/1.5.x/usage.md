<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Toolbar restyles the admin toolbar to match the Acquia CMS look, adds an environment-indicator tab that colours itself by the detected Acquia hosting environment, and grants the core "access toolbar" permission to the standard Acquia CMS roles.

---

This is a small theming/glue module from the Acquia CMS (rebranded "Acquia Drupal Starter Kit") family. It builds on contrib `admin_toolbar` and `admin_toolbar_tools`, which it depends on and enables. It ships only CSS and JavaScript plus a handful of hooks — no settings form, services, routes, entities, permissions definition, drush commands, or plugin types. At runtime it adds body classes (`acquia-cms-toolbar`, `acquia-cms-environment-*`), attaches its toolbar CSS to the `admin_toolbar_tools` item and its offset JS to pages for users who can see the toolbar, and injects an `environment_indicator` toolbar item whose label and colour come from `AcquiaDrupalEnvironmentDetector` (local, IDE, dev, stage, or prod). It also grants the core `access toolbar` permission to the Acquia CMS content and admin roles, both when those roles are created (via a role-presave hook fired by `acquia_cms_common`) and via an update hook. It conflicts with older `acquia_claro` (`<1.4`) and, like the rest of the family, assumes an Acquia CMS site. Treat the Acquia CMS modules as a set adopted together rather than standalone features to cherry-pick.

---
- Restyle the Drupal admin toolbar to match Acquia CMS.
- Add an environment-indicator tab to the toolbar.
- Colour the toolbar by hosting environment (local/IDE/dev/stage/prod).
- Show editors which Acquia environment they are working in.
- Grant "access toolbar" to Acquia CMS content roles automatically.
- Give content authors and editors toolbar access out of the box.
- Pair the admin_toolbar module with Acquia CMS branding.
- Keep admin chrome consistent across the Acquia CMS family.
- Attach toolbar CSS only to the admin_toolbar_tools menu.
- Load toolbar offset JS only for users with toolbar access.
- Prevent the main menu from overlapping the admin toolbar.
- Add body classes for theming admin pages by environment.
- Skin the toolbar environment icon with Acquia SVGs.
- Enable admin_toolbar and admin_toolbar_tools as dependencies.
- Provide branded admin navigation on an Acquia CMS site.
- Re-grant toolbar access to existing roles via update hook.
- Detect Acquia Cloud environment for on-screen labelling.
- Combine with acquia_cms_toolbar_gin for the Gin admin theme.
- Standardise the editor toolbar experience across sites.
- Give site builders and developers toolbar access by default.
- Improve navigation for the user_administrator role.
- Apply Acquia's admin visual polish to the toolbar.
- Support the wider Acquia Drupal Starter Kit ecosystem.
