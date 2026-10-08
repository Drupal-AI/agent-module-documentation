<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_referral — architecture & API

## Entities

| Entity | Kind | Notes |
|---|---|---|
| `commerce_referral` | content | Base table `commerce_referral`. Bundle `type` → `commerce_referral_type`. Base fields: `referrer_user` (req), `referee_user` (opt), `referral_coupon` (req), `kickback_coupon` (opt), `created`, `changed`. Admin CRUD under `/admin/commerce/referral/*`, `admin_permission: administer referral entities`. Route provider `ReferralRouteProvider` (custom add-page). |
| `commerce_referral_type` | config | `config_prefix: commerce_referral_type`. Exported: `id`, `label`, `referral_promotion`, `kickback_promotion`, `conditions`, `condition_operator`. Getters `getReferralPromotionId()`, `getKickbackPromotionId()`, `getConditions()` (instantiates commerce condition plugins, sets parent entity), `getConditionOperator()`. `admin_permission: administer referral types`. |

## Service: `commerce_referral.referral_manager` (`ReferralManager`)
Deps: `entity_type.manager`, `commerce_promotion.coupon_code_generator`, `config.factory`, `cache.default`.

- `ensureReferral(UserInterface $user): ?Referral` — returns the user's referral for the default type,
  creating the referral coupon + `Referral` entity if missing and the user passes the type conditions.
  Returns NULL if no type/promotion configured or conditions fail. Result cached (`by_user:<uid>:<type>`,
  1h; NULL cached 5m).
- `createCoupon(PromotionInterface $promotion, string $prefix = ''): CouponInterface` — mints an
  ALPHANUMERIC coupon via `CouponCodePattern` (length = `coupon_code_length`, default 10; prefix
  `"$prefix-"`), `usage_limit=1`, `usage_limit_customer=1`, `status=TRUE`, then `addCoupon()` to the promotion.
- `awardKickback(Referral $referral, UserInterface $referrer): CouponInterface` — mints a kickback coupon on
  the type's `kickback_promotion`, stores it on the referral, invalidates caches. Throws if promotion missing.
- `loadReferralByCouponId($id)`, `loadKickbackReferralByCouponId($id)` — reverse lookups, cached (`by_coupon:`,
  `by_kickback:`, 1h). `getDefaultReferralType()` — configured default, else first available.
- Reward value is entirely the promotion's offer; prefixes may expand a `{uid}` placeholder (legacy; defaults
  omit it).

Cache tag `commerce_referral` on all entries; `invalidateReferralCache()` deletes the by_user/by_coupon/
by_kickback keys on award.

## Event subscriber: `OrderSubscriber`
Subscribes to **both** `commerce_order.place.post_transition` and `commerce_order.paid.post_transition`;
`onOrderTransition()` returns unless the transition id equals config `kickback_event` (default `place`). For
each coupon on the order it finds the matching referral, skips if the customer *is* the referrer
(self-use double-check), sets `referee_user` if unset, skips if `kickback_coupon` already awarded (award-once),
else calls `awardKickback()` and logs. Failures are caught and logged to channel `commerce_referral`.

## Validation constraint: `ReferralCoupon`
Attached to `commerce_order.coupons` in `commerce_referral_entity_base_field_info_alter()`.
`ReferralCouponConstraintValidator` runs only while the order state is `draft`:
- if a coupon maps to a referral and the customer uid == referrer uid → violation (no self-use of own code);
- if a coupon is a kickback coupon → violation unless the customer uid == the mapped referrer uid.

## Condition plugin: `UserHasCompletedOrder`
`@CommerceCondition id=commerce_referral_user_has_completed_order`, `entity_type = user`. Config
`minimum_orders` (default 1), `order_state` (`completed`|`fulfillment`). `evaluate()` counts the user's
orders in that state (entity query, `accessCheck()`); anonymous → FALSE; exceptions → FALSE. Used in a
referral type's `conditions` to gate who may generate a referral code.

## Controllers / templates
- `ReferralController::myReferral` — anonymous → redirect to `user.login`; else renders
  `commerce_referral_my_referral` (twig) with the referral code and (if awarded) kickback code.
- `ReferralReportController::report` — aggregate stats (total/awarded/pending) + last 50 rows via the DB API;
  renders `commerce_referral_report`.
- `ReferralAddController::addPage` / `ReferralRouteProvider` — bundle-aware add page for the referral entity.

## Install / update
`commerce_referral_update_9001()` backfills `conditions` (= `[]`) and `condition_operator` (= `AND`) on any
pre-existing referral type config. No schema/table changes.
