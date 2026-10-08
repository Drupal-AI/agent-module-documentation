<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic Cookie Control (civicccookiecontrol) — agent index

Front end to **Civic UK's Cookie Control** consent widget. It stores the widget config in Drupal,
builds a JSON config object and injects it into every page as `drupalSettings.civiccookiecontrol`,
then loads Civic's external CDN script which reads that object and renders the consent banner.
Supports GDPR + CCPA modes and IAB TCF v1/v2. Requires a **Civic API/license key** (obtain from
civicuk.com). Version **4.6.1**. Core `^9.3 || ^10 || ^11`, PHP 8.0.

- Project (drupal.org): `civicccookiecontrol` — **module machine name: `civiccookiecontrol`** (one `c` in
  `civicc…` is dropped inside the code; all routes, config, services use `civiccookiecontrol`).
- `configure` route: `cookiecontrol.admin_overview` → `/admin/config/system/cookiecontrol`.
- Permission: `administer civiccookiecontrol` (gates every form/entity here). No Drush commands.
- Submodule: `civic_govuk_cookiecontrol` (GOV.UK / DWP styled banner + detail blocks) — see
  `../../modules/civic_govuk_cookiecontrol/4.6.x/agent/start.md`.

Solution docs:
- **Settings form, config objects, API key, GDPR/CCPA/IAB, how the widget JS is embedded** →
  [configure/settings.md](configure/settings.md)
- **The four config entities (cookie categories, necessary cookies, excluded countries, alt languages)** →
  [configure/entities.md](configure/entities.md)
- **Permission + the custom access checks** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config objects (schema in `config/schema/civiccookiecontrol.schema.yml`):
  `civiccookiecontrol.settings` (~130 keys, all prefixed `civiccookiecontrol_`), `civiccookiecontrol.iab`
  (IAB TCF v1), `civiccookiecontrol.iab2` (IAB TCF v2). Constants in `CCCConfigNames`.
- Config entity types: `cookiecategory`, `necessarycookie`, `excludedcountry`, `altlanguage` (all
  `admin_permission: administer civiccookiecontrol`).
- Services: `civiccookiecontrol.CCC8Config` / `.CCC9Config` (build the widget JSON; picked by
  `CCCConfigFactory::getCccConfig($version)`), `civiccookiecontrol.CCCStepsManager` (multi-step settings
  form), access-check services `.IAB1Access` / `.IAB2Access` / `.IAB2EnabledAccess`.
- Libraries: external CDN scripts `cc.cdn.civiccomputing.com/{8,9}/cookieControl-{8,9}.x.min.js`, plus local
  `js/cookieControlSettings.js` which parses the JSON and calls `CookieControl.load(config)`.
- Runtime hooks (`civiccookiecontrol.module`): `hook_page_attachments` injects the config + library;
  `hook_js_alter` marks the CDN script no-cache; `hook_link_alter` makes entity "add" links open in a dialog.
