<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Twilio Action — the `send_twilio_sms` plugin

## What it is
A single ECA action plugin (`@Action(id = "send_twilio_sms", label = "Send Twilio SMS")`) extending `\Drupal\eca\Plugin\Action\ConfigurableActionBase`.

## Configuration
- **Phone Number** (`phone_number`) — textfield, `#eca_token_replacement = TRUE`.
- **Message** (`message`) — textarea, `#eca_token_replacement = TRUE`.

Both are stored in the action's configuration and rendered with the ECA token-replacement UI.

## Execution
`execute()`:
1. `tokenService->replaceClear()` on `phone_number` and `message`.
2. `html_entity_decode()` on the message (so entities like `&amp;` become `&`).
3. `twilio.sms->messageSend($phone_number, $decoded_message)`.
4. Logs `info` on success, catches `\Exception` and logs `error` on failure — it does not rethrow, so an ECA model continues even if sending fails.

## Prerequisites & setup
1. Enable and configure the **Twilio** module (account SID, auth token, from-number).
2. In an ECA model, add an event/condition as needed, then add the **Send Twilio SMS** action.
3. Fill the number and message using tokens available from the triggering entity/context.

## Notes for agents
- There is no standalone endpoint; the action only fires from ECA.
- Failures are swallowed (logged, not thrown) — check the `eca_twilio_action` log channel to confirm delivery attempts.
