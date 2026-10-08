<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
An authentication provider that forces a request to be anonymous (testing utility).

---

Null Authentication provides a 'null' authentication provider — when a request carries `?_null_auth=1`, it is authenticated as the ANONYMOUS user (its `authenticate()` returns `User::getAnonymousUser()`), so a developer can fetch a page as anonymous while logged in (e.g. to test anonymous rendering/caching).

Security: it can only DOWNGRADE a request to anonymous — it never elevates privileges or impersonates another user, so it is not an authentication-bypass risk. It's a development/testing tool. Supports Drupal 8 through 11.

---

- Force a request to anonymous.
- Trigger via `?_null_auth=1`.
- Return the anonymous user.
- Test anonymous rendering/caching.
- Only downgrade, never elevate.
- Not bypass authentication.
- Serve a dev/testing tool.
- Support Drupal 8 through 11.
- Fetch pages as anonymous.
- Aid developers.
- Handle null auth.
- Test anonymously
- Support Drupal.
- Support Drupal.
- Support Drupal.
