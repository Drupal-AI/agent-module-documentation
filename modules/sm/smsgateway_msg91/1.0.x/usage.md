<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**SMSGateway MSG91** plugs the Indian [MSG91](https://msg91.com) transactional-SMS API into Drupal's [SMS Framework](https://www.drupal.org/project/smsframework) (`drupal:sms`). It registers a `SmsGateway` plugin (`MsgAPISmsGateway`) so any SMS Framework send goes through MSG91, plus a standalone admin *Send SMS* form, MSG91 flow/template management, and content-action / ECA hooks so other modules can trigger an SMS.

---

The gateway plugin `MsgAPISmsGateway` delegates to the `smsgateway_msg91.default` service (`MSG91SMSService`), which POSTs a JSON payload to the configured MSG91 flow endpoint (`msgapi_auth_url`) with the account **auth key** sent in the `authkey` HTTP header via Guzzle (`@http_client`, default TLS verification on). Settings live in config `msgapi.settings` / `smsgateway_msg91.settings` (auth key, flow/template id, country prefix, short-url and real-time-response flags) behind the `smsgateway_msg91.settings` route (`/admin/config/smsgateway_msg91/settings`, permission *administer smsgateway_msg91 site configuration*). A `SendMsgForm` at `/sendmsg` is gated by the permission `msg api access` — note that permission string is referenced in routing but is **not declared** in `smsgateway_msg91.permissions.yml`, so with a stock install no role can be granted it and the route is effectively locked to nobody (uid 1 bypass aside). The module also defines an `EmailTemplates` config entity (list/add/edit at `/admin/structure/msg-api-email-templates`) and two `Action` plugins (`SendMsg91SMS`, `SendMsg91SMSTemplate`) for use from Views Bulk Operations / ECA. Declared permissions: *Execute Custom Email Action*, *Execute Custom ECA Action*, *Administer email templates* (all `restrict access: TRUE`).

---

- Send transactional SMS through MSG91 from any SMS Framework caller.
- Configure the MSG91 auth key, flow/template id and country code in admin settings.
- Route Drupal's SMS Framework default gateway to MSG91.
- Send a one-off test message from the `/sendmsg` admin form.
- Send OTP / verification codes via a MSG91 flow template.
- Prepend a country dialing prefix to recipient numbers automatically.
- Store reusable email/SMS template entities for repeated campaigns.
- Manage MSG91 templates from the admin *SMS Templates* screen.
- Trigger an SMS from a Views Bulk Operations action on selected users/nodes.
- Fire an SMS from an ECA model on a Drupal event (e.g. user registration).
- Send a template-based SMS action rather than a free-text body.
- Toggle MSG91 real-time-response and short-URL flags per send.
- Restrict who may administer email templates via a dedicated permission.
- Gate custom email/ECA send actions behind restricted permissions.
- Notify site users of order/account events over SMS.
- Integrate MSG91 alongside other SMS Framework gateways for failover.
- Log send failures to the `smsgateway_msg91` logger channel.
- Use MSG91 flow ids to comply with DLT template regulations in India.
