<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fast2sms (sms_fast2sms) — agent index

**SMS Framework gateway that sends texts via the Fast2SMS bulk API.**

- **Version:** 8.x-1.x (8.x-1.0-alpha3)
- **Core:** ^8 || ^9 || ^10 || ^11 — requires `smsframework` (`sms`).
- **Plugin:** `Fast2sms` SmsGateway (`src/Plugin/SmsGateway/Fast2sms.php`).
- **Endpoint:** fixed `https://www.fast2sms.com/dev/bulkV2` (POST JSON). API key sent in `authorization` header.
- Config (api_key/route/sender_id) stored in the SMS Framework gateway entity.

**Transport:** HTTPS with Guzzle default TLS verification; endpoint is fixed. API key is stored in the gateway config (standard SMS Framework pattern — no Key entity). See [configure/gateway.md](configure/gateway.md).
