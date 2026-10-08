<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BulkGate SMS Module (bulkgate_sms) — agent index
**Outbound SMS Framework gateway plugin for the BulkGate API.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10 || ^11
- **Requires:** smsframework:sms
- **Plugin:** `BulkGate` (`@SmsGateway`, id `bulkgate`, `outgoing_message_max_recipients = 1`)
- **Config (gateway entity):** `app_id`, `app_token`, `static_sender_type`, `static_sender_name`
- **API:** `https://portal.bulkgate.com/api/1.0/...` via BulkGate PHP SDK; balance via `simple/info`
- **Security:** Outbound-only — no inbound webhook/route, so no callback signature to verify. Credentials stored plaintext in the gateway config entity (protect config exports). `getCreditBalance()` sends `application_token` in the GET query string (`BulkGate.php:251`) — may leak into HTTP logs. HTTPS with default TLS verification (no verify=>false).

See [configure/gateway.md](configure/gateway.md)