<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Uber Affiliate - agent index

Affiliate/referral **click tracking + payouts** system. Version **2.0.0**, core `^9.2 || ^10`.

- Tracking route built dynamically by `AffiliateRoute::routes()` -> `UberAffiliate::affiliatePage()`; permission `track affiliate clicks for this role`. Records to `affiliate_clicks`, redirects to validated internal destination.
- Admin under `admin/config/people/affiliate/*` (forms: users/content/payouts/payment) - permission `administer affiliate settings`. Config `uber_affiliate.settings`.
- Per-user page `user/{uid}/affiliate` (`view own affiliate info` / admin). Provides 7 permissions.
- Redirect destinations are validated (`path.validator` + not external). Note: final `RedirectResponse('/' . $dest)` can double-slash a valid internal path (functional bug, host not attacker-controlled).