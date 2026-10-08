<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Test Accounts — agent index

Creates a **test account per role** for testing role-based behaviour. Depends on core `user`. Config at
`role_test_accounts.settings`. Version **8.x-1.7**. Core `^10.2||^11`.

**DEV ONLY — do not enable on production.** Creates real accounts holding site roles (possibly
privileged) = extra credentialed access surface. Remove test accounts before go-live. Dev/QA tool, not
a runtime feature.
