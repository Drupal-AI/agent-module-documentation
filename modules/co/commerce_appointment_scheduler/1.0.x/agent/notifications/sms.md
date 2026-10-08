<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Optional Twilio store SMS notifications

`AppointmentNotificationManager` (`commerce_appointment_scheduler.notification_manager`,
args `@config.factory`, `@http_client`, `@logger.factory`) texts the **store** when an order
containing an appointment is placed. Entirely optional and off by default.

## Trigger

`commerce_appointment_scheduler_commerce_order_presave()` (`.module`):
- returns if `commerce_appointment_scheduler_sms_sent` order data is already set (send-once guard),
- returns if the order state is `draft`, `canceled`, or `cancelled`,
- requires `hasAppointmentItems($order)` (any order item with a non-empty `field_appointment_start`),
- calls `sendStoreAppointmentNotification()`; on success stamps
  `setData('commerce_appointment_scheduler_sms_sent', time())`.

So the SMS fires when an appointment order first reaches a non-draft state, once per order.

## Configuration gate

`isConfigured()` requires `sms_notifications_enabled` true **and** all of `sms_store_number`,
`sms_twilio_account_sid`, `sms_twilio_auth_token`, `sms_twilio_from_number` present (numbers passed
through `normalizePhoneNumber`). Configured on the settings form — see
[config/settings.md](../config/settings.md).

## Delivery

`sendStoreAppointmentNotification()` POSTs to
`https://api.twilio.com/2010-04-01/Accounts/{SID}/Messages.json` via the injected Guzzle
`http_client` with HTTP Basic `auth => [account_sid, auth_token]`, `form_params` `To`/`From`/`Body`,
`timeout => 15`. TLS verification is left at Guzzle defaults (on). 2xx → returns TRUE; non-2xx logs a
`warning`, thrown exceptions log an `error` (channel `commerce_appointment_scheduler`) and return FALSE
(no retry).

`buildStoreNotificationMessage()` builds a plain-text body: `New appointment {order} for {email}.`
followed by `; `-joined per-item segments `"{product} {n/j g:iA}-{g:iA} {tz}[ @ location]"`, times
converted from stored UTC to the item's timezone. Truncated to 1500 chars (`mb_strimwidth`).

`normalizePhoneNumber()` — keeps a leading `+` then digits; a bare 10-digit US number becomes `+1…`,
an 11-digit `1…` becomes `+…`, otherwise `+{digits}`.

Note: the Twilio SID/token live in plain module config (not a Key entity); restrict the
`administer commerce appointment scheduler` permission accordingly.
