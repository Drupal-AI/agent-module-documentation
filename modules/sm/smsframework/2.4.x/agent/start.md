<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Framework (smsframework) — agent index

Module machine name **`sms`**. An extensible API for sending and receiving SMS. Actual SMS
transport is a **pluggable `@SmsGateway` plugin** (real gateways ship as separate modules); the
framework adds gateway routing/fallback, a send queue, inbound message + delivery-report handling,
and a phone-number/entity **verification** flow. This is the **2.4.x = v2 plugin architecture**
(D10.3/D11); v4 is a separate Notifier-based rewrite with no auto-upgrade.

Depends on core `system` + `telephone` and contrib `dynamic_entity_reference`. Configure route
`sms.admin` → `/admin/config/smsframework`. Defines permissions and a plugin type; **no Drush**.
Bundled submodules: `sms_blast`, `sms_sendtophone`, `sms_user`, `sms_devel`.

- **Send an SMS (to a number, or to a user/entity by verified phone), queue vs immediate, inbound & delivery-report flow** → [api/services.md](api/services.md)
- **Define / add an SMS gateway plugin, its annotation capabilities, the bundled `log` gateway** → [plugins/gateway.md](plugins/gateway.md)
- **Gateways, settings (fallback gateway, flood, verify page), phone-number settings, config entities/schema, set via drush/PHP** → [configure/settings.md](configure/settings.md)
- **Events to hook message/gateway/phone-number/report processing** → [events/events.md](events/events.md)
- **The `hook_sms_gateway_info_alter` alter hook + cron behaviour** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Services: `sms.provider` (`DefaultSmsProvider`: `queue()`, `send()`, `incoming()`,
  `processDeliveryReport()`), `sms.phone_number` (`PhoneNumberProvider`: `getPhoneNumbers()`,
  `sendMessage()`), `sms.phone_number.verification` (`PhoneNumberVerification`), `sms.queue`
  (`SmsQueueProcessor`), `plugin.manager.sms_gateway`.
- Plugin type: **`sms_gateway`** — manager `plugin.manager.sms_gateway`, base
  `Drupal\sms\Plugin\SmsGatewayPluginBase`, annotation `@SmsGateway` (`Drupal\sms\Annotation\SmsGateway`),
  discovered under `Plugin/SmsGateway`. Bundled plugin id `log` (`LogGateway`).
- Config: `sms.settings` (`fallback_gateway`, `flood.verify_limit`=5, `flood.verify_window`=21600,
  `page.verify`=`/verify`); config entities `sms.gateway.*` (`sms_gateway`), `sms.phone.*.*`
  (`phone_number_settings`). Content entities: `sms` (SmsMessage), `sms_result`, `sms_report`,
  `sms_phone_number_verification`.
- Value object: `Drupal\sms\Message\SmsMessage` (recipients, message, gateway, direction, options,
  result); entity form of it: `Drupal\sms\Entity\SmsMessage`.
- Permissions: `administer smsframework` (restricted), `sms verify phone number`.
- Events: `Drupal\sms\Event\SmsEvents` (`MESSAGE_*`, `MESSAGE_GATEWAY`, `DELIVERY_REPORT_POST_PROCESS`,
  `ENTITY_PHONE_NUMBERS`).
- Field widget `sms_telephone`; views field `sms_message_direction`; tokens `[sms:*]`, `[sms-message:*]`.
