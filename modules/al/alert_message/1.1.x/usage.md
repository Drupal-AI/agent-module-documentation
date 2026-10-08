<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alert message shows dismissable site-wide banners as content entities: each alert has a label, a formatted body, optional role/user targeting and a publish/unpublish window, and is rendered by one Block plugin you place in a region.

---

The mechanism is worth knowing precisely because it explains every quirk. An alert is an `alert_message` **content entity** — label, `text_long` message (rendered through its text format, so HTML is filtered by the format the author picks), unlimited targeted users, unlimited targeted roles, a required `publish_date`, a required `unpublish_date`, plus two booleans the module manages for you (`status` = currently live, `to_publish` = waiting to go live). You never toggle `status` by hand: `preSave()` computes it from the date window on every save, and a validation constraint refuses an unpublish date that is in the past or at/before the publish date. Rendering is a single **Block plugin** (`alert_message`) that you must place in a region (`/admin/structure/block`) — nothing appears until you do. That block returns only a `#lazy_builder` placeholder; the real work is in `AlertMessageLazyBuilder::build()`, which loads every alert with `status = TRUE`, drops any whose targeted-role set doesn't intersect the current user's roles, drops any whose targeted-user set doesn't include the current uid (empty targeting = everyone), and renders the survivors through the entity view builder. **Dismissal is client-side and per-browser-session**: `js/alert_message_read.js` pushes the clicked alert's id into an `alertMessageClosed` cookie (a JSON array, `path=/`) and removes the DOM node; on the next request `template_preprocess_alert_message()` reads that cookie and skips any listed id. Caching is the subtle part and is deliberate: the block carries cache tag `alert_message_list` and cache contexts `cookies:alertMessageClosed` + `user` + `user.roles`, and a `page_cache_request_policy` service (`AlertMessageDismissedRequestPolicy`) returns `DENY` for the Internal Page Cache whenever the dismiss cookie is present, so once a visitor dismisses anything the Dynamic Page Cache takes over per-cookie — which is how the project keeps the banner working behind Varnish without Cumulative Layout Shift. **Scheduling is cron-driven**, so an alert set to appear at 09:00 actually appears at the next cron run after 09:00, not at 09:00 — fine for planned notices, too coarse for a genuine emergency, where you should set the publish date to now (or the past) so the very first save flips `status` immediately. Access to create/edit alerts runs on the Entity API contrib module's granular permissions (`create alert_message`, `update any/own alert_message`, etc.) plus the module's own `administer alert message`. The two Twig templates ship with crude inline styles and are meant to be overridden in your theme.

---

- Show a site-wide service-outage banner to every visitor.
- Post a scheduled maintenance-window notice that publishes and retires itself.
- Target an alert at only the `editor` and `author` roles.
- Target an alert at a specific named user (or handful of users).
- Prepare an announcement in advance and let cron publish it at its start date.
- Auto-retire a banner at its unpublish date so it never outlives its cause.
- Let each visitor dismiss a banner for the rest of their browser session.
- Run multiple concurrent alerts stacked in one region.
- Announce a weather / campus / office closure.
- Post an emergency notice (set publish date to now so it shows on the next save, not next cron).
- Warn signed-in staff about a phishing campaign via role targeting.
- Show a deadline or term-start reminder scheduled weeks ahead.
- Display a policy-change or terms-update notice for a fixed window.
- Announce a planned site migration or downtime.
- Keep the banner working behind Varnish without layout shift (Dynamic Page Cache per dismiss cookie).
- Provide a translatable banner (the entity is translatable via Content Translation).
- Override `alert-message.html.twig` to restyle the banner and close button in your theme.
- Restrict who can author alerts using the Entity API per-entity create/update/delete permissions.
- Let a user cancel/anonymize/delete their own authored alerts on account cancellation (handled automatically).
- Show a "new service available" promo banner to anonymous visitors only-ish via role targeting.
- List, edit and delete all alerts from the admin collection at `/admin/content/alert-message`.
- Hide non-essential fields from the rendered alert via the entity view display.
