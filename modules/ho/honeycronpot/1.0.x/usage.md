<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Honeycronpot enhances the Honeypot module's security by dynamically changing the honeypot field name using cron.

---

Honeycronpot enhances the Honeypot spam-protection module — dynamically changing (rotating) the honeypot
field's name on a cron schedule, so spam bots that have learned/hardcoded the static honeypot field name are
defeated by the moving target. It depends on the Honeypot module, in the Spam control package.

Use it alongside Honeypot to make the honeypot harder for bots to adapt to. This is a **positive** anti-spam
hardening: rotating the field name raises the bar for bots that fingerprint the fixed honeypot field. It
complements Honeypot (still keep Honeypot's time-based and honeypot protections), and it has no access-control
role. Enable it with Honeypot and configure the rotation.

---

- Rotate the honeypot field name via cron.
- Harden the Honeypot module.
- Defeat bots that learned the field name.
- Depend on the Honeypot module.
- Provide a moving-target honeypot.
- Raise the bar for adapting bots.
- Complement Honeypot's protections.
- Have no access-control role.
- Configure the rotation.
- Enhance spam protection.
- Enable with Honeypot.
- Rotate honeypot fields.
- Improve anti-spam.
- Handle honeypot rotation.
- Configure rotation frequency.
- Strengthen the honeypot.
- Defeat spam bots.
- Harden anti-spam.
- Rotate field names.
- Enhance Honeypot.
