<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synpay PSP providers (the `Synpay` plugin type)

Each payment service provider is a plugin discovered from `src/Plugin/Synpay/`, annotated with
`@SynpayAnnotation(id = "...", title = @Translation("..."))`, extending `SynpayPluginBase`
(`src/PluginManager/SynpayPluginBase.php`) and implementing `SynpayPluginInterface` +
`ContainerFactoryPluginInterface`. The manager is `SynpayGatewayManager`
(service `plugin.manager.synpay`). One Commerce "Synpay Gateway" is bound to exactly one provider
through the Commerce gateway config field `gateway` (see [flow.md](flow.md)).

![Synpay settings form](../../../../../../../screenshots/synpay/2.0.x/settings-form.png)

## Provider list (plugin id → class → title)

| id | class | title | notes |
|---|---|---|---|
| `alfa` | `SynpayAlfa` | Alfa | Alfa-Bank, RBS-family API. |
| `cloudpayments` | `SynpayCloudPayments` | CloudPayments | **On-site** JS widget (via `/synpay/onsite/...`), not an off-site redirect. |
| `paykeeper` | `SynpayPayKeeper` | Pay Keeper | Invoice API; fetches an API token at init. |
| `paykeeper_qr` | `SynpayPayKeeperQr` | Pay Keeper Qr | extends `SynpayPayKeeper`. |
| `robokassa` | `SynpayRobokassa` | Robokassa | POST redirect; uses two shop passwords (#1 / #2). |
| `sber` | `SynpaySber` | Sber | Sberbank acquiring via `voronkovich/sberbank-acquiring-client`. |
| `sber_qr` | `SynpaySberQr` | Sber QR | QR/SBP. |
| `sbercredit` | `SynpaySbercredit` | Sbercredit | Sber consumer credit. |
| `sberinstallment` | `SynpaySberinstallment` | Sberinstallment | extends `SynpaySbercredit`; installment plan. |
| `sgb` | `SynpaySgb` | Sgb | SeverGazBank, RBS-family API. |
| `tinkoff` | `SynpayTinkoff` | Tinkoff | T-Bank acquiring (`securepay.tinkoff.ru/v2/`). |
| `tinkoff_credit` | `SynpayTinkoffCredit` | TinkoffCredit | Tinkoff consumer credit. |
| `tinkoff_dolyame` | `SynpayTinkoffDolyame` | TinkoffDolyame | "Dolyame" pay-in-parts; front-end snippet/block. |
| `tinkoff_qr` | `SynpayTinkoffQr` | Tinkoff Qr | extends `SynpayTinkoff`; QR/SBP. |
| `yandex` | `SynpayYandex` | yandex | Yandex Pay (`pay.yandex.ru/api/merchant/v1/`). |
| `yandex_split` | `SynpayYandexSplit` | yandex_split | extends `SynpayYandex`; BNPL + checkout widget. |
| `yookassa` | `SynpayYooKassa` | Ykassa | YooKassa via `yoomoney/yookassa-sdk-php`. |
| `yookassa_qr` | `SynpayYooKassaQr` | yookassa_qr | extends `SynpayYooKassa`; QR/SBP. |

## How credentials are sourced (important)

All PSP credentials live in **one config object, `synpay.settings`** (edited on the settings form,
`Settings::submitForm()` writes every `"{id}_*"` value with `$config->setData(...)`). There is **no
environment variable, Key entity, or dotenv flow** anywhere in the code — each provider reads its
secrets directly with `$this->config->get("{plugin_id}_...")` via `SynpayPluginBase::getStringSetting()`
/ `getBooleanSetting()`. The provider only loads credentials after confirming it is *active*
(`"{id}_active"`) and that some Commerce gateway is bound to it; it then reads the test- or live-mode
set based on the bound Commerce gateway's `mode`.

Per-provider credential keys (all under `synpay.settings`):

- **alfa / sber / sgb / tinkoff / tinkoff_credit / tinkoff_dolyame / paykeeper / yookassa**:
  `{id}_test_login` + `{id}_test_token` and `{id}_live_login` + `{id}_live_token`
  (login = merchant/terminal id, token = API password/secret key/terminal key).
- **robokassa**: `{id}_login` (shop id), plus `{id}_live_pass` / `{id}_live_pass2` and
  `{id}_test_pass` / `{id}_test_pass2` (password #1 signs the customer redirect/success URL,
  password #2 signs the result callback), `{id}_description`.
- **cloudpayments**: `{id}_publicId` (public id used by the client-side widget) + `{id}_skin`.
- **paykeeper**: also `{id}_secure` ("secret word" for notifications).
- Receipt / fiscal options where supported: `{id}_send_receipt`, `{id}_taxation`, `{id}_tax`,
  `{id}_payment_method`, `{id}_payment_object` (label sets differ per provider; see each
  `settingForm()`).
- **yandex_split** front-end: `{id}_widget`; **tinkoff_dolyame** front-end: `{id}_snippet`,
  `{id}_site_id` / `{id}_siteID`.

## PRECISION (kopecks vs rubles)

Each provider declares a `const PRECISION`: `TRUE` = amount is sent **with** kopecks (major units,
e.g. YooKassa/CloudPayments/PayKeeper/Robokassa), `FALSE` = amount is sent **in** kopecks (minor
units, e.g. Sber/Tinkoff — `OffsitePaymentForm::normalizePrice()` multiplies by 100 with `bcmul`).
`GatewayService::getPrecision()` reads the constant off the active provider.

## Outbound API certificates (Russian CA chain)

`SynpayPluginBase::createHttpClient()` / `createGuzzleClient()` build the Guzzle client used by
Robokassa, PayKeeper, Tinkoff, Sber (adapter) and Yandex with Guzzle `verify` set to a CA bundle
from `getCaBundlePath()`: the system trust store (`/etc/ssl/certs/ca-certificates.crt`) with the
three bundled Russian Trusted CA PEMs (`assets/certs/`) appended — needed because these acquiring
APIs present certificates from the Russian national CA chain. YooKassa and Sber additionally go
through their vendor SDK HTTP clients.

## Adding a new provider

1. Create `src/Plugin/Synpay/SynpayFoo.php` with
   `@SynpayAnnotation(id = "foo", title = @Translation("Foo"))`, extend `SynpayPluginBase`,
   implement `SynpayPluginInterface` and `ContainerFactoryPluginInterface`.
2. In the constructor read `synpay.settings`, set `$this->active` from `"foo_active"`, and on the
   bound Commerce gateway's `mode` read your login/token keys.
3. Implement the methods the framework calls (all optional, guarded by `method_exists`):
   `registerOrder($order_id, PaymentInterface $payment, array $params)` (return
   `['orderId' => ..., 'formUrl' => ...]` or, Robokassa-style, `['url', 'data', 'orderId']`),
   `onReturn(OrderInterface, Request)`, `onNotify(Request)`, `settingForm()`,
   `checkOrderStatus($remote_id)`, `updateOrderStatus($remote_id)`,
   `requestRefund(PaymentInterface, $amount, $items)`, and a `const PRECISION`.
   Optionally `pay()`, `onsite()`, `callback()`, `testCards()` for the direct-pay / on-site routes.
4. Clear caches — the plugin manager (cache id `synpay_plugin`, alter hook `synpay_info`)
   auto-discovers it; it then appears on the settings form and in the Commerce gateway's
   `gateway` radios once `"foo_active"` is on.
