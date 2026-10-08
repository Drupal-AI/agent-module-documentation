<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Test Accounts creates test user accounts per role, to make testing role-based behaviour easier during development.

---

Role Test Accounts creates a test user account for each role on the site, so developers can quickly
log in as a representative of any role to test role-based behaviour, permissions and displays. It
depends on core User and is configured at `role_test_accounts.settings`.

**Development use only — do not enable on production.** By design it creates real user accounts that
hold site roles (potentially including privileged ones), which are extra credentialed accounts and thus
an access-risk surface if they exist on a live site (especially with weak/known passwords). This is the
same class of dev/QA convenience as test-account generators: extremely useful on local/staging, but it
must be kept out of production, and any test accounts must be removed before go-live. Treat it as a
developer tool, not a runtime feature.

---

- Create a test account per role.
- Log in as any role quickly.
- Test role-based behaviour.
- Test permissions and displays.
- Depend on core User.
- Configure at role_test_accounts.settings.
- Use on local/staging only.
- Never enable on production.
- Remove test accounts before go-live.
- Treat as a developer tool.
- Avoid extra accounts on live sites.
- Mind privileged test accounts.
- Represent each role.
- Speed up role testing.
- Check per-role access.
- Avoid weak-password test accounts on prod.
- Test as different roles.
- Keep out of production.
- Generate role fixtures.
- Support development testing.
