<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook — `package_shipped`

Printful reports fulfillment updates to a webhook on the site. The route
`/commerce-printful/webhooks` (`commerce_printful.webhooks`) is registered dynamically by
`src/PrintfulStoreHtmlRouteProvider.php` (not in `*.routing.yml`) and handled by
`src/Controller/PrintfulController::webhooks`. It is a machine-to-machine callback endpoint invoked
by Printful, not a UI route.

## Registration

When you save a `printful_store` with webhook events enabled, `PrintfulStoreForm::save()` calls
`Printful::unsetWebhooks()` then `setWebhooks(['url' => <site host> . '/commerce-printful/webhooks',
'types' => [...]])` (POST `webhooks`). Available event types are fetched live from
`Printful::getWebhooks()`; the store form currently exposes the `package_shipped` event. Operate the
site over **HTTPS** and keep the Printful API key stored as a secret (env var + Key entity).

## Handling

`PrintfulController::webhooks()`:
1. Requires POST (else `BadRequestHttpException`).
2. JSON-decodes the body; requires a non-empty payload and a `type` present in the supported map
   (`METHODS = ['package_shipped' => 'packageShipped']`) — unsupported/missing types are rejected.
3. Dispatches to the mapped handler and returns `200 OK`.

`packageShipped($data)` loads the `commerce_shipment` referenced by
`$data['order']['external_id']` (the shipment id used as Printful's `external_id`) and, if found,
sets the shipped time, tracking code, and shipping service from the event, then saves — so the
shipment reflects Printful's shipping status and carrier/tracking. This is what surfaces tracking
info to the customer.

## Related API methods (`src/Service/Printful.php`)

`getWebhooks` (GET `webhooks`), `setWebhooks` (POST `webhooks`), `unsetWebhooks` (DELETE `webhooks`).
