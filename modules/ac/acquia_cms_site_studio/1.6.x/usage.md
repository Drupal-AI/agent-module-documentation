<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Site Studio is the install-time glue that wires Acquia Site Studio (the Cohesion low-code page builder) into an Acquia CMS / Acquia Drupal Starter Kit site: it sets the cohesion_theme default theme, seeds Site Studio credentials into cohesion.settings, imports the shipped component/style/template packages, creates the Low Code Site Builder role, and grants Cohesion permissions to the standard content roles. It requires the proprietary Site Studio (Cohesion) platform.

---

Part of Acquia's Drupal distribution, this module is infrastructural configuration and glue rather than a standalone feature. It has no settings page, routes, services, permissions file, or Drush commands of its own; everything happens through hooks, shipped config, and a single class-resolved facade (CohesionFacade) that imports each installed acquia_cms_* module's Site Studio package through Cohesion's sync handler. On install it installs and defaults the cohesion_theme, applies cohesion.settings image-browser/dx8 defaults, optionally reads SITESTUDIO_API_KEY / SITESTUDIO_ORG_KEY from the environment to populate credentials, rewrites the Cohesion editor and text format, and pulls in node_revision_delete, responsive_preview, cohesion_style_guide and sitestudio_config_management. Saving the Site Studio account form, the Tour dashboard form, or the installation wizard triggers the element and UI-kit import when keys are first set. Treat the Acquia CMS modules as a set adopted together with acquia_cms_common, not as standalone features to cherry-pick.

---
- Wire Acquia Site Studio into an Acquia CMS site.
- Install the Cohesion low-code page builder as distribution glue.
- Set cohesion_theme as the site's default theme on install.
- Seed Site Studio API and organization keys from environment variables.
- Enter Site Studio credentials on the site installer form.
- Enter Site Studio API/agency keys from the Acquia CMS Tour dashboard.
- Import the shipped Site Studio component and style packages (the UI kit).
- Trigger a Site Studio element import and rebuild when keys are first saved.
- Register Site Studio packages for other acquia_cms_* modules to import.
- Create the "Low Code Site Builder" (developer) role.
- Grant Cohesion component and helper permissions to content roles.
- Grant Site Studio category permissions as new categories are inserted.
- Grant the Cohesion text-format permission to editors and roles.
- Apply the IMCE/media-library image browser config for Cohesion.
- Install node_revision_delete with Acquia CMS default settings.
- Install responsive_preview alongside Site Studio.
- Install cohesion_style_guide and sitestudio_config_management.
- Remove conflicting collapsiblock CSS from Site Studio templates.
- Configure the Cohesion editor and filter format on install.
- Build drag-and-drop page layouts on an Acquia CMS site.
- Coordinate Site Studio setup with the acquia_cms_common family.
- Re-import missing Site Studio component preview images via update hooks.
- Re-save Cohesion config to recalculate dependencies after upgrades.
- Skip the slow UI-kit import in CI via the COHESION_ARTIFACT flag.
- Reuse SiteStudioPermissionHelper to mirror Site Studio grants for custom roles.
