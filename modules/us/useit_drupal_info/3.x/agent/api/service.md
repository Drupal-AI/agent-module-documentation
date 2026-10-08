<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Useit Drupal Info — data service & payload

## Service
- **Id:** `useit_drupal_info.service` (`useit_drupal_info.services.yml`).
- **Class:** `Drupal\useit_drupal_info\Service\UseitDrupalInfoService`.
- **Args:** `@state`, `@config.factory`, `@http_client` (Guzzle `ClientInterface`), `@logger.factory`
  (logger channel `useit_cron`).
- **Entry point:** `checkAndSendData()`, called from `useit_drupal_info_cron()` each cron run.

## Control flow (`checkAndSendData()`)
1. Read state `useit_drupal_info.cron_last` (default 0) and config
   `useit_drupal_info.post_destination_settings:cron_interval`.
2. **Throttle:** if `time() - cron_last <= cron_interval`, return (no send).
3. `include_once` core `update.compare.inc` + `update.module`, then call
   `update_get_available(TRUE)` and `update_calculate_project_data()` to get per-project data.
4. If `$projects['drupal']` is missing, return.
5. Build a `modules` array from every non-`drupal` project; build the top-level Drupal/PHP fields.
6. POST the payload as JSON to config `destination_url` with header `X-Drupal-Key: <api_key>`.
7. On success, log the response body (info); on exception, log the error — both to channel
   `useit_cron`. Log messages are partly in Spanish ("Respuesta de la solicitud POST", "Error en...").
8. Always set state `useit_drupal_info.cron_last = time()` at the end.

## Payload shape (JSON body)
```json
{
  "version": "11.1.0",              // $projects['drupal']['existing_version'] or "N/A"
  "php_version": "8.3.x",           // phpversion()
  "recommended_version": "11.1.0",  // recommended release version, falls back to version
  "link": "https://site/base",      // scheme+host+base path of the current request
  "name": "Site name",              // system.site:name
  "status": 0,                      // Drupal project update status code
  "modules": [
    {
      "name": "token",
      "version": "8.x-1.15",        // existing_version
      "recommended": "8.x-1.15",
      "last": "8.x-1.15",           // latest_version
      "status": 5                   // per-project update status code
    }
  ]
}
```

## Request headers
`Content-Type: application/json`, `Accept: application/json`,
`X-Drupal-Key: <api_key ?? "">`, and a spoofed desktop-Chrome `User-Agent`
(hard-coded in the service "to avoid Cloudflare blocking").

## Notes
- Transport is Guzzle `$http_client->post()`; TLS verification is Guzzle's default (enabled) — the
  module does not pass `verify => false`.
- Destination scheme is whatever the admin typed (`destination_url` is a plain textfield); use HTTPS.
- The payload is a full module+version+update-status inventory of the site — treat the receiver as
  trusted infrastructure.
