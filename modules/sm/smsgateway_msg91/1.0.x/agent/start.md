<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMSGateway MSG91 (smsgateway_msg91) — agent index

MSG91 transactional-SMS gateway for the **SMS Framework** (`drupal:sms`). Version **1.0.0**, core `^9.5 || ^10`, PHP 8.1.

**Shape:** an `SmsGateway` plugin (`MsgAPISmsGateway`) → service `smsgateway_msg91.default` (`MSG91SMSService`) → JSON POST to the configured MSG91 flow URL, auth key in the `authkey` header over Guzzle (TLS on). Config: `msgapi.settings` / `smsgateway_msg91.settings`.

**Config UI:** `/admin/config/smsgateway_msg91/settings` (*administer smsgateway_msg91 site configuration*). Standalone send form `/sendmsg` (permission `msg api access`). Email/SMS template entities at `/admin/structure/msg-api-email-templates`. Two `Action` plugins for VBO/ECA.

**Operating notes:**
1. `msg api access` is referenced by the `/sendmsg` route but is **not defined** in permissions.yml — the route is effectively unreachable until the permission is declared or granted (uid 1 aside).
2. `SendMsgForm::submitForm()` ends in `print_r($status);die;` — debug leftover that dumps the raw MSG91 response and halts the request. Do not rely on that form for production UX.
3. `MSG91SMSService::msg91_send_message()`'s signature and its callers disagree on argument count/order — verify wiring before trusting send results.
