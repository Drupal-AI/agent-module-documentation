<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Swiss Post — agent start

Integrates **Swiss Post** (Switzerland) with **Drupal Commerce Shipping**, plus a standalone
**Swiss Post address-verification** service. Three capabilities:

1. **Shipping method** — a `swiss_post` ShippingMethod plugin that **extends core Commerce
   `FlatRate`** (so the buyer-facing price is a flat rate configured by the admin, *not* quoted
   from the API) and implements `SupportsTrackingInterface` (links to Swiss Post tracking).
2. **Barcode label generation** — calls Swiss Post's *Barcode* REST API to produce a shipment
   address-label PDF, stores it on the shipment (private file), and sets the tracking code.
3. **Address verification** — validates/corrects CH & LI addresses against Swiss Post's
   *Address Web Services* (a SOAP-style JSON endpoint), exposed both as an address field widget
   and as a Webform handler.

Release on disk: **1.1.0**, `core_version_requirement: ^10.1 || ^11`, package "Commerce
(contrib)", `security_advisory_coverage: covered`, "Seeking co-maintainer(s)".
Libraries required (composer): `league/oauth2-client ^2.6`, `setasign/fpdf 1.8.*`,
`setasign/fpdi ^2.0`. `commerce`, `commerce_shipping` and `webform` are **dev**-only
requirements — the module degrades gracefully when `commerce_shipping` is absent (settings form
hides the shipping section; cron no-ops).

## Where things live

- **Settings form** — `src/Form/SwissPostSettingsForm.php` at
  `/admin/config/services/swiss-post-settings` (menu link under *Configuration → Web services*,
  route `commerce_swiss_post.commerce_swiss_post_settings_form`, permission
  `administer site configuration`). Writes `commerce_swiss_post.settings`. Fields: `api_host`,
  `client_id`, `client_secret`, `franking_license`, `label_layout` (A5/A6/A7), `print_preview`
  (SPECIMEN test labels), and the address-web-services block `aws_host`, `aws_username`,
  `aws_password`, `aws_log_level`. The Commerce/shipping fields only render when
  `commerce_shipping` is enabled.
- **ShippingMethod plugin** — `src/Plugin/Commerce/ShippingMethod/SwissPost.php`. Extends
  `FlatRate`; adds a single required `shipping_method` textfield (the Swiss Post product code,
  e.g. `ECO`, `PRI`). `getTrackingUrl()` → `https://www.post.ch/swisspost-tracking?formattedParcelCodes=<code>`.
- **Access token** — `src/AccessTokenProvider.php`. OAuth2 **client_credentials** grant via
  `league/oauth2-client` `GenericProvider` against `{api_host}/WEDECOAuth/token`, scope
  `WEDEC_BARCODE_READ`. Token cached in the `commerce_swiss_post` expirable key-value store
  until (expiry − 10s).
- **Label generator** — `src/LabelGenerator.php` (`commerce_swiss_post.label_generator`).
  `getLabel()` POSTs to `{api_host}/api/barcode/v1/generateAddressLabel` with a Bearer token;
  base64-decodes `item.label[0]` into a PDF; sets the shipment tracking code from
  `item.identCode`; persists the PDF to the `commerce_swisspost_barcode_label` file field when
  present. `mergePdfs()` combines multiple labels via FPDI. `generateLabelResponse()` returns a
  `application/pdf` attachment `Response`. Detail → [labels.md](labels.md).
