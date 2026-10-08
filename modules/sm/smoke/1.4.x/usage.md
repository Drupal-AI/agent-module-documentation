<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smoke provides automated smoke testing with Playwright.

---

Smoke **runs automated smoke tests with Playwright** — auto-detecting features (webform, commerce, search, etc.)
and running Playwright browser tests against the site, for QA/CI. It depends on core User and provides its own
permissions, in the Development package.

Use it for automated smoke testing. It is a **developer/testing** tool. Security note: it drives a browser against
the site and may need **test credentials** (store as secrets, use dedicated test accounts) — keep it to
**non-production/CI** environments and gate it to developers (don't expose test tooling on production). It has no
content or access role beyond its permission. Configure the smoke tests.

---

- Run Playwright smoke tests.
- Auto-detect webform/commerce/search.
- Support QA/CI.
- Depend on core User.
- Provide its own permissions.
- Serve development/testing.
- Drive a browser against the site (may need test credentials).
- Keep it to non-production/CI + dedicated test accounts.
- Gate it to developers (don't expose on production).
- Have no content/access role beyond permission.
- Configure the smoke tests.
- Handle smoke testing.
- Run tests.
- Configure the tests.
- Test the site.
- Handle the testing.
- Detect features.
- Configure development.
- Handle the QA.
- Keep it dev/CI.
- Provide smoke testing.
