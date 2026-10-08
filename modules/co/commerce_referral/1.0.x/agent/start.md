<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_referral — agent start

Refer-a-friend rewards for Drupal Commerce, built entirely on **Commerce promotions + coupons**. Each user
gets a single-use **referral coupon** (on an admin-chosen "referral promotion") to share; when a friend
redeems it at checkout and the order transitions, the referrer is automatically issued a single-use
**kickback coupon** (on the admin-chosen "kickback promotion"). Version **1.0.3**. Depends on `commerce`
and `commerce_promotion`. info.yml core `^10 || ^11`; composer.json requires `drupal/core:^11`,
`drupal/commerce:^3.0`, `php:^8.3`.

## Model
- **`commerce_referral`** — content entity (base table `commerce_referral`), bundle = `commerce_referral_type`.
  Fields: `referrer_user`, `referee_user` (set when redeemed), `referral_coupon`, `kickback_coupon`, `type`,
  `created`/`changed`. One referral per user+type, reused (cached).
- **`commerce_referral_type`** — config bundle. Fields: `referral_promotion`, `kickback_promotion`,
  `conditions` (commerce conditions gating who may generate a code), `condition_operator` (`AND`/`OR`).
- Reward value never comes from the client — it is the offer configured on the referral/kickback **promotion**.
  All coupons are minted `usage_limit=1`, `usage_limit_customer=1`, `status=TRUE` (single-use).

## Flow
1. User visits `/user/referral` (`ReferralController::myReferral`, perm `access own referral code`) →
   `ReferralManager::ensureReferral()` creates (or returns) their referral coupon + `Referral` entity, if
   they pass the type's conditions.
2. Friend applies the referral code as a normal coupon at checkout (Commerce coupon redemption; no capture link).
3. `ReferralCouponConstraintValidator` (attached to `commerce_order.coupons` via
   `hook_entity_base_field_info_alter`) blocks a referrer from using their own referral code and restricts a
   kickback coupon to its mapped referrer.
4. On the configured order transition, `OrderSubscriber` finds the referral by coupon, sets `referee_user`,
   and calls `ReferralManager::awardKickback()` → mints the kickback coupon (once per referral).

## Config & settings
`commerce_referral.settings`: `default_referral_type`, `coupon_code_length` (4–32, default 10),
`referral_prefix_format` (default `REF`), `kickback_prefix_format` (default `KB`), `kickback_event`
(`place` default | `paid`). Prefix supports a legacy `{uid}` placeholder — leave it out; the shipped
defaults are plain and recommended. Prefer `kickback_event: paid` so the reward follows confirmed payment.
Settings form: `/admin/commerce/config/referral/settings`.

## Routes / UI
- `/user/referral` — customer self-service code + kickback (`access own referral code`).
- `/admin/commerce/referral` — Referral entity collection (`administer referral entities`).
- `/admin/commerce/referral/report` — stats report (`administer referral entities`).
- `/admin/commerce/config/referral-types` — Referral type list/add/edit (`administer referral types`).
- `/admin/commerce/config/referral/settings` — global settings (`administer referral settings`).

## Details
- Entities, `ReferralManager` service API, `OrderSubscriber`, the `ReferralCoupon` validator, the
  `UserHasCompletedOrder` condition, caching, and the `commerce_referral_update_9001` hook →
  [architecture.md](architecture.md)

Permissions: `access own referral code`, `administer referral entities`, `administer referral types`,
`administer referral settings` (last three `restrict access: true`). Provides config schema. No Drush, no libraries.
