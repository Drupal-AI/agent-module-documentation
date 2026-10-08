<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_common — agent index

Shared foundation of the **Acquia CMS** distribution (rebranded "Acquia Drupal Starter Kit"). It ships
the family's editorial config (content roles, an editorial workflow, text formats, media/node view modes,
taxonomy, sitemap/metatag/pathauto defaults), programmatically builds the `content_*` / `*_administrator`
roles as content-type submodules install, exposes **facades** that wire each new node type into Content
Moderation / Metatag / Simple Sitemap via `third_party_settings`, enforces optional HTTPS redirects,
overrides the 403/404 pages, adds ACMS drush tooling, and emits anonymized usage telemetry (logged to
syslog on Acquia environments).

Resolved release: **3.3.13**. Core `^10.2.2 || ^11`. `container_rebuild_required: true`. Heavy dependency
set (see data.json) — this is distribution glue, not a standalone feature. Submodules:
`acquia_cms_development`, `acquia_cms_support`.

No dedicated settings page is declared in info.yml; a small HTTPS toggle form lives at
`/admin/config/system/https` (route `acquia_cms_common.https_config_form`).

- **Set the site settings (HTTPS redirect, login redirect, starter-kit name)** → [configure/settings.md](configure/settings.md)
- **Roles & the `full_html` permission this module creates/grants** → [permissions/permissions.md](permissions/permissions.md)
- **Run the ACMS drush commands (schema, config-reset, toggle modules, starter-kit)** → [drush/commands.md](drush/commands.md)
- **Call the public utility service / toggle service / config importer** → [api/services.md](api/services.md)
- **Wire a content type into workflow/metatag/sitemap; role-presave alter** → [hooks/integration.md](hooks/integration.md)
- **Understand the event subscribers (config-save, HTTPS, telemetry, 403/404)** → [events/subscribers.md](events/subscribers.md)

## Key facts
- Config object: `acquia_cms_common.settings` — keys `user_login_redirection` (bool), `starter_kit_name` (string), `acquia_cms_https` (bool, form-managed, not in schema).
- Settings route: `acquia_cms_common.https_config_form` → `/admin/config/system/https` (perm `administer site configuration`).
- Permission defined: `use text format full_html` (declared with `provider: filter`).
- Services: `acquia_cms_common.utility` (`AcmsUtilityService`), `acquia_cms_common.toggle_modules` (`ToggleModulesService`), `acquia_cms_common.config.importer` (`ConfigImporterService`).
- Drush: `acms:get-schema` (ags), `acms:update-db` (aupdb), `acms:rerun-schema` (ars), `acms:import-site-studio-packages` (aissp), `acms:starter-kit` (askt), `acms:toggle:modules` (atm), `acms:config-reset` (acr); plus a `config:get --generic` alter.
- Node-type `third_party_settings` namespace `acquia_cms_common`: `workflow_id`, `metatag.tag_types`, `sitemap_variant`, `workbench_email_templates`, `subtype.{field,facet}`.
- Invokes alter hook `hook_content_model_role_presave_alter(RoleInterface &$role)`.
- Event subscribers: `ConfigEventsSubscriber` (ConfigEvents::SAVE), `HttpsRedirectSubscriber` (KernelEvents::REQUEST), `AcquiaCmsTelemetry` (KernelEvents::TERMINATE), `RouteSubscriber` (403/404 override).
- Uninstall validator `AcmsModulesUninstallValidator` blocks uninstalling content/media ACMS modules while content exists.
