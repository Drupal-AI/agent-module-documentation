# Configuration

SMS Strex has no settings page of its own — you configure it entirely by adding a
gateway to the **SMS Framework**, which is where its fields appear.

## Add the gateway

1. Log in as a user who can administer SMS Framework.
2. Go to **Configuration → SMS & messaging → Gateways**.
3. Add a new gateway and choose the **Strex** plugin. (The Strex gateway accepts
   an unlimited number of recipients per message.)

## Fields

The Strex gateway stores the following settings:

- **Key name** (`key_name`) — your Target365 API key name.
- **Private key** (`private_key`) — your Target365 private key. Together with the
  key name, the SDK uses these to sign each request to Target365. Keep them
  secret.
- **Sender** (`sender`) — the sender name shown to recipients.
- **Live mode** (`live_mode`) — a single checkbox that switches between the live
  Target365 endpoint (`https://shared.target365.io`) and the test endpoint
  (`https://test.target365.io`). Both are hard‑coded HTTPS addresses.
- **Test: use log gateway** (`test_use_log`) — in test mode, divert sends to SMS
  Framework's built‑in `log` gateway so that **nothing is actually sent** — the
  messages are just logged.
- **Test phone** (`test_phone`) — in test mode, reroute **every** message to this
  single phone number, so you can safely try real delivery to yourself without
  messaging real users.
- **SMS tags** (`sms_tags`) — a comma‑separated list of tags attached to outbound
  messages for Target365 reporting.

Save the gateway, then set it as the SMS Framework **default** (or route specific
numbers to it).

## Live vs. test mode

The two test‑mode rails are there to keep staging safe:

- Leave **Live mode** off while testing. Then either tick **Test: use log
  gateway** so nothing leaves Drupal, or set a **Test phone** so all messages go
  to one number you control.
- Turn **Live mode** on only when you're ready to send to real recipients through
  Strex's live endpoint.

## Tagging outbound messages

Tags entered in **SMS tags** are parsed from the comma‑separated value and passed
through Strex before sending, which is useful for Target365's invoicing,
re‑invoicing, and statistics. Developers can add or change these tags
programmatically via the module's `hook_sms_strex_out_message_tags_alter()` hook.
