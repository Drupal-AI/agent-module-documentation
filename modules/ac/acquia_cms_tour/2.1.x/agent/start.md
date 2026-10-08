<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_tour — agent index

Part of the **Acquia CMS** distribution (now "Acquia Drupal Starter Kit"). Provides the **CMS
Dashboard** at `/admin/tour/dashboard`: a checklist/wizard page where an admin fills in third-party
integration settings (Google Maps / Geocoder key, reCAPTCHA keys, Google Tag Manager URI, etc.) for
whichever supported modules are enabled, plus a starter-kit picker that installs a set of
`acquia_cms_*` modules and themes.

- Core: `^9.4 || ^10 || ^11`. Depends on module `acquia_cms_common`; composer also requires
  `drupal/checklistapi`. No `configure:` link in info.yml (reach it via the toolbar "Acquia CMS
  Wizard" / Help link → dashboard route).
- Defines **1 permission**, **2 annotation plugin types**, **no drush**, **no config schema**
  (it writes into *other* modules' config objects, e.g. `recaptcha.settings`).

## What you'd do

- **Open / operate the dashboard, and set the integration keys it collects** → [configure/dashboard.md](configure/dashboard.md)
- **Add a new configuration "card" (plugin) to the dashboard/wizard** → [plugins/tour-cards.md](plugins/tour-cards.md)
- **Add / understand a starter-kit wizard step + the module-installer service** → [plugins/starter-kit.md](plugins/starter-kit.md)
- **Grant access to the dashboard** → [permissions/dashboard.md](permissions/dashboard.md)
- **Hook into plugin discovery / the module's hook implementations** → [hooks/hooks.md](hooks/hooks.md)

## Key facts (real machine names)

- Permission: `access acquia cms tour dashboard`
- Routes: `acquia_cms_tour.enabled_modules` (`/admin/tour/dashboard`),
  `acquia_cms_tour.installation_wizard` (`/acquia-cms-tour/installation-wizard`),
  `acquia_cms_tour.selection_wizard` (`/acquia-cms-tour/starter-kit-selection-wizard`),
  `acquia_cms_tour.welcome_modal_form`, `acquia_cms_tour.starter_kit_welcome_modal_form`
- Plugin managers/services: `plugin.manager.acquia_cms_tour`, `plugin.manager.starter_kit`,
  `acquia_cms_tour.starter_kit` (StarterKitService)
- Plugin types: `@AcquiaCmsTour` (`Plugin/AcquiaCmsTour`, alter hook `acquia_cms_tour_info`),
  `@AcquiaCmsStarterKit` (`Plugin/AcquiaCmsStarterKit`, alter hook `acquia_cms_starter_kit_info`)
- Alter hook for integrators: `hook_acquia_cms_tour_info_alter(&$definitions)`
- Controller: `Drupal\acquia_cms_tour\Controller\DashboardController::content`
- State keys: `acms_<module>_configured` (per-card "done" flag), `acquia_cms.starter_kit`,
  `wizard_completed`, `starter_kit_wizard_completed`, `show_welcome_modal`
