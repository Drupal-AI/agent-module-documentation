<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Tour provides the CMS Dashboard at `/admin/tour/dashboard` — a checklist/wizard where an admin configures the third-party integrations used across an Acquia CMS site and picks a starter kit that installs a set of `acquia_cms_*` modules and themes.

---

Acquia CMS (recently renamed "Acquia Drupal Starter Kit") is Acquia's Drupal distribution, assembled from many small `acquia_cms_*` modules. This one is the onboarding hub. It defines two annotation plugin types — `@AcquiaCmsTour` (dashboard "cards", one per integration such as Geocoder/Google Maps, reCAPTCHA, Google Tag Manager, Site Studio) and `@AcquiaCmsStarterKit` (steps of the starter-kit selection wizard) — plus a `DashboardController` that gathers the enabled cards into one page, a per-card completion checklist tracked in Drupal state (`acms_<module>_configured`), and a `StarterKitService` that batch-installs a chosen kit's modules and switches the site's themes. Each card writes into its *target* module's config (e.g. `recaptcha.settings`, `google_tag.settings`, `cohesion.settings`), so the module ships no config schema of its own. It depends on `acquia_cms_common` and (via composer) `checklistapi`. It is exactly right on an Acquia CMS site and mostly inert elsewhere — cards appear only for the supported modules that happen to be enabled. Treat the Acquia CMS modules as a set adopted together, not standalone features to cherry-pick.

---
- Guide first-run Acquia CMS setup from one dashboard.
- Configure Google Maps / Geocoder API key.
- Configure reCAPTCHA site and secret keys.
- Configure the Google Tag Manager snippet URI.
- Show a checklist of remaining configuration tasks.
- Track which integrations are already configured.
- Run the multistep installation wizard.
- Pick a starter kit (Enterprise low-code, Community, Headless).
- Batch-install a starter kit's modules and themes.
- Switch default and admin themes as part of a starter kit.
- Add a custom configuration card via `@AcquiaCmsTour`.
- Reorder or replace a dashboard card with `hook_acquia_cms_tour_info_alter`.
- Add a step to the starter-kit wizard via `@AcquiaCmsStarterKit`.
- Centralise contrib-module configuration for site builders.
- Grant editors dashboard access with one permission.
- Redirect the core Help toolbar link to the tour dashboard.
- Detect and list starter-kit modules missing from the codebase.
- Mark a card configured programmatically via state.
- Re-run onboarding on an existing site.
- Onboard a new Acquia CMS site quickly.
- Reduce distribution setup friction.
- Coordinate integration setup steps in order.
