<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developer convenience module that logs you in as any user, or lets you view any page as any user, without a password.

---

Visiting `/user/ql/{user_name}` runs `QuickerLoginController::login()` → `QuickerLoginService::loginUserName()`, which loads the named user and calls `user_login_finalize()` to establish a full session as that account. A request subscriber (`QuickerLoginSubscriber`) additionally watches every request for a `ql=` (or `returnto` with `ql=`) query parameter and performs the same login before redirecting back, so appending `?ql={user_name}` to any URL loads that page as the chosen user. While enabled, `hook_preprocess_page` prints a persistent warning that Quick Login is on and must not be used in production.

This is intentionally a password-less impersonation tool with the login route declared `_access: 'TRUE'`, so it must never be enabled on a public or production site — anyone who can reach the path can become any user, including administrators. It is meant for local development and automated testing where quickly switching identities is useful.

---
- Log in as any user for local development
- Visit `/user/ql/{user_name}` to become that user
- View any page as a specific user via `?ql={user_name}`
- Return to the original URL after impersonating (returnto handling)
- Speed up manual testing of role-specific behaviour
- Reproduce a user-specific bug quickly
- Drive automated/browser tests that need identity switching
- See the always-on warning that the module is enabled
- Switch identity without knowing passwords in a dev environment
- Remove before deploying to any shared/production environment
- Log in as an editor to verify content workflows
- Log in as an anonymous-equivalent low-privilege account
- Jump straight to a user-specific dashboard while testing
- Chain a login with a returnto URL for deep-link testing
- Confirm role/permission changes by impersonating quickly
- Use in CI to seed an authenticated browser session
