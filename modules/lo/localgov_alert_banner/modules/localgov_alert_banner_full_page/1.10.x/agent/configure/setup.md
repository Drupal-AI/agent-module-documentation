<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up the Full page Alert Banner

## Install

```bash
composer require drupal/localgov_core   # provides localgov_media
drush en localgov_alert_banner_full_page -y
drush cr
```

Requires the parent `localgov_alert_banner` module and `localgov_core` (for the `localgov_media`
dependency used by the image field).

## What install gives you

A second alert-banner bundle `localgov_full_page` with its own fields and displays
(`config/install/`):

| Config | Purpose |
|---|---|
| `localgov_alert_banner.localgov_alert_banner_type.localgov_full_page` | The full-page bundle |
| `field.field.localgov_alert_banner.localgov_full_page.localgov_alert_banner_body` | Rich-text body |
| `…localgov_alert_banner_image` | Banner image |
| `…link` | Call-to-action link |
| `…type_of_alert` | Severity list (drives ordering, as in the parent) |
| `…visibility` | `condition_field` value |
| `core.entity_form_display.…localgov_full_page.default` | Edit form layout |
| `core.entity_view_display.…localgov_full_page.default` | View display |

## Create a full-page banner

UI: *Content → Alert banners → Add → Full page*. It is an ordinary `localgov_alert_banner` entity
of bundle `localgov_full_page`, so it is published, moderated, ordered and permission-checked
exactly like the inline banner (see the parent module's docs). The block does not need special
configuration — leave the block's *Display types* filter empty to show all bundles, or select
`localgov_full_page`.

## Rendering and JavaScript

- Template: `localgov-alert-banner--localgov-full-page.html.twig` (a `localgov_alert_banner` base
  hook variant).
- `ThemeHooks::preprocessLocalgovAlertBannerFullPage()` sets a unique wrapper id
  (`attributes.id`), passes it to `drupalSettings.localgov_alert_banner_full_page.localgov_full_page_alert_banner_id`,
  and attaches the `full_page_alert_banner` library.
- Library assets: `css/full-page-alert-banner-layout.css`, `css/full-page-alert-banner-theme.css`,
  `js/full-page-alert-banner.js`.

## Theming

Override the layout/theme CSS with a `libraries-override` in your theme's `*.info.yml`, or provide
your own copy of the `localgov-alert-banner--localgov-full-page` template. The parent module's
dismiss/close behaviour still applies via the shared `localgov_alert_banner/alert_banner` library.
