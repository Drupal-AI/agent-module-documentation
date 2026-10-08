<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Affiliated is a framework for tracking affiliate referrals and attributing clicks, campaigns and conversions to affiliate user accounts.

---

Affiliated turns any Drupal user with the "act as an affiliate" permission into an affiliate whose personalized links can be tracked. A small JavaScript behaviour reads an affiliate code from the URL (default `?affiliate=CODE`, with an optional `affiliate_campaign=CODE`), POSTs it to `/affiliated/track`, and the module stores the affiliate and campaign in cookies for a configurable lifetime. When a cookied visitor later completes a trackable action, an `affiliate_conversion` entity is created and attributed to the affiliate, optionally carrying a commission amount and currency. It provides three entities (`affiliate_campaign`, `affiliate_click`, `affiliate_conversion` with configurable conversion-type bundles), a per-user Affiliate Center dashboard at `/user/{uid}/affiliate` with reporting Views scoped to the viewing affiliate's own records, an `AffiliateManager` service, tokens for conversion labels, and events/hooks so implementers can plug in their own commission rules, validation and reporting. Three submodules attribute conversions to Commerce orders, new user registrations and Webform submissions. Configure it at `/admin/config/affiliate/settings` and define conversion types at `/admin/structure/affiliate/conversion/types`.

---

- Run an affiliate or referral program where trusted users earn credit for traffic and conversions they drive.
- Give each affiliate a personalized link (their user id or username as the affiliate code) that cookies referred visitors.
- Track affiliate link clicks as `affiliate_click` entities, recording campaign, hostname/IP, referrer and destination.
- Let affiliates organize their links into named campaigns and see which campaigns perform best.
- Support global campaigns (usable by any affiliate) alongside per-affiliate private campaigns, with a site default campaign.
- Give each affiliate a self-service dashboard at `/user/{uid}/affiliate` to copy their link and view their own stats.
- Define multiple conversion types (bundles), each with its own default commission, approval default and label pattern.
- Require manual approval for conversions before they count toward payouts, using per-conversion Approve/Cancel forms.
- Attribute Commerce orders to affiliates and create per-order or per-order-item commission conversions on order completion.
- Calculate Commerce commissions as a flat amount or a percentage of the order/order-item total.
- Attribute new user registrations to the affiliate who referred the signup.
- Attribute Webform submissions on selected forms to the referring affiliate, with a configurable per-submission value.
- Choose whether affiliate codes in URLs are user ids or usernames.
- Control what happens when a visitor with an existing cookie clicks a new affiliate link (overwrite vs. keep first).
- Exclude selected roles (e.g. staff, admins) from being tracked.
- Restrict tracking to specific paths, or track everywhere except an admin/edit path list.
- Optionally disable click-entity storage to reduce database growth while still tracking conversions via the cookie.
- Automatically prune old click entities during cron based on a retention window (in hours).
- Reject or credit self-referrals (affiliates acting on their own links) via a configuration toggle.
- Use tokens like `[affiliate_conversion:parent]` to auto-generate conversion labels from the converting entity.
- Extend attribution and commission logic through the `AffiliateManager` service, lookup events, and a pre-create conversion event.
- Build custom reporting Views on the click and conversion base tables for administrators and affiliates.
