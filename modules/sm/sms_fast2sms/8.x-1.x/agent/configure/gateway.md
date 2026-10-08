<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Fast2sms gateway

## Create the gateway
In SMS Framework (Admin → Config → SMS/Telephony → Gateways), add a gateway using the **Fast2sms**
plugin. Fields (`Plugin/SmsGateway/Fast2sms`):
- **api_key** — Fast2SMS API key (sent as the `authorization` header).
- **route** — Fast2SMS route.
- **sender_id** — sender id.
These are stored in the gateway config entity (`account.*`).

## Sending
`send()` POSTs JSON `{numbers, message, route, ...account, ...options}` to
`https://www.fast2sms.com/dev/bulkV2` via the Drupal HTTP client and maps the JSON response
(`return`, `request_id`, `status_code`, `message`) into an SMS delivery report.

## Notes
- Set this gateway as the site default to route all SMS through Fast2SMS.
- TLS: Guzzle default verification (on). Endpoint is fixed.
- The API key lives in gateway config (standard for SMS Framework).
