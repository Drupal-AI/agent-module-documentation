<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# engageSPARK (sms_engagespark) — agent index
**SMS Framework gateway plugin that sends SMS via the engageSPARK API.**

- **Version:** 2.x
- **Core:** ^10 || ^11
- **Depends on:** smsframework (sms); composer: giggsey/libphonenumber-for-php
- **Service:** `sms_engagespark.third_party_plugin.paramconverter` (paramconverter tag).
- **Configuration:** via SMS Framework gateways UI (`/admin/config/smsframework/gateways`) — no dedicated form in this module.

**Security:** a finding is recorded for this module in its local `security.md` (do not modify). Review it before production use. No admin routes are added by this module itself; credentials are entered on the SMS Framework gateway config.
