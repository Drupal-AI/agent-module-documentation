<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gift-card types & entities

## `commerce_giftcard_type` (config entity / bundle)

The bundle for gift cards. `@ConfigEntityType id = "commerce_giftcard_type"`, config prefix
`commerce_giftcard.giftcard_type.*`, `bundle_of = commerce_giftcard`,
`admin_permission = administer commerce_giftcard_type`. Exported keys:

```yaml
# commerce_giftcard.giftcard_type.<id>
id: holiday
label: 'Holiday gift card'      # admin label
display_label: 'Gift card'      # customer-facing label
generate:
  length: 8                     # generated code length (default 8)
```

Admin routes (route provider `AdminHtmlRouteProvider`):

- collection (configure route): `/admin/commerce/config/giftcard_types`
- add: `/admin/commerce/config/giftcard_types/add`
- edit: `/admin/commerce/config/giftcard_types/manage/{commerce_giftcard_type}`

Create one via the entity API (or the UI). Read/write the raw config with drush:

```bash
drush cget commerce_giftcard.giftcard_type.holiday
```

```php
$type = \Drupal\commerce_giftcard\Entity\GiftcardType::create([
  'id' => 'holiday', 'label' => 'Holiday gift card', 'display_label' => 'Gift card',
  'generate' => ['length' => 12],
]);
$type->save();
// helpers: $type->getGenerateSetting('length'); $type->getDisplayLabel();
```

## `commerce_giftcard` (content entity)

Base table `commerce_giftcard`, bundle key `type`, label key `code`, owner `uid`. Base fields:

| Field | Type | Notes |
|---|---|---|
| `code` | string | unique, required — the redeemable code (case-insensitive) |
| `balance` | commerce_price | required — current balance |
| `stores` | entity_reference (`commerce_store`) | optional — limit the card to these stores |
| `status` | boolean | enabled/disabled (`isEnabled()` / `setStatus()`) |
| `uid` | entity_reference (user) | owner |
| `created` / `changed` | timestamps | |

Admin collection: `/admin/commerce/giftcards` (add `/admin/commerce/giftcards/add/{type}`). Interface
helpers: `getCode()/setCode()`, `getBalance()/setBalance(Price)`, `isEnabled()/setStatus()`.

## `commerce_giftcard_transaction` (content entity)

Records balance changes. Base table `commerce_giftcard_transaction`. Base fields: `amount`
(commerce_price), `giftcard` (reference to the gift card), `reference_id` + `reference_type` (the
entity that caused the change, e.g. an order), `comment`, `uid`, `created`, `changed`. Listed per
card at `/admin/commerce/giftcards/{commerce_giftcard}/transactions`.

## Config schema

`commerce_giftcard.giftcard_type.*` validates `id`, `label`, `display_label`, and `generate.length`
(integer). The redemption pane adds `commerce_checkout.commerce_checkout_pane.commerce_giftcard_redemption`
with `allow_multiple` (boolean).
