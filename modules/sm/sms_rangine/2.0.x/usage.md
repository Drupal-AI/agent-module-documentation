<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**SMS Rangine** is a single-plugin bridge that registers the Iranian [Rangine](https://sms.rangine.ir) SMS service as a gateway for the [SMS Framework](https://www.drupal.org/project/smsframework) (`sms`). Once enabled you add a Rangine gateway in *Admin » Config » SMS » Gateways*, enter your Rangine username, password, sender line and API host, and all SMS Framework sends can be routed through it.

---

The gateway plugin `RangineGateway` (`@SmsGateway id="rangine"`) stores per-gateway config: `user`, `pass`, `sender`, `confirm` message, `host` (default `sms.rangine.ir`) and a `debug` flag, described by `config/schema/sms_rangine.schema.yml`. On `send()` it builds a request from the message and recipients and calls a private `cUrl()` helper (raw PHP cURL, 20s connect / 25s timeout). Two paths exist: a **normal** send POSTs form fields (`uname`, `pass`, `from`, `to`, `message`, `op=send`) to `{host}/services.jspd`; a **pattern** send (message beginning `pcode:` / `patterncode:`) GETs `{host}/patterns/pattern?username=...&password=...&from=...&to=...&input_data=...&pattern_code=...`. Responses are decoded and mapped to SMS Framework delivery statuses, with a large Persian-language error-code table. **Transport caveat:** the default `host` has no URL scheme, so cURL falls back to plain **HTTP** and, in pattern mode, the account username/password travel as URL query parameters — configure `host` as `https://sms.rangine.ir` to avoid sending credentials in cleartext. The module has no routes, services, permissions or blocks of its own.

---

- Send SMS through the Rangine gateway from any SMS Framework caller.
- Configure Rangine username, password and sender line per gateway.
- Route the site's default SMS gateway to Rangine.
- Send a plain text message to one recipient.
- Send a pattern/template SMS using a `pcode:`-prefixed body.
- Pass template variables to a Rangine pattern via `key:value;` pairs.
- Show a custom confirmation message after a successful send.
- Enable debug mode to preview the outbound message without sending.
- Map Rangine numeric error codes to human-readable (Persian) messages.
- Set the API host to an HTTPS endpoint to protect credentials in transit.
- Deliver OTP / verification codes to Iranian mobile numbers.
- Send order or appointment reminders over SMS.
- Integrate Rangine alongside other SMS Framework gateways.
- Report queued / delivered / rejected status back to SMS Framework.
- Use per-gateway sender lines for different message classes.
- Rely on SMS Framework's UI for gateway selection and message logging.
- Send notification SMS triggered by Rules/ECA via SMS Framework events.
