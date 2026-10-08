<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
2factor.app (twofactor) adds a second authentication factor to Drupal logins, delegating the actual verification to the hosted 2factor.app service via a QR/push flow.

---

2factor.app adds two-factor authentication to Drupal. Each user configures per-account API
credentials (obtained from the 2factor.app service) on their profile; once enabled, a
`KernelEvents::REQUEST` subscriber (`CheckTwofactorSubscriber`) redirects that user to a challenge
page (`/user/{uid}/twofactor/auth`) on every request until the session flag `twofactor.allowed` is
set. The challenge page contacts `https://2factor.app/api/set_auth` and shows a code/QR the user
approves in the 2factor.app app; a polling call to `.../get_auth` marks the session verified when the
service returns success (`code === 100`, `request_status === 2`). A per-user IP allow-list and a few
system routes (assets, logout, 403) are exempt from the redirect.

Operationally, the factor depends entirely on a single third-party SaaS being reachable at
authentication time — an availability coupling to understand before making it the only second
factor.

---

- Add a second authentication factor to Drupal login.
- Delegate 2FA verification to the 2factor.app service.
- Enable 2FA per user via profile API credentials.
- Redirect a 2FA user to a challenge on every request.
- Approve a login via the 2factor.app app (QR/push).
- Exempt specific IPs from the second factor per user.
- Exempt asset/logout/403 routes from the challenge.
- Clear 2FA session state on logout (handled by the module).
- Configure per-user api_user/api_password/app_hash.
- Poll get_auth to confirm approval (code 100 / status 2).
- Consider availability coupling to a single external SaaS.
- Restrict which users must complete 2FA via user data.
