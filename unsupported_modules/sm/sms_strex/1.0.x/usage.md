<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**SMS Strex** registers the Norwegian [Strex / Target365](https://strex.no) SMS service as an [SMS Framework](https://www.drupal.org/project/smsframework) gateway. It wraps the `target365/api-sdk` PHP client and signs each request with a key name + private key you configure on the gateway. It ships a `hook_requirements` install check and an `sms_strex_out_message_tags` alter hook so other modules can tag outbound messages.

---

The plugin `StrexGateway` (`@SmsGateway id="strex"`, unlimited recipients) reads gateway config `live_mode`, `test_use_log`, `test_phone`, `sms_tags`, `key_name`, `private_key`, `sender`. On `send()` it picks the endpoint by mode — **live** `https://shared.target365.io`, **test** `https://test.target365.io` (both hard-coded HTTPS constants) — and posts an `OutMessage` (sender, recipient, content, tags) via the SDK's `ApiClient`, which handles Target365's signed-request authentication. Test mode adds safety rails: it can reroute every message to a single `test_phone`, or short-circuit to SMS Framework's built-in `log` gateway (`test_use_log`) so nothing is actually sent. Tags are parsed from the comma-separated `sms_tags` setting and passed through `hook_sms_strex_out_message_tags_alter()` before sending. The module has no routes, permissions or config forms of its own — configuration is entirely through the SMS Framework gateway UI. Requires the `target365/api-sdk` Composer library (checked by `hook_requirements`).

---

- Send SMS through Strex / Target365 from any SMS Framework caller.
- Configure the Target365 key name and private key per gateway.
- Set a sender name shown to recipients.
- Switch between live and test Target365 endpoints with one checkbox.
- Reroute all test-mode messages to a single test phone number.
- Divert test sends to SMS Framework's log gateway (send nothing).
- Tag outbound messages for Target365 reporting via the tags field.
- Alter or add message tags programmatically with the alter hook.
- Send to unlimited recipients in one SMS Framework message.
- Deliver OTP / verification codes to Norwegian mobiles.
- Send marketing or transactional SMS campaigns.
- Verify the `target365/api-sdk` library is present via status report.
- Integrate Strex alongside other SMS Framework gateways.
- Report delivery status back to SMS Framework.
- Keep API keys in gateway config rather than code.
- Trigger SMS from ECA/Rules through SMS Framework events.
- Use a per-environment test phone to avoid messaging real users in staging.
