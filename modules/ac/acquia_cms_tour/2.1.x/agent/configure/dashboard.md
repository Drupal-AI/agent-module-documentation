<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CMS Dashboard & configuration wizard

acquia_cms_tour has **no settings form of its own**. Instead it renders a dashboard that embeds the
config forms of *other* modules and writes into *their* config objects. There is no `config/`
schema shipped by this module.

## Routes

| Route | Path | Handler | Permission |
|---|---|---|---|
| `acquia_cms_tour.enabled_modules` | `/admin/tour/dashboard` | `DashboardController::content` | `access acquia cms tour dashboard` |
| `acquia_cms_tour.welcome_modal_form` | `/admin/tour/dashboard/welcome-modal-form` | `WelcomeModalController::openWelcomeModalForm` (AJAX modal) | `access acquia cms tour dashboard` |
| `acquia_cms_tour.starter_kit_welcome_modal_form` | `/admin/tour/dashboard/starter-kit-modal-form` | `WelcomeModalController::openStarterModalForm` (AJAX modal) | `access acquia cms tour dashboard` |
| `acquia_cms_tour.installation_wizard` | `/acquia-cms-tour/installation-wizard` | `Form\InstallationWizardForm` (multistep) | `access content` |
| `acquia_cms_tour.selection_wizard` | `/acquia-cms-tour/starter-kit-selection-wizard` | `Form\StarterKitSelectionWizardForm` (multistep) | `access content` |

Toolbar link `acquia_cms_tour.tour` ("Acquia CMS Wizard") points at the dashboard; `.module`'s
`hook_menu_links_discovered_alter` also repoints core's `help.main` link to the dashboard.

## How the dashboard is built (`DashboardController::content`)

`final class DashboardController` (`@internal`) is injected with `state`, `class_resolver`,
`request_stack`, `plugin.manager.acquia_cms_tour`, and `acquia_cms_tour.starter_kit`. For every
`@AcquiaCmsTour` plugin definition it:

1. Resolves the plugin class via `class_resolver->getInstanceFromDefinition($definition['class'])`.
2. Skips it unless `isModuleEnabled()` (the card's target module is installed).
3. Renders the plugin as a form: `$this->formBuilder()->getForm($plugin_class)` (each card *is* a
   `FormInterface`).
4. Counts it toward the checklist total, and toward "completed" if `getConfigurationState()` is TRUE.

The page theme is `acquia_cms_tour_checklist_form`; the JS library
`acquia_cms_tour/acquia_cms_tour_dashboard` drives the welcome/starter-kit modals off `drupalSettings`
flags (`show_wizard_modal`, `wizard_completed`, `selected_starter_kit`, …).

## The configuration "cards" and what each stores

The built-in `@AcquiaCmsTour` cards all extend `Form\AcquiaCmsDashboardBase` (a `ConfigFormBase`).
Each has a **Save** button and an **Ignore** button (`::ignoreConfig`, which just marks the card done
without saving). Values are written straight into the target module's config:

| Card (plugin id / class) | Target module | Fields | Config written |
|---|---|---|---|
| `geocoder` — `GoogleMapsApiForm` | `geocoder` | Maps API key | `cohesion.settings:google_map_api_key`, **and** the `geocoder_provider` config entity `googlemaps` → `configuration.apiKey` |
| `recaptcha` — `RecaptchaForm` | `recaptcha` | Site key, Secret key | `recaptcha.settings:site_key`, `recaptcha.settings:secret_key` |
| `google_tag` — `GoogleTagManagerForm` | `google_tag` | Snippet parent URI | `google_tag.settings:uri` |

A card only appears when its target module is enabled. Ordering on the page/wizard follows the
plugin `weight` (geocoder 2, google_tag 5, recaptcha 6).

### "Configured" state

`AcquiaCmsDashboardBase` tracks completion in Drupal **state**, not config: key
`acms_<module>_configured` (e.g. `acms_recaptcha_configured`). `getConfigurationState()` returns the
stored flag, or lazily sets it TRUE if `checkMinConfiguration()` (subclass-defined) finds the target
config already populated. `acquia_cms_tour_modules_uninstalled()` deletes `acms_<module>_configured`
when a module is uninstalled.

## Setting the same values without the UI

The dashboard is just a front-end for other modules' config — set them directly:

```php
// reCAPTCHA keys (same as the dashboard "Recaptcha" card).
\Drupal::configFactory()->getEditable('recaptcha.settings')
  ->set('site_key', 'SITE_KEY')
  ->set('secret_key', 'SECRET_KEY')
  ->save();

// Google Tag Manager snippet URI.
\Drupal::configFactory()->getEditable('google_tag.settings')
  ->set('uri', 'public:/')
  ->save();

// Google Maps key (Site Studio + Geocoder provider).
\Drupal::configFactory()->getEditable('cohesion.settings')
  ->set('google_map_api_key', 'MAPS_KEY')->save();
```

Drush equivalents: `drush config:set recaptcha.settings site_key SITE_KEY -y`, etc. To mark a card
done manually: `drush state:set acms_recaptcha_configured 1`.

## The two multistep wizards

Both wizard forms are generic multistep drivers (`FormBase`) that iterate plugin definitions and, at
each step, call the current plugin's `buildForm()` / `submitForm()`:

- `InstallationWizardForm` (route `installation_wizard`) walks the enabled `@AcquiaCmsTour` cards
  (Save / Skip / Next), persisting the current step in state key `current_wizard_step` and setting
  `wizard_completed` at the end. Completing it writes the same config objects listed above.
- `StarterKitSelectionWizardForm` (route `selection_wizard`) walks the `@AcquiaCmsStarterKit` plugins
  and ends by installing a starter kit — see [plugins/starter-kit.md](../plugins/starter-kit.md).

The welcome/starter modals (`WelcomeModalController`) are AJAX `OpenModalDialogCommand` wrappers that
embed these wizard forms; `WelcomeModalForm` only toggles the `show_welcome_modal` / `show_wizard_modal`
state flags and redirects back to the dashboard.
