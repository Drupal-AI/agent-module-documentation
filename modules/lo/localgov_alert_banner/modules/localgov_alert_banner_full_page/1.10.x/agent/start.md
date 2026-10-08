<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Full page Alert Banner (localgov_alert_banner_full_page) — agent index

Submodule of **localgov_alert_banner**. Adds a full-screen "takeover" alert banner bundle.
Dependencies: `localgov_alert_banner:localgov_alert_banner`, `localgov_core:localgov_media`, plus
core `block`, `field`, `link`, `node`, `options`, `user`, `views`.

- **Install, bundle, fields, template, JS** → [configure/setup.md](configure/setup.md)
- Parent module → [../../../1.10.x/agent/start.md](../../../1.10.x/agent/start.md)

Key facts:
- Installs a new alert-banner **bundle** `localgov_full_page`
  (`config/install/localgov_alert_banner.localgov_alert_banner_type.localgov_full_page.yml`) with
  fields `localgov_alert_banner_body`, `localgov_alert_banner_image`, `link`, `type_of_alert`,
  `visibility`, plus its own default form and view displays.
- Dedicated template `templates/localgov-alert-banner--localgov-full-page.html.twig` (registered by
  `ThemeHooks::theme()` with `base hook: localgov_alert_banner`).
- `ThemeHooks::preprocessLocalgovAlertBannerFullPage()`
  (`#[Hook('preprocess_localgov_alert_banner__localgov_full_page')]`) assigns a unique wrapper id
  via `Html::getUniqueId('localgov-full-page-alert-banner')`, exposes it as
  `drupalSettings.localgov_alert_banner_full_page.localgov_full_page_alert_banner_id`, and attaches
  the `localgov_alert_banner_full_page/full_page_alert_banner` library.
- Library `full_page_alert_banner` (`*.libraries.yml`): `full-page-alert-banner-layout.css`,
  `full-page-alert-banner-theme.css`, `js/full-page-alert-banner.js`; depends on
  `core/drupalSettings`, `localgov_alert_banner/alert_banner`, `core/once`.
- Legacy procedural `hook_theme()` / `hook_preprocess_*` wrappers in the `.module` delegate to the
  `ThemeHooks` service (`#[LegacyHook]`).
- No own permissions, routes, services (beyond the autowired hook class), config schema or Drush
  commands — it inherits the entity, manager, block, moderation and permissions from the parent.
