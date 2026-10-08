<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliate registrations (affiliate_registrations) — agent index

Submodule of **affiliated**. Attributes new user registrations to affiliates. Package **Affiliated**.
Core `^10 || ^11`. Depends on `affiliated:affiliated`. Version **1.0.0-alpha3** (dir 1.0.x). No own
permissions, config schema, services, routes or plugin types — just one hook and one config entity.

## What it provides

- `affiliate_registrations_user_insert(UserInterface $user)` (`hook_user_insert`): only when
  `currentUser()->isAnonymous()` (a real self-registration, not an admin-created account), reads
  `AffiliateManager::getStoredAccount()`; if an affiliate cookie resolves to a valid affiliate, it
  creates a `user_registration` `affiliate_conversion` (`affiliate` = that affiliate, `campaign` =
  stored campaign or NULL), calls `setParentEntity($user)` and `save()`.
- Install config `affiliated.affiliate_conversion_type.user_registration` (the `user_registration`
  conversion type; `default_commission: null`, label pattern
  `(User [affiliate_conversion:parent:target_id]) [affiliate_conversion:parent]`).

Commission amount, approval default and campaign-ownership validation are handled by the base
`affiliate_conversion` entity's `preCreate`/`preSave` (see the parent module docs). See
[api/registrations.md](api/registrations.md).
