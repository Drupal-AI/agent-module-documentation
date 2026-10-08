SMS Framework is an extensible API layer between Drupal and SMS gateway providers: it defines gateway plugins, SMS message entities, a send/queue pipeline, per-entity phone-number fields with verification, and incoming-message / delivery-report handling.

---

The module's core abstraction is the `sms_gateway` plugin type (annotation `@SmsGateway`, manager `plugin.manager.sms_gateway`); each gateway is also a `sms_gateway` config entity holding the chosen plugin id and its settings. A bundled `log` gateway (writes messages to the Drupal log, marks them delivered) is installed by default and set as the fallback gateway. Outgoing messages are represented as `SmsMessage` value objects or `sms` content entities and sent through `SmsProviderInterface` (`sms.provider`), which dispatches events (`SmsEvents`: message pre/post-process, gateway selection, delivery-report post-process, entity phone numbers) via event subscribers before handing off to the gateway's `send()`; a queue worker (`SmsProcessor`) and `SmsQueueProcessor` handle deferred/scheduled sends. Phone numbers are attached to any entity bundle through `phone_number_settings` config entities (which reference a telephone field and store verification message, code lifetime, and purge options); `PhoneNumberVerification` generates random codes, sends them, and the `/verify` form (`VerifyPhoneNumberForm`, flood-limited) marks numbers verified. Incoming messages and pushed delivery reports are received on gateway-specific routes generated dynamically by `RouteSubscriber` from each gateway's configured paths (`incoming_push_path`, `reports_push_path`); the incoming route is public (gateways authenticate their own callbacks), the delivery-report route is guarded by a "supports pushed reports" access check. It relies on `dynamic_entity_reference` so a phone-number verification can point at any entity type, and on core `telephone`. Global settings (`sms.settings`) cover the fallback gateway, the verify page path, and flood limits. Four optional submodules add bulk send (sms_blast), dev tooling (sms_devel), node-to-SMS sharing (sms_sendtophone), and user integration incl. SMS-driven account registration and active-hours delays (sms_user).

---

- Integrate Drupal with a third-party SMS gateway by installing that gateway's plugin module.
- Send an outgoing SMS to one or more phone numbers from code via `sms.provider`.
- Queue SMS messages for background/cron delivery instead of sending inline.
- Send scheduled SMS via schedule-aware gateways.
- Attach a verified phone-number field to users (or any entity bundle).
- Send a one-time verification code and confirm a phone number at `/verify`.
- Flood-limit verification attempts to resist brute forcing codes.
- Receive incoming SMS on a per-gateway public webhook route.
- Receive pushed delivery reports from a gateway and record status.
- Pull delivery reports or credit balance from gateways that support it.
- Use the built-in `log` gateway to develop/test without a real provider.
- Configure a fallback gateway used when nothing else selects one.
- Route different recipients to different gateways via the MESSAGE_GATEWAY event.
- Modify or chunk messages before/after processing via events.
- Store SMS messages as entities for reporting and Views.
- Expose phone numbers for an entity through the ENTITY_PHONE_NUMBERS event.
- Send a bulk "SMS blast" to all users with a verified number (sms_blast).
- Send a node or highlighted text to a phone via a link/filter (sms_sendtophone).
- Auto-create Drupal accounts from incoming SMS (sms_user account registration).
- Delay outgoing SMS outside configured "active hours" (sms_user).
- Test sending/receiving messages from an admin form (sms_devel).
- Set per-gateway retention durations for incoming/outgoing message entities.
- Migrate Drupal 6/7 SMS phone numbers via the bundled migrations.
- Build OTP / two-factor style phone verification flows.