- **Label route/controller** — `src/Controller/CommerceSwissPostLabelController.php`,
  route `commerce_swiss_post.label`
  (`/admin/commerce/orders/{commerce_order}/shipments/{commerce_shipment}/label`). Requires
  permission `administer commerce_shipment` **and** custom access
  (`checkAccess`: the shipment's shipping-method plugin must be a `SwissPost` instance).
- **Bulk action** — `src/Plugin/Action/GenerateLabelAction.php`
  (`commerce_swiss_post_generate_label_action`, config entity
  `commerce_swiss_post_generate_labels_action`, "Download Swiss Post Shipping labels", on
  `commerce_order`). Access gated by `administer commerce_shipment`; collects SwissPost shipments
  from selected orders and streams a merged PDF via `EnforcedResponseException`.
- **Entity trait** — `src/Plugin/Commerce/EntityTrait/SwissPostBarcodeLabel.php`
  (`commerce_swiss_post_barcode_label`) adds the `commerce_swisspost_barcode_label` **private**
  PDF file field to `commerce_shipment` bundles that opt in.
- **Address verification** — `src/AddressVerification.php`
  (`commerce_swiss_post.address_verification`). `verifyAddress()` GETs
  `{aws_host}/buildingverification4` with HTTP Basic auth (`aws_username`/`aws_password`);
  reads `QueryBuildingVerification4Result` (`Status`, `PSTAT`, `BuildingVerificationData`).
  `extractStreetParts()` splits an address line into street/house-no/addition via regex.
  Detail → [address-verification.md](address-verification.md).
- **Address consumers** — `src/Plugin/Field/FieldWidget/SwissPostAddress.php` (address widget
  extending `AddressDefaultWidget`, element-validate calls `verifyAddress` for CH/LI) and
  `src/Plugin/WebformHandler/AddressValidationHandler.php` (Webform validate handler mapping
  street/postal-code/town elements).
- **Alter event** — `src/Events/ShipmentToBarcodeEvent.php`
  (`ShipmentToBarcodeEvent::class`) dispatched inside `buildRequestData()` so subscribers can
  rewrite the barcode-API payload before it is sent.
- **Cron** — `commerce_swiss_post_cron()` deletes stored label files older than **180 days**
  (Swiss Post labels expire) and clears the field.

## Config

`commerce_swiss_post.settings` (config/install defaults): `api_host: https://wedec.post.ch`,
`label_layout: A6`, `print_preview: false`, `aws_log_level: 0`, all credential/license fields
empty. `api_host` and `aws_host` are admin-set config values (not request-supplied). The label
file field requires the **private** file system to be configured.

## Key mechanics (source-grounded)

- **Buyer price is flat-rate, server-side.** `SwissPost extends FlatRate`; the amount comes
  from the admin's FlatRate configuration, never from the client and never from the barcode API.
  The `shipping_method` code (ECO/PRI/…) only selects the Swiss Post product (`item.attributes.przl`).
- **Label PDF reuse.** `getLabel()` returns the already-stored file if the shipment's
  `commerce_swisspost_barcode_label` field references an existing file, otherwise it calls the API.
- **API errors** surface as thrown `\Exception`s carrying the API field/message plus shipment &
  order ids; the controller and action catch them and show a messenger error (redirect / no PDF).
- **Verification error handling.** On missing config, a `ServerException`, or any other
  exception, `verifyAddress()` returns `TRUE` (treats the address as valid) so checkout is never
  blocked by an API outage — this is the documented contract. `PSTAT` 1 = valid, 2–5 = corrected
  (writes back a corrected address), else invalid.
- **Double-submit override (by design).** The widget/handler store the last-rejected address in
  `$_SESSION['commerce_swiss_post_previous_input']`; re-submitting identical data skips
  re-validation, so a customer sure their address is correct can proceed (the error message
  tells them to re-submit the same data).

## HTTP client / transport

All three API callers use Drupal's shared `@http_client` / the default League OAuth2 Guzzle
client with default options — **TLS certificate verification is left at Guzzle's default (on)**;
no request sets `verify => false`. The barcode API host defaults to the fixed
`https://wedec.post.ch`. See [labels.md](labels.md) and [address-verification.md](address-verification.md).

## Related docs

- [labels.md](labels.md) — OAuth token, barcode-label request payload, storage, PDF merge.
- [address-verification.md](address-verification.md) — AWS endpoint, widget & webform handler.
- [../usage.md](../usage.md), [../human-docs/index.md](../human-docs/index.md) — setup walkthrough.
