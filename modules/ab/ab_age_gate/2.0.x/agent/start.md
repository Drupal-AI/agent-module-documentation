<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AB Age Gate (ab_age_gate) — agent index

A JavaScript + cookie **age-verification splash overlay** for age-restricted brand sites (built for
AB InBev). An event subscriber attaches a library to every front-end response; when the `agegate`
cookie is absent, `assets/js/age-gate.js` prepends a full-screen overlay asking the visitor to
confirm their age, then sets the cookie. Package **Custom**. Version **2.0.395**. Core `^10 || ^11`.
License GPL-2.0-or-later.

- **Dependencies** (info.yml): `csv_serialization`, `views_data_export`, `rest`, `serialization`
  (composer `require`: `drupal/csv_serialization ^4.0`, `drupal/views_data_export ^1.4`). Front-end
  library `ab_age_gate/age_gate` uses core `jquery`, `drupal`, `js-cookie`, `once`.
- **This is a client-side compliance/UX gate, not access control.** The full page HTML is delivered
  in every response and only visually covered by a JS overlay + cookie.

## What it provides

- **1 config form** `Form\AgeGateSettingsForm` (id `age_gate_admin_settings`) at route
  `ab_age_gate.admin_settings` → `/admin/config/ab_age_gate`, permission `administer site
  configuration`. Writes config object `ab_age_gate.settings`.
- **1 event subscriber** `EventSubscriber\AgeGateSubscriber` (service `ab_age_gate.request.event`,
  on `KernelEvents::RESPONSE` priority 1000) — attaches the library + full config to attachable
  responses, honoring the ignore-pages list and skipping `admin` / `node/add` / `translations/add`.
- **1 service + 3 AJAX routes** for per-day statistics: `AgeGateStatistics` (service
  `ab_age_gate.statistics`) over DB table `ab_age_gate_statistics`, called by
  `Controller\StatisticsController::select|insert|update` at `/ab_age_gate/select|insert|update`.
- **1 statistics View** `custom_ab_agegate_statistics` (config/install) + `hook_views_data` for the
  stats table, plus two menu links (settings + statistics dashboard) and a `hook_form_alter` that
  hides that View's exposed filter form.
- **DB schema** (`hook_schema`): table `ab_age_gate_statistics` (day_id PK, week_id, load, success,
  under18, fail, desktop, mobile). Dropped on uninstall along with the two config objects.
- No permissions of its own, no Drush, **no config schema** (`config/install/` only), no plugin types.

## Solution docs

- **Configuration** — the settings form, config keys, defaults, branding, i18n text, ignore pages,
  age-gate modes → [config/settings.md](config/settings.md)
- **Overlay + statistics runtime** — the event subscriber, JS overlay behavior, cookie, and the
  three statistics endpoints/service/View → [api/overlay-and-statistics.md](api/overlay-and-statistics.md)

## Caveats grounded in source

- `info.yml` declares `configure: ab_age_gate.settings`, but the actual settings route id is
  `ab_age_gate.admin_settings` — the `configure` link target does not match a defined route.
- `AgeGateSettingsForm::buildForm()` contains a **hard-coded absolute path**
  `/var/www/html/web/modules/contrib/ab_age_gate/config/install/ab_age_gate.settings.yml` used to
  seed default language text; on any site not at that path the fallback branch errors.
