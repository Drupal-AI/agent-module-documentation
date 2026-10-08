<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bitaps Payment (bitaps) — agent index

Bitcoin (BTC) payment method for the contrib **Basket** commerce module, backed by the Bitaps
payment-address API (`https://api.bitaps.com/btc/v1/`). Not a standalone gateway and not tied to
Drupal Commerce.

- **Version dir:** 1.1.x (module 1.1.0). **Core:** `^10 || ^11 || ^12`. **Package:** Online store. License GPL-2.0-or-later.
- **Requirements:** functionally needs the contrib **Basket** module (soft — `\Drupal::hasService('Basket')`); `bitaps.info.yml` declares no hard `dependencies`. No composer.json. BTC only.
- **Configure:** `/admin/config/development/bitaps` → `bitaps.settings` route → `Form\SettingsForm` (permission `access bitaps settings`, `restrict access: true`).

## What it provides

- **Config object:** `bitaps.settings` with `config.{secret_key, forwarding_address, confirmations, currency}` (defaults in `config/install/bitaps.settings.yml`; `confirmations: '3'`, `currency: BTC`). No `config/schema/`.
- **Service `Bitaps`** (`src/Bitaps.php`, arg `@database`): CRUD over the `payments_bitaps` DB table — `load($params)`, `update($payment)`, `getHash($pid,$amount,$config)` (SHA-256), `t()`.
- **DB table `payments_bitaps`** (`bitaps.install` `bitaps_schema()`): id, nid, sid, uid, created, paytime, amount, currency, status, data(serialized).
- **Basket payment plugin** `@BasketPayment(id="bitaps")` → `src/Plugin/Basket/Payment/BasketBitaps.php` (implements `Drupal\basket\Plugins\Payment\BasketPaymentInterface`).
- **Routes** (`bitaps.routing.yml`):
  - `bitaps.settings` → `/admin/config/development/bitaps` (`SettingsForm`, `_permission: access bitaps settings`).
  - `bitaps.pages` → `/bitaps/{page_type}` (`Controller\Pages::pages`, `_permission: access content`) — `page_type=pay` renders the payment form, `page_type=status` handles the Bitaps callback.
- **Form `PaymentForm`** (`src/Form/PaymentForm.php`): renders address/amount, and `basketPaymentFormAlter()` calls the Bitaps API `create/payment/address` (via `\Drupal::httpClient()`) to get the receive address, passing `forwarding_address`, `confirmations`, and a `callback_link` back to `bitaps.pages/status`.
- **Permission:** `access bitaps settings` (`bitaps.permissions.yml`, `restrict access: true`).
- **Hooks** (`src/Hook/BitapsHooks.php` + `bitaps.module` legacy shims): `theme` (`bitaps_pay` → `templates/bitaps-pay.html.twig`), `basket_translate_context_alter`, `basket_noty_actions_alter` (`change_bitaps_status`), `basket_noty_twig_tokens_alter` (`bitaps_status`).
- **Alter hooks it invokes:** `hook_bitaps_payment_params_alter(&$params,$payment,&$config)`, `hook_bitaps_api_alter($payment,$fields)` (see `README.md`).
- **Library:** `bitaps/css` (`misc/styles.css`). Menu link: `bitaps.links.menu.yml`.

## Solution docs

- [Settings & configuration](config/settings.md) — the `bitaps.settings` object, keys, permission, and Basket wiring.
- [Payment flow & Bitaps callback](api/callback.md) — payment creation, the address API call, and the `/bitaps/status` notification handler.
