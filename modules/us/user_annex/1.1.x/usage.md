<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User annex logs user-record changes as user_annex entities for an audit trail.

---

User annex tracks changes to user records by recording details in a custom `user_annex` entity — creating an audit trail of modifications to user accounts (fields changed, when, by whom), useful for compliance and security monitoring of account changes.

It exposes CRUD permissions on user_annex entities (`administer`/`add`/`view`/`edit`/`delete user_annex entities`). Because annex records can contain user data, restrict viewing to trusted roles. Depends on core `user`; supports Drupal 9, 10, and 11.

---

- Track changes to user records.
- Record details in a user_annex entity.
- Create a user-change audit trail.
- Support compliance/security.
- Capture what changed on accounts.
- Gate CRUD with user_annex permissions.
- Restrict viewing to trusted roles.
- Depend on core `user`.
- Support Drupal 9, 10, and 11.
- Monitor account changes.
- Log user modifications.
- Aid accountability.
- Audit user data
- Configure tracking
- Handle sensitive user data.
- Review change history.
- Store annex records.
- Track accounts
