<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a small service for sending SMS messages through the Kaleyra Global Messaging API.

---

The module exposes one injectable service, `kaleyra.sms_api_adapter` (`MessageApiAdapter`), whose `send($to, $message)` method issues a Guzzle GET request to the configured Kaleyra API domain and version with the sender identifier, recipient, message text, API key and unicode mode as query parameters. There is no UI for composing messages and no routes beyond configuration — other modules or custom code call the service to actually send. Failures are caught and written to the `kaleyra` logger channel rather than surfaced to the user.

Configuration lives at `/admin/config/kaleyra` (route `kaleyra.settings`), gated by the `administer kaleyra config` permission. You set the API domain (e.g. `https://api.ap.kaleyra.io`), the API key issued at signup, the sender identifier, and the unicode mode; the API version is fixed to v4. The API key is stored in `kaleyra.settings` config and sent as a query-string parameter over TLS (Guzzle default verification), so treat config exports as sensitive. The maintainers note a plan to make this compatible with the SMS Framework project.

---
- Configure the Kaleyra API domain URL
- Store the Kaleyra API key
- Set the sender identifier shown on outbound SMS
- Choose the unicode mode (0, 1 or auto)
- Send an SMS from custom code via the adapter service
- Send transactional notifications by phone number
- Send one-time passwords or verification codes
- Integrate SMS sending into a custom workflow
- Log failed SMS delivery to the kaleyra channel
- Wrap the Kaleyra HTTP API without writing your own client
- Provide an SMS backend for other modules to call
- Localise messages via auto unicode handling
- Restrict SMS configuration to trusted admins
- Prepare a foundation for SMS Framework integration
- Test connectivity by sending a sample message from code
