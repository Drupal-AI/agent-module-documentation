<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_monetico — agent start

Off-site **payment gateway for Drupal Commerce** integrating **Monetico** (a.k.a. Cybermut /
CM-CIC) — the shared payment kit of the French banks **Crédit Mutuel**, **CIC**, **OBC** and
**Monetico**. Depends on `commerce:commerce_payment`. Version **2.0.1**; core `^9 || ^10 || ^11`.
Package: Commerce (contrib). Bundles the bank's PHP payment kit under `src/kit/`.

It ships one `commerce_payment_gateway` plugin (id **`commerce_monetico`**, base
`OffsitePaymentGatewayBase`, method type `credit_card`) — not a new plugin *type*. There is **no
dedicated settings route**: you create/edit the gateway on Commerce's own Payment gateways admin
(`/admin/commerce/config/payment-gateways`, permission `administer commerce payment gateway`).

## Flow (redirect + seal-verified callback)

1. **Redirect** — `PluginForm/MoneticoPaymentForm::buildConfigurationForm()` builds a POST
   auto-redirect form (`buildRedirectForm`) to the bank's `paiement.cgi`. It assembles the CMCIC
   v3.0 field string, computes the request MAC (HMAC-SHA1) with the merchant **security key**, and
   posts hidden fields (`TPE`, `date`, `montant` = amount+ISO currency, `reference`, `MAC`,
   return URLs, `societe`, `mail`, split-payment `nbrech`/`montantechN`…). Reference is
   `orderId-requestTime` (`CommerceMoneticoAPI::invoice`). Amount is the **server-side order total**
   (`$order->getTotalPrice()`), formatted `xxxxx.yy`.
2. **Server callback (IPN)** — the bank POSTs the result to `/commerce_monetico/response` (route
   `commerce_monetico.response`; legacy alias `/commerce_cmcic/response` =
   `commerce_cmcic.response`), handled by `Controller/CommerceMoneticoRoutingController::response()`.
   It **recomputes the HMAC-SHA1 seal server-side** with the merchant key over the returned fields
   (`CMCIC_CGI2_FIELDS`: TPE, date, montant, reference, code-retour, 3DS fields…) via
   `kit/MoneticoHmac::computeHmac()` and only creates the `Payment`, marks it success/failure, and
   applies the order **`place`** transition **inside** the seal-match branch. A mismatch returns the
   CMCIC "MAC-NOT-OK" receipt and does not process. The callback URL is registered in the Monetico
   back office (not sent per-transaction).
3. **Browser return** — the shopper's browser returns to `/checkout/{order}/complete` (OK) or
   `/checkout/{order}/review` (cancel), set as `url_retour_ok` / `url_retour` on the redirect form.

The `code-retour` values handled: `paiement` / `payetest` → success, `Annulation` → failure, plus
multipart `paiement_pfN` / `Annulation_pfN` stubs.

## Configuration fields

Set on the gateway config form (`MoneticoPaymentGateway::buildConfigurationForm`), stored in the
`commerce_payment_gateway` config entity (schema: `config/schema/commerce_monetico.schema.yml`):

- **mode** — `test` / `live` (from Commerce base) — selects the bank's test vs production URL.
- **version** — payment kit version (default `3.0`).
- **tpe** — 7-char TPE (terminal) number.
- **company** — merchant/company code (`societe`).
- **security_key** — 40-char merchant key used for all HMAC computation. Keep confidential — the
  seal's trust rests on it; store it as a secret.
- **bank_type** — `cm` (Crédit Mutuel) / `cic` / `obc` / `monetico`, selecting the endpoint host
  in `CommerceMoneticoAPI::getServer()` (all `https://`).

## Files

- `src/Plugin/Commerce/PaymentGateway/MoneticoPaymentGateway.php` — the gateway plugin (config form, credentials).
- `src/PluginForm/MoneticoPaymentForm.php` — builds the offsite POST redirect + request MAC.
- `src/Controller/CommerceMoneticoRoutingController.php` — seal-verified server callback (`response()`).
- `src/kit/MoneticoHmac.php` — HMAC-SHA1 seal (`computeHmac`, key derivation from the 40-char key).
- `src/kit/MoneticoTpe.php` — kit constants (`CMCIC_*`) + TPE/URL/key holder.
- `src/CommerceMoneticoAPI.php` — helpers: bank URLs, invoice reference, price formatting, local history table.
- `commerce_monetico.install` — `commerce_monetico` history table (schema only; see note).
- `commerce_monetico.module` — legacy D7-era theme/payment-method hooks (dormant on D9+).
- `commerce_monetico.routing.yml` — the two callback routes.

## Notes / gotchas

- The `commerce_monetico.module` hooks (`hook_commerce_payment_method_info`, `theme()` calls) are
  Commerce-1/D7-era and are effectively dead on Drupal 9+ (Commerce 2/3); the live integration is
  the gateway plugin + controller. The card-brand icons live in `src/kit/images/`.
- The local `commerce_monetico` history table is declared in `.install`, and `saveData()` /
  `historyLoad()` exist in `CommerceMoneticoAPI`, but the controller's `saveData()` call is
  currently commented out, so the table stays empty in normal operation.
- Maintenance status: "seeking co-maintainer", maintenance-fixes-only.
