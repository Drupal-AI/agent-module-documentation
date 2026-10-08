<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SMTP Authentication Support (multiple) allows SMTP configurations on a per email key basis, so different mails use different SMTP servers.

---

SMTP Authentication Support (multiple) extends the SMTP module to allow different SMTP configurations
per email key — so different types of outgoing mail (e.g. transactional vs marketing, or per-module mail)
can be sent through different SMTP servers/accounts. It depends on the SMTP module.

Use it where different mail streams should use different SMTP servers. The security-relevant point is
credentials: each SMTP configuration includes server credentials (username/password) — store them as secrets
(not plaintext config), and ensure SMTP connections use TLS/STARTTLS. It is a mail/developer feature with no
content-access role. Configure the per-key SMTP settings.

---

- Use per-key SMTP configurations.
- Route different mail via different SMTP.
- Separate transactional/marketing mail.
- Depend on the SMTP module.
- Store SMTP credentials as secrets.
- Use TLS/STARTTLS for SMTP.
- Configure per email key.
- Have no content-access role.
- Handle multiple SMTP servers.
- Route mail by key.
- Configure per-key SMTP.
- Handle credentials securely.
- Send via different accounts.
- Separate mail streams.
- Configure SMTP per module.
- Use multiple SMTP configs.
- Handle mail routing.
- Secure SMTP credentials.
- Configure the SMTP settings.
- Route by mail key.
