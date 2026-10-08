Synpay (Synapse) adds a single Drupal Commerce off-site payment gateway that fronts around eighteen Russian payment service providers, each implemented as a pluggable Synpay provider plugin.

---

Synpay ships one Commerce `PaymentGateway` plugin (`synpay`, an off-site redirect gateway) plus a custom `Synpay` plugin type: one plugin class per payment service provider (PSP) under `src/Plugin/Synpay/`. A site enables and configures each PSP's credentials on the module settings form (`/admin/config/synpay/settings`), then adds one or more Commerce payment gateways (`/admin/commerce/config/payment-gateways/add`) of type "Synpay Gateway" and, in each, picks which active PSP that gateway routes to and whether it runs in test or live mode. At checkout the shopper is redirected off-site to the chosen PSP (or shown an on-site widget for CloudPayments), and the provider reports the result back through Synpay's return and notification routes, which drive the Commerce payment/order state. Supported providers include Alfa-Bank, CloudPayments, PayKeeper (+QR), Robokassa, Sber (+QR / credit / installment), SeverGazBank (Sgb), Tinkoff/T-Bank (+Credit / Dolyame / QR), Yandex Pay (+Split) and YooKassa (+QR). Administrators also get per-order "payments check" and "payments refund" screens, and the module can attach the Yandex Split and Tinkoff Dolyame front-end widgets to checkout and product pages. The module documents its interface in Russian and targets Russian acquiring APIs; it bundles the Russian Trusted Root/Sub CA certificates so outbound calls to those APIs validate. Requires Drupal Commerce (commerce_payment / commerce_order / commerce_checkout / commerce_price) at runtime even though the `.info.yml` does not declare it, and the `firebase/php-jwt`, `voronkovich/sberbank-acquiring-client` and `yoomoney/yookassa-sdk-php` Composer libraries.

---

- Accept card payments on a Drupal Commerce store through a Russian PSP without writing gateway code.
- Offer shoppers a choice of several Russian acquirers (e.g. Sber, Tinkoff, YooKassa) side by side at checkout.
- Route different Commerce payment gateways to different PSP providers from one shared settings screen.
- Run any provider in test mode first (test login/token, test cards shown on the review step) and flip it to live later.
- Integrate Sberbank acquiring (card, QR/SBP, consumer credit, and installment plans) via the bundled Sberbank SDK.
- Integrate Tinkoff / T-Bank acquiring, including QR/SBP, Tinkoff Credit and the Tinkoff "Dolyame" pay-in-parts product.
- Integrate YooKassa (Ю-Касса) card payments and the YooKassa QR/SBP flow via the official YooKassa SDK.
- Integrate Robokassa with its dual-password signed result/success callbacks.
- Integrate CloudPayments using its on-site JavaScript checkout widget instead of an off-site redirect.
- Integrate PayKeeper (and its QR variant) invoice-based acquiring.
- Integrate Alfa-Bank and SeverGazBank (RBS-family) acquiring.
- Offer Yandex Pay and Yandex Split (buy-now-pay-later) with the Yandex Split checkout widget.
- Show the Tinkoff Dolyame "pay in parts" snippet/widget and a Dolyame modal block on product and checkout pages.
- Send fiscal receipt data (taxation system, VAT rate, payment method/object per line item) to providers that support online cash-register receipts.
- Include order line items and adjustments (shipping, discounts) in the amount and receipt sent to the PSP.
- Let staff review every payment attempt for an order and re-query the provider for its current status from the order page.
- Let staff issue refunds for a completed payment from the order page (implemented for providers that support it, e.g. Tinkoff).
- Provide notification (IPN) and customer-return endpoints that the PSPs call to finalize the payment.
- Add new PSP providers by writing a new `Plugin/Synpay/` class with a `@SynpayAnnotation` id — no changes to core module code.
- Localize the checkout experience for Russian-language stores (all provider labels and receipt options are in Russian).
- Support both "amount in kopecks" and "amount with kopecks" providers automatically via each plugin's `PRECISION` constant.
