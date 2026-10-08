<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bitaps — settings & configuration

## Install / enable

Enable the contrib **Basket** module first (this module is a Basket payment plugin and calls
`\Drupal::service('Basket')`; if Basket is absent, `Pages` sets `$this->basket = NULL` and the
callback simply skips order fulfilment). Then enable `bitaps`. `bitaps.install` creates one table,
`payments_bitaps` (`bitaps_schema()`): `id` (serial PK), `nid`, `sid`, `uid`, `created`, `paytime`,
`amount` (varchar), `currency`, `status` (varchar), `data` (big text, PHP-serialized). No config
schema ships (`config/schema/` absent).

## Config object `bitaps.settings`

Defaults from `config/install/bitaps.settings.yml`:

```yaml
config:
  secret_key: ''
  forwarding_address: ''
  confirmations: '3'
  currency: BTC
```

Edited via `Form\SettingsForm` (`src/Form/SettingsForm.php`) at route `bitaps.settings` →
`/admin/config/development/bitaps` (menu link `bitaps.links.menu.yml`, under
`system.admin_config_development`). All four fields are `#required`; the form saves them under the
`config` key of `bitaps.settings` on an AJAX submit (`SettingsForm::ajaxSubmit()` →
`configFactory()->getEditable('bitaps.settings')->set('config', …)->save()`). Keys:

- **`secret_key`** — shared secret used only by `Bitaps::getHash()` to sign/verify the callback URL; obtained from the Bitaps dashboard.
- **`forwarding_address`** — BTC settlement address; sent to Bitaps as `forwarding_address` when creating a receive address.
- **`confirmations`** — number of on-chain confirmations required before Bitaps fires the confirmed notification; sent as `confirmations`.
- **`currency`** — fixed option `BTC` (the select offers only `BTC`); stored on each payment row.

## Permissions & access

- `access bitaps settings` (`bitaps.permissions.yml`, `restrict access: true`) — guards the settings route only.
- The customer/callback route `bitaps.pages` (`/bitaps/{page_type}`) is gated by `_permission: access content` (see [api/callback.md](../api/callback.md)).

## Basket wiring

`BasketBitaps` (`src/Plugin/Basket/Payment/BasketBitaps.php`, `@BasketPayment(id="bitaps",
name="Bitaps")`) provides the per-payment-point settings:

- `settingsFormAlter()` adds a **status** select (`fin_status` terms) — the Basket order status to apply after payment — saved via `formSubmit()` into Basket's `payment_settings`.
- `createPayment($entity,$order)` creates a new `payments_bitaps` row from `$order->pay_price` (`Bitaps::load(['nid'=>…, 'create_new'=>TRUE, 'amount'=>…])`) and returns its `payID`.
- `loadPayment($id)` returns the payment plus `isPay = status != 'new'`.
- `updateOrderBySettings($pid,$orderClass)` writes the configured `fin_status` onto the order.

To operate: install/enable Basket + bitaps → enter the four settings → in Basket's payment-systems
page add a payment point using the "Bitaps" service and choose the post-payment status.

## Service `Bitaps` (`src/Bitaps.php`)

Constructed with `@database`. `load($params)` selects from `payments_bitaps` filtered by
`id`/`nid`/`sid`; with `create_new` it forces a fresh row; with `amount` (and no existing row) it
inserts a `status='new'` row stamping `uid=currentUser()`, `created=time()`, and
`currency=bitaps.settings:config.currency`. `update($payment)` updates by `id`. `getHash()` returns
`hash('sha256', implode('~',[pid, secret_key, amount, secret_key, pid]))`.
