<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Notifications lets anonymous (and authenticated) visitors "watch" a page — subscribing by email address to a node (or taxonomy term) so they get an email whenever that content is updated. Subscribers manage their own subscriptions through tokenized links, and admins get subscription reports and migration tools.

---

Subscriptions are stored as nodes of a `page_notify_subscriptions` content type, each carrying a per-subscription token (`field_page_notify_token`) and a per-user token (`field_page_notify_token_user_id`) plus the subscriber email and target node/term id. A block (`PageNotificationsBlock` + `PageNotificationsBlockForm`) provides the subscribe form; confirmation, verification, "my subscriptions", and unsubscribe flows are dynamic/anonymous routes gated by `access content`, keyed by the tokens in the URL. Admin tooling (settings, message templates, subscription lists, and migration forms) lives under `/admin/page-notifications/*` behind the restricted `access protected page notifications` permission (plus `view page notifications reports`). A `RoleAccessCheck` grants access to authenticated users for certain flows. Security note (see agent notes): the per-user token used by the `/page-notifications/my-list/{user_token}` and `/ajax/cancel_all/{user_token}` routes is only a 6-digit numeric value generated with `rand()`, so those anonymous, token-only endpoints are enumerable.

---

- Let visitors subscribe by email to be notified when a specific page changes.
- Offer a "watch this page" block on articles, docs, or policy pages.
- Notify subscribers automatically when a watched node is updated.
- Support subscriptions to taxonomy terms as well as nodes.
- Give subscribers a self-service page to view all the pages they watch.
- Provide one-click unsubscribe links via tokenized URLs in emails.
- Let a subscriber cancel a single subscription or all of them.
- Send a double-opt-in confirmation email before activating a subscription.
- Customize notification/confirmation email templates from the admin UI.
- Restrict admin subscription management with a dedicated restricted permission.
- View per-node and site-wide subscriber lists for reporting.
- Migrate legacy subscriptions or convert nodes to the subscription content type via built-in forms.
- Autocomplete existing subscriptions in the admin UI.
- Allow anonymous participation without requiring account creation.
- Build an email audience of users interested in specific content.
- Keep subscribers informed of changes to long-lived reference pages.
