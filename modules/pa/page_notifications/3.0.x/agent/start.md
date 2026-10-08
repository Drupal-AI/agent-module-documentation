<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Notifications — agent index

Anonymous/authenticated visitors subscribe by email to a node (or term) and get notified on
updates. Subscriptions are stored as `page_notify_subscriptions` nodes keyed by tokens. Depends on `node`.

Quick facts:
- Subscribe: `PageNotificationsBlock` / `PageNotificationsBlockForm`.
- Self-service (anon, `access content`, token in path): confirmation, `verify-list/{subscription_token}`, `my-subscriptions/{subscription_token}`, `my-list/{user_token}`, `unsubscribe/{subscription_token}`, ajax `cancel_subscription/{token}` and `cancel_all/{user_token}`.
- Admin: `/admin/page-notifications/*` (settings `page_notifications.tabs`, messages, migration, subscription lists) behind `access protected page notifications` (restricted) + `view page notifications reports`.
- Tokens: subscription token = 10 alnum chars; **user token = 6 numeric digits via `rand()`** — the `my-list`/`cancel_all` routes act on that token alone (enumerable). See findings.
