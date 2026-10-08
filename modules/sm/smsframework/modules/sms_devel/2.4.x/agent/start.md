<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Devel (sms_devel) — agent index

Submodule of **SMS Framework** ([parent docs](../../../../2.4.x/agent/start.md)). A developer/testing
tool: one form to **simulate sending or receiving** an SMS through any configured gateway (including
the bundled `log` gateway) and inspect the result. Depends on `smsframework:sms`. No config, no
settings page.

- **The test form, its route and permission, send vs receive** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Route `sms_devel.message` → `/admin/config/development/sms`
  (`Drupal\sms_devel\Form\SmsDevelMessageForm`, id `sms_devel_message_form`), permission
  **`sms_devel form`**.
- Send/Receive buttons: **Send** routes an outgoing message (auto or chosen gateway); **Receive**
  simulates an inbound message (a gateway must be chosen).
- Options: force skip-queue (immediate), flag automated, `send_on` schedule, verbose result table.
- Calls the parent `sms.provider` (`send()` / `incoming()` / `queue()`) and renders the returned
  `SmsMessageResult` + delivery reports.
