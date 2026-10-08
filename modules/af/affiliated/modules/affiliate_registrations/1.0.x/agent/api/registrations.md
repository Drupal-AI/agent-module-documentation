<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliate registrations — behaviour

Enable with `drush en affiliate_registrations` (pulls in `affiliated`). The install ships the
`user_registration` conversion type; set its default commission / approval on the affiliate
conversion type form at `/admin/structure/affiliate/conversion/types`.

## The only hook (`affiliate_registrations.module`)

`hook_user_insert(UserInterface $user)`:

1. Guard: `\Drupal::currentUser()->isAnonymous()`. At registration time the new user is not yet
   logged in, so the current user is anonymous for genuine self-registration; a non-anonymous current
   user means an admin created the account, which is **not** tracked.
2. `$affiliate = affiliate.manager->getStoredAccount()` — resolves the `affiliate_id` cookie to a
   validated active affiliate (NULL otherwise → nothing happens).
3. Creates an `affiliate_conversion` of type `user_registration` with `affiliate` = affiliate id and
   `campaign` = `getStoredCampaign()?->id()`.
4. `setParentEntity($user)` (stores the new user's entity type + id), then `save()`.

## What the base module supplies

- **Commission**: taken from the `user_registration` type's `default_commission` in
  `AffiliateConversion::preSave()` (NULL by default → no commission unless configured or set by an
  event subscriber).
- **Approval**: the type's `default_status` sets whether the conversion starts published (approved).
- **Campaign safety**: `preSave()` replaces a non-global campaign not owned by the affiliate with the
  default campaign.
- **Label**: auto-built from the type's `label_pattern`
  (`(User [affiliate_conversion:parent:target_id]) [affiliate_conversion:parent]`).

## Config

`config/install/affiliated.affiliate_conversion_type.user_registration.yml` — id `user_registration`,
`default_commission: null`, `label_pattern` as above. No settings form of its own.
