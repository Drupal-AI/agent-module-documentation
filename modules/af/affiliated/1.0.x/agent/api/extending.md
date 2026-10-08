<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliated — service, tracking flow, events, hooks

## Service `affiliate.manager` (`Drupal\affiliated\AffiliateManager`)

Injected: `current_user`, `entity_type.manager`, `request_stack`, `module_handler`,
`config.factory`, `event_dispatcher`. Key methods:

- `isActiveAffiliate(AccountInterface)` — TRUE if the account has `act as an affiliate`; result can
  be overridden by `hook_affiliated_active_affiliate_alter($is_affiliate, $account)`. Statically cached.
- `getAccountFromCode($code)` — resolves a code to a user via `user_load_by_name()` (username mode)
  or numeric id load (user_id mode), dispatches `AffiliateAccountLookupEvent`, then returns the user
  only if `isActiveAffiliate()`.
- `getCodeFromAccount($account)` — inverse; dispatches `AffiliateCodeLookupEvent`.
- `getStoredAffiliateCode()`/`getStoredCampaignCode()` — read the `affiliate_id`/`affiliate_campaign`
  cookies; `getStoredAccount()`/`getStoredCampaign()` resolve them to entities.
- `getDefaultCampaign()` — the global default campaign (`is_global=1, is_default=1`).
- `getCampaignFromCode($code)` — non-numeric ⇒ lookup by published `code`; numeric ⇒ load by id (if
  published); falls back to the default campaign.
- `registerClick($affiliate, $campaign, $destination, $referrer=NULL)` — returns FALSE for a
  self-click when `allow_owner` is off; returns TRUE (cookie set, no entity) when `store_clicks` is
  off; otherwise creates + saves an `affiliate_click` (hostname = client IP).
- `createConversion($type)` — builds an unsaved conversion from the stored cookie affiliate + campaign
  (NULL if no affiliate cookie), applying `validateCampaignForAffiliate()`.
- `validateCampaignForAffiliate($campaign, $affiliate)` — global campaign ⇒ allowed; else must be
  owned by the affiliate, otherwise the default campaign is substituted.

## Tracking flow

1. `hook_page_attachments()` attaches settings + the tracker JS on trackable, non-admin pages.
2. `js/affiliated.track.js` POSTs `{affiliate, campaign, landingPage, referrerUrl}` to
   `/affiliated/track` (route `affiliated.track`, POST, permission `access content`).
3. `Controller\AffiliatedTrackerController::track()`:
   - skips excluded roles; requires a non-empty affiliate code;
   - decides whether to track (first visit, or `overwrite` mode with a changed affiliate/campaign);
   - resolves the affiliate via `getAccountFromCode()` (must be an active affiliate) and the campaign
     via `getCampaignFromCode()` (a non-global campaign not owned by the affiliate is replaced with
     the default);
   - `registerClick()`; on success sets `affiliate_id` + `affiliate_campaign` cookies (lifetime from
     `cookie_lifetime`) and returns JSON `{tracked: true, ...}`.

## Events (`src/Event/`)

- `AffiliateAccountLookupEvent` (`affiliated_account_lookup`) — alter the account resolved from a code.
- `AffiliateCodeLookupEvent` (`affiliated_code_lookup`) — alter the code produced from an account.
- `ConversionPreCreateEvent` (`affiliated_conversion_pre_create`) — dispatched from
  `AffiliateConversion::preSave()` for new conversions after all data (label, commission) is set.
  `$event->reject($reason)` stops the save (logged; save returns FALSE; reason on the entity). Use it
  to disqualify a sale/registration before it counts.

## Extending patterns

- **Custom conversion type**: create an `affiliate_conversion_type` bundle with a
  `default_commission`, `default_status` and a `label_pattern` (tokens, e.g.
  `[affiliate_conversion:parent]`). Create conversions in your own hook via the
  `affiliate_conversion` storage or `AffiliateManager::createConversion()`, then
  `setParentEntity($entity)` and `save()`.
- **Commission calculation**: implement `hook_affiliate_conversion_presave()` /
  the pre-create event, or (like `affiliate_commerce`) a helper that reads the parent entity's
  amount and calls `$conversion->setCommission($value, $currency)`.
- **Tokens** (`affiliated.tokens.inc`): `[affiliate_conversion:parent]` yields the parent entity
  label and supports chained tokens (`[affiliate_conversion:parent:*]`).
- **Views**: base tables `affiliate_click` and `affiliate_conversion` expose Views data; the
  `affiliate_conversion_parent_entity` Views field renders the parent entity's label.
- **Building affiliate links in code**: `affiliated_url_set_affiliate_params(Url, $affiliate,
  $campaign=NULL)` and `affiliated_get_affiliate_parameters($affiliate, $campaign=NULL)`
  (`affiliated.module`) append the configured query vars for an active affiliate.
