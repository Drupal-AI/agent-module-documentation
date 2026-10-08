<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_site_studio — agent index

Install-time glue that wires **Acquia Site Studio** (the Cohesion low-code page builder) into an
Acquia CMS / Acquia Drupal Starter Kit site. On install it sets the `cohesion_theme` default theme,
seeds Site Studio credentials into `cohesion.settings`, imports the shipped Site Studio component
packages (the UI kit), creates the `developer` ("Low Code Site Builder") role, and pulls in
`node_revision_delete`, `responsive_preview`, `cohesion_style_guide` and `sitestudio_config_management`.
It has **no routing, services, permissions, drush, or plugin type of its own** — it is all hooks +
config + one class-resolved facade. Part of the **Acquia CMS** distribution; pairs with
[`acquia_cms_common`](../../../acquia_cms_common/3.3.x/agent/start.md).

Requires the proprietary Site Studio (Cohesion) platform (`acquia/cohesion`). Core `^9.5 || ^10 || ^11`.
No settings page (`configure` is null); credentials are entered on the installer form, the Acquia CMS
Tour dashboard, or Cohesion's own account-settings page.

- **Set Site Studio API/agency keys, theme, and what install writes** → [configure/site-studio.md](configure/site-studio.md)
- **The Site Studio package-import mechanism (adding a package for import/rebuild)** → [api/site-studio-packages.md](api/site-studio-packages.md)
- **Hooks it implements: form alters that trigger import, role/permission grants, library alter** → [hooks/integration.md](hooks/integration.md)

Key facts:
- Config object touched: `cohesion.settings` (keys `api_key`, `organization_key`, `api_url`, `use_dx8`,
  `image_browser`, `sidebar_view_style`). This module does **not** own that schema — Cohesion does.
- Credentials read at install from env vars `SITESTUDIO_API_KEY` / `SITESTUDIO_ORG_KEY`, else form input.
- Facade class (class-resolved, `@internal`): `Drupal\acquia_cms_site_studio\Facade\CohesionFacade`
  → `importSiteStudioPackages()`, `buildPackageList()`, `readPackageList()`.
- Package manifest: `config/site_studio/site_studio.packages.yml`; per-module packages under
  `config/pack_acquia_cms_*`; imported via `cohesion_sync.package_import_handler`.
- Installer form id `acquia_cms_site_studio_site_installer_form`; Tour plugin `SiteStudioCoreForm`
  (`@AcquiaCmsTour` id `cohesion`, form id `acquia_cms_site_studio_core_form`).
- Ships the `developer` role (`config/install/user.role.developer.yml`) and grants Cohesion
  component/helper permissions to `content_administrator`/`content_editor`/`content_author`/`site_builder`.
- Optional config: `editor.editor.cohesion`, `filter.format.cohesion`, plus block placements.
