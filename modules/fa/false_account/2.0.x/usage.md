<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
False Account detects users who create multiple ("false") accounts from the same browser and lets administrators review, whitelist or block them.

On each non-admin login the module drops a long-lived `fad` cookie containing a generated correlation id (`cid`) and records a `false_account` entity linking that `cid` to the user id. When the same browser logs into further accounts, the shared `cid` groups them; if three or more accounts share a cookie (or an entry is marked blocked), the just-logged-in account is blocked with a warning. `hook_cron` prunes records older than a year. Administrators review grouped accounts through five bundled Views (default, blocked, whitelisted, search, per-user block) whose queries are altered (`hook_views_query_alter`) to hide unique — i.e. non-duplicate — `cid`s; `views_aggregator` powers the grouping. User 1 and holders of `administer false account` are exempt from tracking.

Both routes require the `administer false account` permission (restrict access): the settings form at `/admin/user/false_account/settings` and a status-change action at `/admin/user/false_account/op/{new_status}/{cid}` that activates (0), whitelists (1) or blocks (2) every account in a group. The tracking mechanism is client-side — a visitor who clears the `fad` cookie is not correlated; treat it as a deterrent, not an authorization control. Typical setup: install `views_aggregator`, enable the module, then monitor the False Account Detector reports under People.
---
False Account correlates accounts sharing one browser via a cookie and can auto-block suspected multi-account (false) users.
---
- Install the `views_aggregator` dependency, then enable the module.
- Configure the redirect target at `/admin/user/false_account/settings`.
- Review flagged account groups under People → False Account Detector.
- View all correlated accounts on the Default report tab.
- View only blocked account groups on the Blocked tab.
- View whitelisted (trusted) groups on the Whitelisted tab.
- Search correlated accounts by user on the Search tab.
- Whitelist a group so its members are never auto-blocked (status 1).
- Block a whole group of suspected false accounts (status 2).
- Re-activate a group back to the default state (status 0).
- See a per-user "False Account" panel on a user's profile (admins only).
- Let the module auto-block the 3rd+ account sharing one browser at login.
- Exempt trusted staff by granting them `administer false account`.
- Rely on cron to purge correlation records older than one year.
- Grant `administer false account` only to trusted moderators.
- Identify sockpuppet clusters before a vote or campaign.
- Reduce spam-account abuse on open-registration sites.
- Reset a mistakenly blocked group via the status action.
- Combine with CAPTCHA/registration controls for defence in depth.
- Understand it is evadable (cookie is client-side) and not an auth control.
