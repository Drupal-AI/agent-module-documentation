<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User inactivity revoke roles auto-removes roles from users who have been inactive.

---

User inactivity revoke roles automatically revokes roles from users based on a period of inactivity — so elevated/privileged roles are stripped from accounts that haven't logged in for a configured duration, reducing the attack surface of dormant privileged accounts (a security hygiene / least-privilege measure).

Configure which roles and inactivity thresholds carefully so legitimate infrequent users aren't disrupted. It's a security/administration feature. Depends on core `user`; supports Drupal 10.3+, 11, and 12.

---

- Revoke roles on inactivity.
- Auto-remove roles from dormant accounts.
- Reduce dormant-account attack surface.
- Enforce least privilege.
- Strip privileged roles from inactive users.
- Configure roles and thresholds.
- Avoid disrupting infrequent users.
- Support security hygiene.
- Depend on core `user`.
- Support Drupal 10.3+, 11, and 12.
- Run on cron.
- Track last-login.
- Harden privileged accounts
- Configure inactivity period
- Support least privilege.
- Manage role lifecycle.
- Improve security posture.
- Revoke on cron
