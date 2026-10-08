<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fast2sms is an SMS Framework gateway plugin that delivers outbound text messages through the Fast2SMS bulk SMS API (India).

---


The gateway plugin (`Plugin/SmsGateway/Fast2sms`) exposes a config form for the Fast2SMS API key, route, and sender id, stored in the SMS Framework gateway configuration entity. On send it POSTs a JSON body (recipient numbers, message, route) to the fixed endpoint `https://www.fast2sms.com/dev/bulkV2` using Drupal's HTTP client, passing the API key in the `authorization` header, and parses the JSON response into an SMS delivery report. TLS uses the Guzzle default (verification on); no `verify=>false`. The API key is held in the gateway config (plaintext), the standard SMS Framework pattern.

Setup: create an SMS Framework gateway of type Fast2sms, enter the API key/route/sender id, set it as the default gateway, and send test messages.
---
- Send SMS through Fast2SMS from Drupal.
- Configure the Fast2SMS API key.
- Set the Fast2SMS route.
- Set the sender id.
- Register Fast2sms as an SMS Framework gateway.
- Set Fast2sms as the default SMS gateway.
- Send bulk SMS to multiple recipients.
- Deliver OTP/notification texts.
- Parse the Fast2SMS response into a delivery report.
- Capture message ids from successful sends.
- Log send errors with status code and message.
- Pass the API key via the authorization header.
- Send over HTTPS to the Fast2SMS endpoint.
- Integrate SMS into SMS Framework workflows.
- Test connectivity with a single recipient.
- Use per-message options merged into the payload.
- Target Indian mobile numbers.
