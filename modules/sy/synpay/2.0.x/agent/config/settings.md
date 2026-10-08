<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synpay install, settings, permissions, hooks

## Install / enable

```sh
composer require drupal/synpay
drush en synpay -y
```

Drupal **Commerce** (with `commerce_payment`, `commerce_order`, `commerce_checkout`,
`commerce_price`, `commerce_product`) must already be installed — the `.info.yml` does **not**
declare it, so Composer/Drupal will not pull it in automatically. The Composer libraries
`firebase/php-jwt`, `voronkovich/sberbank-acquiring-client` and `yoomoney/yookassa-sdk-php` are
declared in the module's `composer.json` and installed with it.

`synpay_install()` (`synpay.install`) creates the `modal_mydolyame` block instance and places it in
the active theme's `bottom` region (falls back to the last region) — used by the Tinkoff Dolyame
modal.

## Settings form — `/admin/config/synpay/settings`

Route `synpay.settings` → `Settings` (`src/Form/Settings.php`), a `ConfigFormBase` editing the
single config object **`synpay.settings`**. Permission: `access administration pages`. Menu link
`synpay.settings` under *Configuration › System* (`synpay.links.menu.yml`).

![Add payment gateway (Synpay Gateway)](../../../../../../../screenshots/synpay/2.0.x/payment-gateway-add.png)

`buildForm()` iterates every discovered Synpay provider (sorted), renders a `details` group per
provider with a `"{id}_active"` checkbox and, if the plugin has `settingForm()`, that provider's
credential/receipt fields. `submitForm()` collects **all** submitted values whose key starts with
`"{id}_"`, trims them, and saves them as the complete `synpay.settings` data set.

There is no `config/install` default and **no config schema** shipped (`provides_config_schema:
false`); `synpay.settings` is created on first save. Because everything is one flat config object,
each provider namespaces its keys with its plugin id (e.g. `sber_live_login`, `tinkoff_test_token`,
`robokassa_live_pass2`, `cloudpayments_publicId`, `paykeeper_secure`, `yandex_split_widget`). See
[../payment/gateways.md](../payment/gateways.md) for the per-provider key list.

## Connecting a Commerce gateway

Add a payment gateway at `/admin/commerce/config/payment-gateways/add`, choose plugin **"Synpay
Gateway"**, pick the **Gateway** radio (one of the *active* PSP providers), set **Mode**
(test/live), and save. Repeat to expose more than one PSP at checkout. The provider's live/test
credential set is chosen from this gateway's `mode`.

## Permissions (`synpay.permissions.yml`)

- `access synpay pay` — "Synpay Pay Form": use the `synpay.pay` / `synpay.test` direct-pay routes.

Admin routes reuse core/Commerce permissions: `access administration pages` (settings),
`administer commerce_order` (per-order check/refund).

## Services (`synpay.services.yml`)

- `synpay.gateway` = `GatewayService` (arg `@plugin.manager.synpay`).
- `plugin.manager.synpay` = `SynpayGatewayManager` (parent `default_plugin_manager`).
- `logger.channel.synpay` = logger channel `synpay`.

## Hooks, block, libraries

- `synpay.module`: `hook_form_commerce_checkout_flow_multistep_default_alter` →
  `Hook\CheckoutFormAlter` (adds a test-mode notice + provider `testCards()` on *review*, and the
  Yandex Split / Tinkoff Dolyame widget markup on *order_information*);
  `hook_page_attachments_alter` → `Hook\PageAttachmentsAlter` (attaches the Yandex Split /
  Dolyame front-end libraries on checkout and product pages, keyed off the `*_active`/widget
  config); `hook_preprocess_commerce_product` → `Hook\PreprocessCommerceProduct`;
  `hook_theme` → `Hook\Theme` (`synpay`, `block__modal_mydolyame`);
  `template_preprocess_block__modal_mydolyame` → `Hook\TemplatePreprocessBlockModalMyDolyame`.
- Block `ModalDolyame` (id `modal_mydolyame`), template `templates/block--modal-mydolyame.html.twig`.
- Libraries (`synpay.libraries.yml`): `synpay` (base JS), `cloudpayments` (external widget),
  `synpay-yandex-split`, `synpay-dolyame-snippet`, `synpay-dolyame-snippet-synapse`.

## Per-order admin screens

- `synpay.payments_check` `/admin/commerce/orders/{commerce_order}/payments_check` →
  `PaymentsCheckForm` (form id `synpay_pay_check`): lists payments; AJAX *Get Status*
  (`checkOrderStatus`, read-only) and, only for uid 1, *Update Status* (`updateOrderStatus`).
- `synpay.payments_refund` `/admin/commerce/orders/{commerce_order}/payments_refund` →
  `PaymentsRefundForm` (form id `synpay_pay_refund`): per-line refund calling the provider's
  `requestRefund()`, then sets the payment to `partially_refunded` / `refunded`.
