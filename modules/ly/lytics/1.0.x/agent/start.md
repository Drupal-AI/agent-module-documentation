<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lytics - agent index

Integrates the Lytics CDP. Version **1.0.7** (1.0.x), core `^10`.

- Config form: `/admin/config/system/lytics` (`lytics.settings_form`, perm `manage lytics connection`). Validates + stores an access token in `lytics.settings`, resolving account name/id/domain via `https://api.lytics.io/api/account`.
- Tag injection: `lytics_page_attachments()` adds the Lytics JS tag (`https://c.lytics.io/api/tag/{account_id}/latest(.min).js`) on non-admin routes when `enable_tag` is on; builds Pathfora widget JS inline from published `lytics_widget` content entities.
- Widgets: content entity `lytics_widget` (base table), managed at `/admin/structure/lytics_widgets/manage`; wizard is a `lytics-widgetwiz` custom element.
- Recommendation block: `LyticsContentRecommendationBlock` renders a placeholder hydrated by `js/inlineRecommendation.js`; block form pulls segments/collections/engines from the Lytics API.
- Permissions: manage lytics connection, view lytics connection, view lytics dashboard, manage lytics widgets, manage lytics recommendations.

Security notes: all routes are admin-gated (`manage lytics connection` / `view lytics dashboard`). API calls use Drupal httpClient/curl with default TLS verification (sound). The widget-manager form embeds the API access token in plaintext into the page HTML (`WidgetManagerForm.php` `accesstoken="..."`) - disclosed to users holding `manage lytics connection` and via page source. Token also stored plaintext in config.
