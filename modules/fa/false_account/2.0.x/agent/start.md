<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# False Account (false_account) — agent index

**Correlates user accounts that share one browser via a tracking cookie and can auto-block suspected multi-account ("false") users; admins review via bundled Views.**

- **Version:** 2.0.x
- **Core:** ^10.1 || ^11 · **Depends on:** views_aggregator · **Configure:** `false_account.settings`
- **Mechanism:** `hook_user_login` (`src/Hook/FalseAccountHooks.php`) sets a `fad` cookie + `false_account` entity per (cid,uid); blocks a login when ≥3 accounts share the cid or the group is marked blocked. `hook_cron` prunes records >1yr.
- **Routes (both `administer false account`, restrict access):** settings `/admin/user/false_account/settings`; status change `/admin/user/false_account/op/{new_status}/{cid}` → activate(0)/whitelist(1)/block(2) all accounts in a group.
- **Reports:** Views `false_account_default|blocked|whitelisted|search|block`, filtered by `hook_views_query_alter` to duplicate cids only.
- **Caveat:** the `fad` correlation cookie is client-side, so clearing it evades detection — a deterrent, not an access control.

See [configure/setup.md](configure/setup.md)
