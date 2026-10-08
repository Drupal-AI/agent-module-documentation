<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Affiliated (affiliated) — agent index

Affiliate/referral tracking framework. A JS behaviour reads an affiliate code from the URL
(`?affiliate=CODE`, optional `affiliate_campaign=CODE`), POSTs it to `/affiliated/track`, and the
module cookies the affiliate + campaign. A cookied visitor's later trackable action creates an
`affiliate_conversion` attributed to the affiliate. Package **Affiliated**. Core `^10.1 || ^11`.
Depends on core **`views`**, **`user`**. Version **1.0.0-alpha3** (version dir 1.0.x). No PHP or
composer deps beyond core. Suggests `drupal/commerce`, `drupal/token`.

## What it provides

- **Content entities** (`src/Entity/`):
  - `affiliate_campaign` — named link buckets owned by an affiliate; flags `is_default`, `is_global`;
    a `code` field (unique, non-numeric via `NotNumeric` constraint). Access:
    `AffiliateCampaignAccessControlHandler` (view/update/delete any|own).
  - `affiliate_click` — a logged visit (affiliate, campaign, hostname/IP, referrer, destination).
    Access: `AffiliateClickAccessControlHandler` (view/delete any|own).
  - `affiliate_conversion` — an attributed conversion (affiliate, campaign, amount, currency, parent
    entity ref, notes, published=approved). Bundle = `affiliate_conversion_type` (config entity with
    `default_commission`, `default_status`, `label_pattern`). Custom storage
    `AffiliateConversionStorage` swallows `ConversionRejectedException`.
- **Service** `affiliate.manager` (`AffiliateManager`) — code↔account/campaign lookup, click
  registration, conversion creation, active-affiliate check. See [api/extending.md](api/extending.md).
- **Routes** (`affiliated.routing.yml`): settings form, admin index, `/affiliated/track` (POST),
  Affiliate Center `/user/{user}/affiliate`, user campaign add, conversion approve/cancel forms.
  A route subscriber locks the click/conversion canonical pages to edit access.
- **Reporting Views** (`config/install/views.view.affiliate_*`): admin pages plus per-user pages
  (`/user/%user/affiliate/{campaigns,clicks,conversions}`) whose argument validates update access on
  the user, so an affiliate sees only their own records.
- **Permissions** (`affiliated.permissions.yml` + `AffiliatePermissions`), **tokens**
  (`affiliated.tokens.inc`), a Views field plugin `affiliate_conversion_parent_entity`, and a
  `NotNumeric` validation constraint.
- **Submodules** (documented separately under `modules/`): `affiliate_commerce`,
  `affiliate_registrations`, `affiliate_webform`.

## Solution docs

- Configuration object, settings form, visibility/exclusion → [config/settings.md](config/settings.md)
- Entities, fields, permissions, access model, dashboard/Views → [entities/model.md](entities/model.md)
- AffiliateManager service, tracker flow, events, hooks, extending → [api/extending.md](api/extending.md)
