<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Kaleyra (kaleyra) — agent index
**Service wrapper that sends SMS through the Kaleyra messaging API.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Config route:** `kaleyra.settings` at `/admin/config/kaleyra`
- **Permission:** `administer kaleyra config`
- **Service:** `kaleyra.sms_api_adapter` → `MessageApiAdapter::send($to, $message)` (Guzzle GET to `{api_domain}/{api_version}`)
- **Config object:** `kaleyra.settings` (api_domain, api_key, api_version, sender_identifier, unicode)

**Security:** admin-only config route; no public/anonymous endpoints and no mutating routes. Outbound-only. API key stored in config and passed as a query parameter over TLS (Guzzle default verification) — config export is sensitive.

See [api/send.md](api/send.md)
