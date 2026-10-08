<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sitewide Alert displays dismissible alert/announcement banners at the top of every page of a Drupal site. Each alert is a `sitewide_alert` content entity, so alerts are created, scheduled, styled, and page-targeted through normal entity add/edit forms without touching code.

---

The module defines a fieldable, revisionable, translatable `sitewide_alert` content entity whose instances are managed under Admin > Content > "Sitewide alerts". Every alert carries an administrative name, a rich-text message, an "Active" (published) flag, a style (color/severity), a dismissible flag, optional scheduling (a start/end date range), and optional page-visibility rules (`limit_to_pages`, with a negate option). Alerts are loaded on the client by a small JavaScript that polls a JSON endpoint (`/sitewide_alert/load`), so the banner appears on cached pages and updates without a full page reload; a server-side-render option is available for no-JS delivery. Dismissals are stored per browser (localStorage) and do not require login, and an "Ignore dismissals before" timestamp lets an editor force a previously dismissed alert to reappear after a major edit. Global behavior — the list of available styles, whether alerts show on admin pages, refresh interval, cache max-age, display order, and optional unread counts — is configured once at `/admin/config/sitewide_alerts`. Drush commands create, delete, enable, and disable alerts from the CLI, which is convenient for scheduled/automated announcements. Two shipped submodules extend delivery: `sitewide_alert_block` renders alerts inside a placeable block instead of forcibly at the top of the page, and the experimental `sitewide_alert_domain` scopes alerts to specific domains via the Domain Access Entity module.

---

- Show a site-wide maintenance-window warning banner across every page.
- Announce an emergency or outage message that visitors can dismiss.
- Schedule a promotional banner to appear and disappear automatically between two dates/times.
- Display a "we are closed for the holidays" notice on a government or business site.
- Warn users about a planned deployment with a countdown-style scheduled alert.
- Publish a legal / compliance notice at the top of all pages.
- Target an alert to only certain pages (e.g. `/checkout/*`) using page-visibility rules.
- Show an alert everywhere *except* a set of pages using the negate option.
- Let visitors permanently dismiss a cookie/GDPR-style notice per browser without logging in.
- Force a dismissed alert to reappear after editing its content ("Ignore dismissals before").
- Style alerts by severity (info / warning / danger) with custom color styles.
- Run several concurrent alerts and control their stacking order (ascending/descending).
- Create and publish an alert entirely from the command line via `drush sitewide-alert:create`.
- Disable all active alerts instantly from CI/CD or a cron job with `drush sitewide-alert:disable`.
- Enable a pre-staged alert at a specific moment with `drush sitewide-alert:enable`.
- Deliver alerts on fully page-cached sites (the banner is injected client-side via a JSON endpoint).
- Serve alerts without JavaScript using the server-side render option.
- Show an unread/updated-alert count badge to returning visitors.
- Provide translated alert messages on multilingual sites (the entity is translatable).
- Render alerts inside a themed region/block instead of pinned to the top of the page (via `sitewide_alert_block`).
- Restrict alerts to specific domains on a multi-domain install (via `sitewide_alert_domain`).
- Keep an audit trail of alert wording changes using the entity's revision history.
- Grant editors permission to manage alerts without giving them full site administration.
- Hide alerts from administrative pages so they only reach front-end visitors.
- Tune performance by adjusting the alert refresh interval and cache max-age.
