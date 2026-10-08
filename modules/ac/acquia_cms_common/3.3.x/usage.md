<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Common is the shared foundation of the Acquia CMS (Acquia Drupal Starter Kit) distribution: it ships the family's editorial configuration, builds the standard content roles, and provides the facades and hooks every other acquia_cms_* module builds on.

---

Acquia CMS is Acquia's Drupal distribution assembled from small single-purpose modules, and this is its infrastructural core rather than a content type. It installs a large set of contrib and core dependencies (moderation, media, metatag, pathauto, simple_sitemap, seckit, password_policy, workbench_email, acquia_purge and more), ships default editorial config (an editorial workflow, filtered/full HTML text formats, media and node view modes, taxonomy vocabularies, a sidebar menu, sitemap/metatag/pathauto defaults), and programmatically creates the content_administrator, content_author, content_editor, user_administrator and site_builder roles as the content-type submodules install. New node types are wired into Content Moderation, Metatag and Simple Sitemap through `third_party_settings` in the `acquia_cms_common` namespace, consumed by internal facades on node-type insert. It also enforces optional HTTPS redirects, overrides the 403/404 pages, adds ACMS drush tooling for schema and config resets, toggles modules by environment, and emits anonymized usage telemetry on Acquia hosting. Because it assumes the rest of the distribution, treat the Acquia CMS modules as a set adopted together rather than standalone features to cherry-pick. It ships two submodules: acquia_cms_development (developer/testing helper) and acquia_cms_support (a configuration inspector).

---
- Provide the shared Acquia CMS editorial foundation.
- Install the family's default workflow, text formats and view modes.
- Auto-create content_administrator / content_author / content_editor roles.
- Grant the full_html text-format permission to editorial roles.
- Wire a new content type into an editorial workflow via `workflow_id`.
- Enable metatag tag types for a content type via third-party settings.
- Add a content type to a Simple Sitemap variant declaratively.
- Attach Workbench Email templates to a content type.
- Define a sub-type field/facet for a content type's listing page.
- Enforce HTTPS redirects site-wide via `/admin/config/system/https`.
- Redirect privileged users to their dashboard after login.
- Override the site's 403 and 404 pages with branded templates.
- Report installed module schema versions (`drush ags`).
- Re-run a specific update hook (`drush ars <module> <version>`).
- Reset an ACMS module's config back to shipped defaults (`drush acr`).
- Toggle environment-appropriate modules (`drush atm`).
- Show the configured starter-kit name (`drush askt`).
- Import/rebuild Site Studio packages (`drush aissp`).
- Query the enabled acquia_cms_* module list from code.
- Emit anonymized Acquia CMS usage telemetry on Acquia hosting.
- Block uninstalling content/media modules while content still exists.
- Extend ACMS roles via hook_content_model_role_presave_alter().
- Add a search index/label to a field via third-party settings.
- Standardise the editorial admin experience across the distribution.
- Serve as the required base for all other acquia_cms_* modules.
