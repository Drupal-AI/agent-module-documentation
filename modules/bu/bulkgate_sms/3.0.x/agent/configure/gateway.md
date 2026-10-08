<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the BulkGate gateway

**Prereq:** SMS Framework (`sms`) enabled.

1. Go to the SMS Framework gateways UI (`/admin/config/smsframework/gateways`) and **Add gateway**, choosing the **BulkGate** plugin.
2. Enter **Application ID** (`app_id`) and **Application token** (`app_token`) from your BulkGate portal.
3. Save. With valid credentials the form shows wallet, credit, currency, and free-message counts (fetched from BulkGate `simple/info`). If it shows "Can't connect...", re-check the credentials.
4. (Optional) Set **Sender type** = Text sender and a **Sender name** of 3–11 non-diacritic characters.
5. Set the gateway as default or bind it to specific numbers via SMS Framework routing.

## Behavior
- `send()` sends to a single recipient (`outgoing_message_max_recipients = 1`) through the BulkGate SDK `Sender`, mapping HTTP 400 → invalid recipient and 401 → account error.
- No inbound delivery-report route is registered by this module.

## Security
- Credentials live in the gateway config entity as plaintext — keep them out of public config exports.
- `getCreditBalance()` (`src/Plugin/SmsGateway/BulkGate.php:246-262`) puts `application_token` in the request URL query string; be aware it can appear in HTTP client / proxy logs.
