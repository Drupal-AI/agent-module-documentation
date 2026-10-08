<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic GovUK Cookie Control (civic_govuk_cookiecontrol) — agent index

Submodule of **civiccookiecontrol**. Renders a **GOV.UK Design System** styled cookie banner block
for public-facing UK government / DWP services, as an alternative front end to the Civic hosted
widget. PHP **8.0**, core `^9.3 || ^10 || ^11`.

Dependencies (`civic_govuk_cookiecontrol.info.yml`): `drupal:civiccookiecontrol`, `drupal:language`,
`drupal:config_translation`. Config UI `civic_govuk_cookiecontrol.admin_overview`.

Provides:
- **Blocks** (`src/Plugin/Block/`): `govuk_cookiecontrol_banner_block`
  (`CivicGovUkCookieControlBannerBlock`) and a details block
  (`CivicGovUkCookieControlDetailsBlock`). The banner block has a `fixed_top` setting and renders
  the `civic_govuk_cookiecontrol_banner` theme (`templates/block--civic-govuk-cookiecontrol-banner.html.twig`).
- **Config object** `civic_govuk_cookiecontrol.settings` (`config/install/…settings.yml`) — banner
  text strings (accepted/rejected cookies, change-settings prefix/link/suffix, hide button, etc.).
  Names in `src/GovUKConfigNames.php` (extends the parent `CCCConfigNames`, adds `GOVUKSETTINGS`).
- **Settings form** `CivicGovUkCookieControlSettings` (`src/Form/`), route
  `/admin/config/system/cookiecontrol/govuk`, gated by `_permission: administer civiccookiecontrol`
  (the parent module's permission — this submodule defines no permissions of its own).
- **Front-end assets** `assets/js/banner.js`, `assets/js/details.js`, `assets/css/style.css`
  (`civic_govuk_cookiecontrol.libraries.yml`).

The banner block (`build()` / `loadCookieTextsInRenderArray()`) reads the parent
`civiccookiecontrol.settings` (title, intro, statement descr, accept/reject labels,
`civiccookiecontrol_privacynode`) and its own `civic_govuk_cookiecontrol.settings`. For non-English
languages it loads the matching `altlanguage` entity and resolves locale strings via
`locale.storage`. Privacy links are built with `Link::createFromRoute('entity.node.canonical', …)`;
translated strings render through `#plain_text`. Template values are Twig-auto-escaped.

Solution docs: [blocks/banner.md](blocks/banner.md)

Parent module: [../../../4.6.x/agent/start.md](../../../4.6.x/agent/start.md)
