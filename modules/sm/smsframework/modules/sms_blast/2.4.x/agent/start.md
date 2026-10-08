<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS Blast (sms_blast) — agent index

Submodule of **SMS Framework** ([parent docs](../../../../2.4.x/agent/start.md)). Adds one bulk-send
form: enter a message, and it is texted to **every registered user with a verified phone number**
(one message per user). No settings page. Depends on `smsframework:sms` and core `user`.

- **The blast form, its route and permission, how the send works** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Route `sms_blast.blast` → `/sms_blast`, form `Drupal\sms_blast\SmsBlastForm` (id `sms_blast_form`),
  gated by permission **`Send SMS Blast`**.
- Recipients = verified `sms_phone_number_verification` records where `entity__target_type = user`
  and `status = 1`; deduplicated per user.
- Sends via the parent `sms.phone_number` provider (`PhoneNumberProvider::sendMessage()`), which
  queues each message — so actual delivery happens through the framework queue/gateway.
