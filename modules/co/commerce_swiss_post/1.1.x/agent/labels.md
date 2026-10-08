<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Barcode label generation

Source: `src/LabelGenerator.php`, `src/AccessTokenProvider.php`,
`src/Controller/CommerceSwissPostLabelController.php`, `src/Plugin/Action/GenerateLabelAction.php`,
`src/Events/ShipmentToBarcodeEvent.php`.

## OAuth2 token (`AccessTokenProvider`)

- `league/oauth2-client` `GenericProvider`, **client_credentials** grant, scope
  `WEDEC_BARCODE_READ`.
- Authorize/access/resource URL all `{api_host}/WEDECOAuth/token`.
- Credentials `client_id` / `client_secret` from `commerce_swiss_post.settings`.
- Token cached in expirable key-value collection `commerce_swiss_post`, key `access_token`,
  TTL = `expires − now − 10s`. `getAccessToken(TRUE)` forces a refresh.
- Uses the provider's default Guzzle HTTP client (default TLS verification, on).

## Generating a label (`LabelGenerator::getLabel`)

1. If the shipment already has a stored, on-disk `commerce_swisspost_barcode_label` file, return
   its contents (no API call).
2. Get a Bearer token, build the payload (`buildRequestData`), and `POST`
   `{api_host}/api/barcode/v1/generateAddressLabel` with headers
   `Authorization: Bearer …`, `Accept`/`Content-Type: application/json` and a `json` body.
3. Response handling: throw if `item.errors` is non-empty or `item.label[0]` is missing;
   otherwise `base64_decode(item.label[0])` → PDF bytes.
4. `setTrackingCode(item.identCode)`; if the field exists, save the PDF via
   `FileSystem::saveData` to the field's upload location (private scheme) as a permanent `File`,
   then `$shipment->save()`. Logs generation time (channel `comerce_swiss_post` — note the
   upstream typo in the channel name).
5. `BadResponseException` 400 → throws with the rejected field/value/error; other statuses →
   throws with status code + stripped body.

### Request payload (`buildRequestData`)

- Store address → `customer` block (`name1` = store label, street/zip/city/country).
- Shipping profile address → `item.recipient` (family/given name, organization → `name2`,
  street/houseNo split by regex `/^(.+) (\d+[a-z]*)$/`, zip/city/country).
- `frankingLicense` = config `franking_license`; `labelDefinition.labelLayout` = config
  `label_layout`; `imageFileType: PDF`; `imageResolution: 300`; `printPreview` = config
  `print_preview` (SPECIMEN test labels). `language` hard-coded `EN`.
- `item.attributes.przl[0]` = the shipping method's `shipping_method` code (ECO/PRI/…);
  `weight` = shipment weight converted to grams. Throws `RuntimeException` if `shipping_method`
  is unconfigured.
- Dispatches `ShipmentToBarcodeEvent` so subscribers can mutate the payload
  (`getBarcodeData()` / `setBarcodeData()`) before the request.

## Output paths

- **`generateLabels(array $shipments)`** — filters to SwissPost shipments, returns a single PDF,
  or a merged PDF (`mergePdfs()` via `setasign/fpdi`), or `NULL`.
- **`generateLabelResponse(array $shipments)`** — wraps the PDF in a Symfony `Response`
  (`application/pdf`, `Content-Disposition: attachment; filename=SwissPostLabels-<ids>.pdf`).

## Entry points & access

- **Per-shipment operation link** (`commerce_swiss_post_entity_operation`) → route
  `commerce_swiss_post.label` (GET) → `printLabel()`. Requires permission
  `administer commerce_shipment` **and** custom access `checkAccess()` (shipment's plugin is a
  `SwissPost`). On error, messenger error + redirect to the shipment collection.
- **Bulk order action** `GenerateLabelAction` — access `administer commerce_shipment`; gathers
  SwissPost shipments from selected orders, streams the merged PDF via
  `EnforcedResponseException`.

## Lifecycle

`commerce_swiss_post_cron()` deletes stored label files (and clears the field) once the
referenced file is older than 180 days.
