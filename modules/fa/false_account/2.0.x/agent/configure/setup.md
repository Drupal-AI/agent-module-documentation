<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operating False Account

## How detection works
- On every login by a non-admin, non-user-1 account, `hook_user_login`:
  - If no `fad` cookie: generates a correlation id `cid` (`md5('gsmi789'.uniqid(mt_rand(), TRUE))`), sets the year-long `fad` cookie as `cid,uid`, and creates a `false_account` entity `{cid, uid, created, status:0}`.
  - If a `fad` cookie exists: appends the new uid to the cookie and a new `false_account` row under the same `cid`. If the group's status is `2` (blocked) or **≥3 accounts** share the `cid`, the account is blocked and a warning shown.
- `hook_cron` deletes correlation rows older than one year.

## Reviewing and acting
Reports live under People → **False Account Detector** (`view.false_account_default.page_1`) with tabs Default / Blocked / Whitelisted / Search. `hook_views_query_alter` hides `cid`s that are unique (only duplicates are suspicious); grouping/counting is done with `views_aggregator`.

Status actions hit `/admin/user/false_account/op/{new_status}/{cid}`:
| new_status | effect |
|---|---|
| 0 | activate all accounts in the group (default) |
| 1 | whitelist (activate + mark trusted) |
| 2 | block all accounts in the group |

Both this action and the settings form require the `administer false account` permission (restrict access = true). Holders of that permission and user 1 are never tracked.

## Caveats
- Detection is **client-side and evadable**: a user who clears or edits the `fad` cookie (or blocks cookies) is not correlated. Use it as a spam deterrent alongside CAPTCHA/registration controls, not as an authorization mechanism.
