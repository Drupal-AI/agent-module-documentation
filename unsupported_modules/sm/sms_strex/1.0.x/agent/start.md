<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Strex (sms_strex) — agent index

**SMS Framework** (`smsframework:sms`) gateway for Strex / Target365, wrapping `target365/api-sdk`. Version **1.0.3**, core `^8 || ^9 || ^10`.

**Shape:** one class `Plugin/SmsGateway/StrexGateway` (`@SmsGateway id="strex"`). Config: live_mode, test_use_log, test_phone, sms_tags, key_name, private_key, sender. No routes/permissions/forms.

**Endpoints:** live `https://shared.target365.io`, test `https://test.target365.io` — hard-coded HTTPS constants. SDK `ApiClient` signs requests with key_name + private_key. TLS not disabled. Sound.

**Test-mode rails:** `test_use_log` reroutes to SMS Framework's `log` gateway; `test_phone` rewrites all recipients. `hook_sms_strex_out_message_tags_alter()` lets modules tag messages. Requires the `target365/api-sdk` library (`hook_requirements` check).
