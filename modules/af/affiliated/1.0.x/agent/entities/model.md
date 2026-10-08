<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliated — entities, permissions, access, dashboard

## Entities (`src/Entity/`)

### affiliate_campaign (`AffiliateCampaign`)
Content entity, base table `affiliate_campaign`, owner key `user_id`, publishable (`status`),
label = `name`. Fields: `name` (required), `code` (unique, `NotNumeric` constraint — used in URLs;
empty ⇒ campaign id is used), `is_default` (bool), `is_global` (bool, default FALSE), `created`,
`changed`. `postSave()` clears the previous default when a campaign is set default for that owner.
Route provider `AffiliateCampaignHtmlRouteProvider` adds a bundle-settings route. Form
`AffiliateCampaignForm`: `user_id`/`is_default` hidden unless `administer affiliate_campaign
entities`; `is_global` hidden unless `flag campaigns as global`; the default campaign's flags are
locked.

### affiliate_click (`AffiliateClick`)
Content entity, base table `affiliate_click`, owner key `user_id`. Fields: `affiliate` (user ref),
`campaign` (campaign ref), `hostname` (client IP), `referrer` (string_long), `destination`,
`created`. Delete form only; collection at `/admin/config/affiliate/clicks`.

### affiliate_conversion (`AffiliateConversion`)
Content entity, base table `affiliate_conversion`, bundle = `affiliate_conversion_type`,
`permission_granularity = bundle`, owner key `user_id` (the **converted** user, e.g. buyer/registrant
— NOT the affiliate), publishable where **published = approved** (`isApproved()`). Custom storage
`Storage\AffiliateConversionStorage`. Fields: `label` (auto-generated from the bundle's
`label_pattern` via token replace in `preSave()` if empty), `affiliate` (user ref), `campaign`
(campaign ref), `entity_id` + `entity_type` (polymorphic parent ref via `setParentEntity()`),
`amount` (decimal commission), `currency`, `notes`, `created`, `changed`, `status`.
- `preCreate()` applies the bundle's `default_status`; unapproved conversions get a "Pending admin
  approval" note.
- `preSave()` applies the bundle `default_commission` if `amount` is NULL, and — for new,
  non-syncing conversions — re-validates campaign ownership: a non-global campaign not owned by the
  affiliate is replaced with the default campaign. It then dispatches `ConversionPreCreateEvent`; a
  subscriber's `reject()` throws `ConversionRejectedException`, which the storage swallows (save
  returns FALSE, reason on `$conversion->rejectionReason`). See [../api/extending.md](../api/extending.md).
- Extra forms: `approve` (`ApproveConversionForm`) and `cancel` (`CancelConversionForm`, requires a
  reason, sets unpublished + notes).

### affiliate_conversion_type (`AffiliateConversionType`)
Config entity bundle (`config_prefix affiliate_conversion_type`), admin permission `administer
affiliate_conversion types`, form `AffiliateConversionTypeForm`. Config-exported keys: `id`, `label`,
`uuid`, `description`, `default_commission` (nullable float), `default_status` (bool), `label_pattern`
(token string). Submodules attach third-party settings to it (commission rules).

## Permissions

Static (`affiliated.permissions.yml`): `act as an affiliate`, `access affiliate center`,
`manage affiliates`, `flag campaigns as global` (restricted), `admin affiliate settings` (restricted),
`administer affiliate_campaign entities` (restricted), `administer affiliate_conversion types`
(restricted).
Dynamic (`AffiliatePermissions::generatePermissions`): `create affiliate_campaign entities`,
`approve affiliate_conversion entities`, and per-scope `view|edit|delete {any|own}
affiliate_campaign entities`, `view {any|own} affiliate_click entities`, `view {any|own}
affiliate_conversion entities`.

## Access model (how ownership is enforced)

- **Campaigns / clicks**: dedicated access handlers grant view/update/delete on `any` vs `own`
  (`own` = `$account->id() == $entity->getOwnerId()` + the matching `own` permission). The default
  campaign cannot be deleted.
- **Conversions**: no custom handler (default `EntityAccessControlHandler` + bundle admin permission
  `administer affiliate_conversion entities`), so direct entity operations are effectively
  admin-only; `AffiliatedRouteSubscriber` further pins the `affiliate_conversion`/`affiliate_click`
  **canonical** pages to `_affiliated_entity_edit_access` (`Access\EntityEditAccessCheck`, requires
  `update` access on the entity). Affiliates read their conversions through the Views below, not the
  canonical page.
- **Affiliate Center** (`AffiliateUserPagesController::overviewPageAccess`): only the account owner
  (with `access affiliate center`) or a user with `administer users`/`manage affiliates`.
- **Per-user reporting Views** (`views.view.affiliate_{campaigns,clicks,conversions}`, page displays
  at `/user/%user/affiliate/...`): the user argument uses the `entity_target_id` plugin with
  `validate: entity:user, operation: update`, so viewing another user's page requires update access
  on that user — restricting each affiliate to their own campaigns/clicks/conversions. Admin displays
  (`/admin/config/affiliate/...`) use `view any ...`/`access administration pages`.
