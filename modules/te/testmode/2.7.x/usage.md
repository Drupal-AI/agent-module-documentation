<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Testmode alters existing site content and other configurations when running tests, to provide predictable test conditions.

---

Testmode alters existing site content and other configuration when running automated tests — providing
predictable, controlled conditions for tests (for example replacing content, disabling certain features, or
normalizing configuration) so tests aren't affected by real site data. It is configured at
`testmode.admin_settings` and tagged as a development tool.

Use it in testing/CI to make tests deterministic. **Caveat — this is a development/testing tool; be careful
about enabling it on production.** By design it *alters content and configuration* when active, so if it
were active on a live site it could change what visitors see or how the site behaves. Keep it scoped to
test/CI environments and ensure it is not active in production. It has no access-control role. Configure the
test alterations.

---

- Alter content/config during tests.
- Provide predictable test conditions.
- Normalize config for tests.
- Configure at testmode.admin_settings.
- Make tests deterministic.
- Replace content during tests.
- Keep it scoped to test/CI.
- Not active on production.
- Understand it alters content/config.
- Avoid affecting live visitors.
- Have no access-control role.
- Use in testing/CI.
- Provide controlled conditions.
- Disable features for tests.
- Configure test alterations.
- Ensure it's off in production.
- Support automated testing.
- Make tests reliable.
- Scope to test environments.
- Alter for tests.
