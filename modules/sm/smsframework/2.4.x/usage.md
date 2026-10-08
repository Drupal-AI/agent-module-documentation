<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMS Framework (module machine name `sms`) is an extensible API that connects Drupal to SMS gateways for sending and receiving text messages. Transport is a pluggable `@SmsGateway` plugin, so a provider like Twilio or Vonage is added as a separate gateway module while your code sends through one stable interface.

---

Many features need to send a text: two-factor codes, order updates, appointment reminders, alerts, bulk announcements. Instead of each feature integrating a provider directly, SMS Framework is the shared layer. You add one or more gateway instances (config entities wrapping a `@SmsGateway` plugin), optionally set a fallback gateway and per-recipient routing via the `MESSAGE_GATEWAY` event, and then send messages either to a raw number or to a user/entity by its stored phone number. Messages flow through `sms.provider` (`queue()` for load-balanced sending via cron, or `send()` for immediate); a queue with per-gateway retention stores and garbage-collects them. Inbound messages and delivery reports are supported where a gateway declares the capability: the gateway module registers push paths and parses the provider's callbacks into framework objects, which are dispatched through events. A phone-number model binds a `telephone` field on any entity bundle to a verification workflow — a generated code is texted to the number and confirmed on a verify page — so features can require a verified number before messaging a user. This is the 2.4.x (v2) plugin architecture supporting Drupal 10.3 and 11; the separate v4 rewrite is built on Symfony Notifier and has no automatic upgrade path. Bundled submodules add bulk send (sms_blast), send-to-phone (sms_sendtophone), Drupal user integration and inbound account registration (sms_user), and developer test tooling (sms_devel).

---

- Send an SMS from Drupal to a phone number.
- Send an SMS to a user or entity by its verified phone number.
- Add a Twilio (or other provider) gateway as a plugin.
- Provide a provider-agnostic SMS API to other modules.
- Route messages to different gateways per recipient.
- Set a fallback gateway for unrouted messages.
- Queue outgoing SMS and send them on cron.
- Send an SMS immediately (skip the queue) for debugging.
- Receive inbound SMS from a gateway callback.
- Handle pushed delivery reports from a gateway.
- Pull delivery reports from a gateway that supports it.
- Bind a telephone field to a user bundle for messaging.
- Verify a user's phone number with a texted code.
- Require a verified phone number before sending 2FA codes.
- Build SMS-based two-factor authentication on top of the API.
- Send appointment reminders or order updates by text.
- Send a bulk SMS blast to all verified users (sms_blast).
- Add a "send to phone" link to nodes and fields (sms_sendtophone).
- Delay messages into a user's active hours (sms_user).
- Auto-create user accounts from inbound SMS (sms_user).
- Simulate sending and receiving messages while developing (sms_devel).
- Define a new SMS gateway plugin with custom capabilities.
- Chunk a message across recipients via a pre-process subscriber.
- Track message status through delivery-report objects.
- Purge and garbage-collect old messages by retention policy.
- Use tokens to build verification and notification messages.
