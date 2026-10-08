<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Powerling API integration & callbacks

## Outbound (Drupal → Powerling)
`PowerlingTranslator` (`src/Plugin/tmgmt/Translator/PowerlingTranslator.php`) performs all API calls via `@http_client`:
- Auth: `Authorization: Bearer <token>` header, token from translator setting (`PowerlingTranslator.php:273`).
- `getOrder($translator, $orderId)` — fetch an order's status.
- `updateTranslation($jobItem, $orderId, $fileId)` — download and import a translated file.
- TLS: Guzzle defaults (verification enabled; not disabled anywhere).

## Inbound callbacks (Powerling → Drupal)
Both routes are `_access: 'TRUE'` (anonymous) by design, so Powerling can ping the site:

| Route | Path | Handler |
|---|---|---|
| order_callback | `/tmgmt_powerling/callback/order/{tmgmt_job}/{order_id}` | `PowerlingController::orderCallback` |
| file_callback | `/tmgmt_powerling/callback/file/{tmgmt_job_item}/{order_id}/{file_id}` | `PowerlingController::fileCallback` |

### Why the anonymous access is safe
The callbacks are *triggers*, not data sinks:
1. Each first checks `getTranslatorPlugin() instanceof PowerlingTranslator`; otherwise `NotFoundHttpException`.
2. `orderCallback` then calls `getOrder()` to **re-fetch** the real status from Powerling (authenticated) and only reacts to that (`abortJob` on `canceled`).
3. `fileCallback` calls `updateTranslation()` to **re-pull** the file from Powerling.

No order status, translation content, or entity state is taken from the request body — the request cannot inject a forged translation or status. The only abuse is triggering a redundant authenticated fetch by guessing valid ids.
