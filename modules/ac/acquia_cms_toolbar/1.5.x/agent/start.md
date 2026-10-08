<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_toolbar — agent index

Small theming/glue module in the **Acquia CMS** (now "Acquia Drupal Starter Kit") family. It
restyles the core/`admin_toolbar` admin toolbar to match Acquia CMS, adds an "environment
indicator" toolbar tab that colours itself by the detected Acquia hosting environment, and grants
the core `access toolbar` permission to the standard Acquia CMS roles. It ships CSS/JS only — no
services, routes, forms, entities, or settings.

Dependencies (enabled with it): `admin_toolbar:admin_toolbar`, `admin_toolbar:admin_toolbar_tools`.
Composer also pulls `drupal/acquia_cms_common` and `drupal/admin_toolbar:^3.3`.
Core: `^9.4 || ^10 || ^11`.

- **No settings page** — `configure` route is null; nothing to configure.
- Defines **no** permissions.yml, **no** drush commands, **no** plugin types, **no** config schema.

## What it actually does

- **Toolbar hooks & the environment indicator** → [hooks/toolbar.md](hooks/toolbar.md)
- **CSS/JS asset libraries it attaches** → [theme/libraries.md](theme/libraries.md)

## Key facts (real machine names)

- Module deps: `admin_toolbar:admin_toolbar`, `admin_toolbar:admin_toolbar_tools`.
- Composer: `drupal/acquia_cms_common` (`^1.9 || ^2.1 || ^3.1`), `drupal/admin_toolbar` (`^3.3`);
  conflicts with `drupal/acquia_claro` `<1.4`.
- Libraries: `acquia_cms_toolbar/styling` (css/acquia_cms_toolbar.css), `acquia_cms_toolbar/toolbar_styles` (js/acms_toolbar.js).
- Hooks implemented: `hook_preprocess_html`, `hook_preprocess_page`, `hook_toolbar`, `hook_toolbar_alter`, `hook_content_model_role_presave_alter`.
- Toolbar item id: `environment_indicator` (`#weight` 125, links to `<front>`).
- Body classes added: `acquia-cms-toolbar` and `acquia-cms-environment-{local|ide|dev|stage|prod}`.
- Grants core permission `access toolbar` to roles: `content_administrator`, `content_author`, `content_editor`, `developer`, `site_builder`, `user_administrator`.
- Env detection helper: `_acquia_cms_toolbar_get_environment_indicator_color_config()` via `Acquia\DrupalEnvironmentDetector\AcquiaDrupalEnvironmentDetector`.
- Update hook: `acquia_cms_toolbar_update_8001()` (re-grants `access toolbar` to the roles above).
