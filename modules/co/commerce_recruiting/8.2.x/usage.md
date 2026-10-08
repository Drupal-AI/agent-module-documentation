<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Recruiting provides recruitment marketing for commerce, letting recruiters share codes/links that credit them for resulting purchases.

---

Commerce Recruiting provides referral/recruitment marketing for Drupal Commerce — letting "recruiters"
(customers/affiliates) share recruitment codes/links so that purchases made by recruited buyers are credited
(e.g. for a reward/bonus). It depends on Commerce Cart, in the Commerce package.

Use it for referral/affiliate-style recruiting on a Commerce store. It is an e-commerce/marketing feature.
By design the recruiting codes are unguessable (CSPRNG-generated and unique), bonuses are computed
server-side from the campaign-option configuration and re-resolved when the order is placed, self-referral
is blocked unless a campaign explicitly opts in, rewards are scoped to the owning recruiter, and a
recruitment is only accepted once its order reaches the completed state. It has no access-control role.
Configure the recruiting campaigns and rewards.

---

- Provide referral/recruitment marketing.
- Share recruitment codes/links.
- Credit recruiters for purchases.
- Depend on Commerce Cart.
- Reward recruited purchases.
- Generate unguessable, unique referral codes (CSPRNG).
- Compute bonuses server-side from campaign config.
- Accept recruitments only after the order completes.
- Block self-referral unless a campaign opts in.
- Scope rewards to the owning recruiter.
- Have no access-control role.
- Configure recruiting campaigns.
- Handle referrals.
- Attribute purchases.
- Configure rewards.
- Handle recruiting.
- Track referrals.
- Configure the codes.
- Reward recruiters.
- Handle affiliate recruiting.
- Configure campaigns.
- Recruit customers.
