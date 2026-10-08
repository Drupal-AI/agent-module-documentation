<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A gateway plugin for the SMS Framework (`sms`) that delivers text messages and retrieves balance and delivery reports through the SMS.ru HTTP API.

---

The module registers an `smsru` SMS gateway plugin. Once the SMS Framework is installed and this gateway is added and set as default, any Drupal feature that sends SMS through the framework routes messages to SMS.ru. Requests go over HTTPS to `https://sms.ru` via Guzzle (POST with query params, `json=1`); TLS verification is left at Guzzle's secure default. Authentication supports two methods chosen on the gateway form: an **API ID** (recommended) or **login + password**. Credentials are stored in Drupal `state` (`smsru.smsframework.auth_settings`), the API-ID field is displayed masked, both secret fields are `password` inputs, and a "forget credentials" checkbox clears them.

The gateway maps SMS.ru status codes to framework delivery statuses (queued/delivered/expired/rejected/invalid-recipient/…), supports a test mode (messages appear in the SMS.ru account but are not sent), reports the account credit balance, and can set a sender name. A rich standalone `SmsRu` API client class wraps the wider SMS.ru surface — cost, limits, senders, stop list, callback URLs and call-check — for programmatic use. Note the `.info.yml` only declares a core dependency; the SMS Framework (`drupal/sms`) is a required runtime companion for the gateway plugin to be usable.

---
- Send outbound SMS through SMS.ru from any SMS Framework feature
- Add an `smsru` gateway under the SMS Framework and set it as default
- Authenticate with an SMS.ru API ID (recommended)
- Authenticate with SMS.ru login and password instead
- Store credentials in state with a masked/`password` display
- Clear stored credentials with the "forget credentials" toggle
- Send in test mode so messages show in the account without dispatch
- Set a custom sender name (`from`) on outgoing messages
- Read the account credit balance via the gateway
- Fetch and map delivery reports for sent messages
- Check the cost of a message before sending (API client)
- Query daily and free SMS limits (API client)
- List approved sender names (API client)
- Add or remove numbers on the SMS.ru stop list (API client)
- Register or delete delivery callback URLs (API client)
- Run a call-check verification flow (API client)
- Verify credentials with the auth-check call
- Transliterate or schedule messages via the Message object options
- Route password-reset / 2FA / notification SMS to Russian recipients
