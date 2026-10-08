<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Secure Password Reset Log adds logging, monitoring and flood control to password resets.

---

Secure Password Reset Log logs and monitors password-reset requests with enhanced security — recording reset attempts and applying flood control to limit abuse (reset-flooding / user enumeration). It gives operators visibility into reset activity and hardens the reset flow, a defensive security feature.

Permissions cover viewing logs (`view secure password reset logs`) and administration (`administer secure password reset logs`). Because reset logs are security-sensitive, restrict viewing to trusted roles. Depends on core `user`; requires Drupal 11.

---

- Log password-reset requests.
- Monitor reset activity.
- Apply flood control.
- Limit reset abuse.
- Mitigate user enumeration.
- Harden the reset flow.
- Give operators visibility.
- Gate viewing with `view secure password reset logs`.
- Gate admin with `administer secure password reset logs`.
- Restrict log viewing to trusted roles.
- Depend on core `user`.
- Require Drupal 11.
- Act as a defensive feature.
- Track reset attempts.
- Improve reset security.
- Audit resets
- Rate-limit resets
- Support security monitoring
