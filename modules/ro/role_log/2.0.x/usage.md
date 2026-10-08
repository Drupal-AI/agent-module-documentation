<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Log logs user role changes to watchdog, recording when roles are granted or revoked from users.

---

Role Log records user role changes to Drupal's log (watchdog) — every time a role is granted to or
revoked from a user, an entry is written capturing the change. This gives an audit trail of privilege
changes, valuable for security monitoring and accountability (who gained or lost which role, and when).

Use it as a lightweight audit/monitoring aid on sites where role/privilege changes matter (any site
with elevated roles). It is a security/administration feature that only writes log entries; it does not
change roles or access itself. Pair it with log review or forwarding (e.g. to a SIEM) so the audit
trail is actually watched. It has no configuration beyond enabling.

---

- Log user role changes.
- Record role grants and revokes.
- Provide a privilege-change audit trail.
- Write role changes to watchdog.
- Monitor who gained a role.
- Support security monitoring.
- Capture role change events.
- Aid accountability.
- Forward logs to a SIEM.
- Review privilege changes.
- Not change roles itself.
- Only write log entries.
- Track elevated-role assignments.
- Watch for unexpected grants.
- Log revocations.
- Audit access changes.
- Require no configuration.
- Enable role-change logging.
- Improve security visibility.
- Record when roles change.
