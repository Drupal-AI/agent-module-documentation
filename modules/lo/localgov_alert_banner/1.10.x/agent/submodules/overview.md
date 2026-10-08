<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Optional submodules

The project ships two optional submodules (disabled by default). Each has its own documentation
tree.

## Group Alert banner (`group_alert_banner`)

Integrates alert banners with the contrib **Group** module (`group:group`) so a banner can belong
to a group/microsite. Provides a `group_localgov_alert_banner` Group relation plugin (derived
per banner bundle), a `group_alert_banner.services.yml` route subscriber adding
`group/{group}/alert-banner/add` and `.../create` routes, a Group permission
`access localgov_alert_banner overview`, a `group_alert_banners` view, and hook classes for block
placement, entity, form and LocalGov Microsites integration. Requires the `group` contrib module
(a dev/suggested dependency of the parent).

Docs → [../../../modules/group_alert_banner/1.10.x/agent/start.md](../../../modules/group_alert_banner/1.10.x/agent/start.md)

## LocalGov Full page Alert Banner (`localgov_alert_banner_full_page`)

Adds a full-screen takeover banner: a `localgov_full_page` banner bundle with its own fields
(`localgov_alert_banner_body`, `localgov_alert_banner_image`, `link`, `type_of_alert`, `visibility`),
a dedicated template `localgov-alert-banner--localgov-full-page.html.twig`, layout/theme CSS and a
`full-page-alert-banner.js` behaviour. `ThemeHooks::preprocessLocalgovAlertBannerFullPage()` assigns
a unique wrapper id and passes it to JS via `drupalSettings`. Depends on
`localgov_core:localgov_media` (from `drupal/localgov_core`).

Docs → [../../../modules/localgov_alert_banner_full_page/1.10.x/agent/start.md](../../../modules/localgov_alert_banner_full_page/1.10.x/agent/start.md)
