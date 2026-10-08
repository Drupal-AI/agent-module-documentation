<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Business Identity block

## What it is

`Plugin\Block\BusinessIdentityBlock` — block plugin id **`business_identity_block`**, admin label
*"Business Identity"*, category *"Business"*. Implements `ContainerFactoryPluginInterface` and
injects `config.factory`. Place it like any block (Structure → Block layout, or a block config
entity); visibility/placement follow core block access.

## What it renders (`build()`)

Reads `business_identity.settings` and `business_identity.opening_hours` and returns a render array
with `#theme => 'block__business_identity'` and these variables:

- `#business` — `legal_name`, `commercial_name`, `vat_number`, `address`, `phone`, `email`,
  `website` (each `$config->get(...)`).
- `#social_links` — iterates `social_links` config, keeping entries with `platform` + `url`, and
  derives an `icon_class` of `bi-<platform>`.
- `#opening_hours` — for each weekday reads `<day>_open` / `<day>_start` / `<day>_end` /
  `<day>_breaks` from `business_identity.opening_hours` (defaults 09:00–17:00).

Cache: `#cache` tags come from the settings config; context `url`. Attaches library
`business_identity/block` (which is **not defined** — `business_identity.libraries.yml` is empty —
so no CSS/JS actually loads).

Note the block reads keys `commercial_name`, `vat_number`, `website`, and a separate
`business_identity.opening_hours` config object that the shipped settings form does **not** write,
so on a stock install several of these values are empty unless populated by other means.

## Template (`templates/block--business-identity.html.twig`)

Standard themeable template. Outputs the commercial/legal name (`<h3>`), a structured address
block, phone, an `mailto:` email link, an opening-hours `<ul>`, social-link anchors
(`target="_blank" rel="noopener noreferrer"`), and a VAT line. **All values pass through Twig
autoescaping** (no `|raw`), so admin-entered identity strings are HTML-escaped on output. Overriding
the template in a theme follows normal Drupal theme-suggestion rules.

## JSON-LD (present but unrouted)

`Controller\BusinessIdentityController::jsonLd()` assembles a schema.org `LocalBusiness`
`application/ld+json` `JsonResponse` from the same config (name, legalName, vatID, address,
telephone, email, url, openingHours, sameAs). It is **not wired to any route** in
`business_identity.routing.yml`, so it is currently dead code; to expose structured data you would
add a route pointing at it.
