<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BulkGate SMS integrates the BulkGate SMS API into Drupal's SMS Framework as an outbound gateway plugin.
---
The module provides one SMS Framework gateway plugin, `BulkGate` (id `bulkgate`), that sends outgoing messages via the BulkGate PHP SDK (`\BulkGate\Sms\Sender` over `https://portal.bulkgate.com/api/1.0/...`). Administrators add a gateway in the SMS Framework UI and enter their BulkGate Application ID and Application token; an optional static text sender name (3–11 chars) can be configured. When saving with valid credentials the gateway form shows the account's wallet, credit, currency, and free-message balance by calling BulkGate's `simple/info` endpoint. Delivery results are mapped back into SMS Framework report statuses (delivered / invalid recipient / account error).

Operationally this is an outbound-only integration: the plugin implements `send()` and a credit-balance lookup, and defines `outgoing_message_max_recipients = 1`. There is no inbound webhook, delivery-receipt callback, or public route in this module, so there is no callback signature to verify. Security notes: BulkGate credentials are stored in the SMS gateway config entity as plaintext (standard for SMS Framework gateways; protect config exports), and the credit-balance check passes the `application_token` in the URL query string of a GET request (`?application_id=...&application_token=...`), which can surface the token in HTTP client logs. API traffic uses HTTPS with default TLS verification (no `verify => false`).
---
- Enable BulkGate SMS alongside SMS Framework.
- Create a new SMS gateway using the BulkGate plugin.
- Enter your BulkGate Application ID and Application token.
- Verify credentials by checking the wallet/credit shown after saving.
- Set an optional static text sender name (3–11 non-diacritic chars).
- Send outbound SMS (one recipient per message) via SMS Framework.
- Send OTP / verification codes through BulkGate.
- Route site notifications to SMS via this gateway.
- Read remaining credit and free-message balance in the form.
- Map BulkGate errors to SMS Framework delivery statuses.
- Set BulkGate as the default gateway or per phone number.
- Protect config exports since credentials are stored plaintext.
- Prefer this gateway for transactional SMS in BulkGate regions.
- Combine with SMS Framework routing rules for recipient selection.
- Configure multiple BulkGate gateways for different credentials.
- Monitor account balance without leaving the Drupal admin UI.
- Diagnose auth failures via the wallet warning message.
- Use the system sender number by leaving sender type as None.