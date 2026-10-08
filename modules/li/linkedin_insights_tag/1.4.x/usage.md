<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LinkedIn Insights Tag embeds the LinkedIn Insight Tag JavaScript (and/or its no-script tracking pixel) on your site's pages so LinkedIn can track conversions, retarget visitors and report campaign insights.

---

The module is a small tracking-snippet injector with one settings form
(`/admin/config/system/linkedin-insights`, permission `administer linkedin insights`) storing three
config values: `partner_id` (your LinkedIn Partner ID), `user_role_roles` (which roles the tag loads
for), and `image_only` (force the image pixel only, no JS). `hook_page_attachments()` attaches the
LinkedIn `insight.min.js` library (loaded from `snap.licdn.com`) plus a `drupalSettings` value with the
partner id, but only when the current user has one of the selected roles and `image_only` is off.
`hook_page_bottom()` additionally renders a 1×1 tracking `<img>` pointing at
`https://dc.ads.linkedin.com/collect/?pid=<partner_id>&fmt=gif` (wrapped in `<noscript>` when JS is
enabled), after validating the URL with `UrlHelper::isValid()`. Defaults ship with `user_role_roles:
[anonymous]` and empty `partner_id` (nothing loads until you enter an id). The partner id is emitted via
`drupalSettings` (JSON-encoded) and as an escaped HTML attribute, so it is not injected raw into markup.

---

- Add the LinkedIn Insight Tag to every page for campaign conversion tracking.
- Enable LinkedIn retargeting/website audiences for LinkedIn Ads.
- Restrict the tracking tag to specific user roles (e.g. only anonymous visitors).
- Exclude logged-in/admin roles from tracking by not selecting their roles.
- Serve only the image pixel (no JavaScript) via the "image only" option for stricter setups.
- Fall back to a `<noscript>` 1×1 pixel for visitors without JavaScript.
- Configure the LinkedIn Partner ID through a simple admin form.
- Centralise LinkedIn tracking config in Drupal instead of hand-editing templates.
- Load the official `snap.licdn.com/li.lms-analytics/insight.min.js` library automatically.
- Gate who is tracked behind the `administer linkedin insights` permission.
- Track conversions from Drupal landing pages tied to LinkedIn ad campaigns.
- Measure LinkedIn ad-driven traffic and audience demographics.
- Toggle tracking on/off by clearing the partner id.
- Expose the partner id to custom JS via `drupalSettings.linkedin_insights_tag.partner_id`.
- Combine with role-based visibility to comply with consent/opt-out policies per role.
