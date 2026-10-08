<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Referral tracks who referred whom, with referral types, per-user referral links and listings.

---

User Referral provides a user referral system — defining referral types, generating per-user referral links, and tracking which user referred which new account, with listings of referral links and referrers. It suits referral/invite programs where existing users bring in new ones and attribution matters.

It exposes a granular permission set: administer referral types, view any/own referral-link listings, administer any user's listing, change any user's referral, and view any user's referrer — the 'any' and 'change' permissions expose other users' data/attribution, so restrict them to trusted roles. Depends on core `user`, `views`, and `extra_field_plus`; supports Drupal 9, 10, and 11.

---

- Track user referrals.
- Define referral types.
- Generate per-user referral links.
- Record who referred whom.
- List referral links and referrers.
- Support referral/invite programs.
- Gate admin with `administer user referral types`.
- Separate view any/own listing permissions.
- Gate `change any user referral` (sensitive).
- Gate `view referrer of any user`.
- Restrict `any`/`change` to trusted roles.
- Depend on core `user` and `views`.
- Depend on `extra_field_plus`.
- Support Drupal 9, 10, and 11.
- Support attribution.
- Underpin urct
- Manage referral links
- Track referrers
