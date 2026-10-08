# Configuration

## Grant the permission

The setting is protected by the **`administer authenticated_frontpage configuration`**
permission, which is marked access-restricted. Grant it only to trusted administrators
at **People → Permissions** (`/admin/people/permissions`) — it decides what every
logged-in user sees first.

## Open the settings form

1. Log in as a user with that permission.
2. Go to **Configuration → System → Custom Frontpage for Authenticated users**, or
   navigate directly to `/admin/config/system/authenticated-frontpage`.

## Set the authenticated-users front page

On the form, specify the page that authenticated users should see at the site root.
Anonymous visitors continue to get Drupal's normal front page; logged-in users are
served the alternative content at the same `/` URL, with no redirect. Save the form to
apply it.

## Important: check the page cache

Because the response at `/` now **varies by whether the visitor is logged in**, it must
carry the right cache context or Drupal's internal page cache can serve the wrong
version — for example handing the members' page to an anonymous visitor out of cache.

- Make sure the front-page response varies on **`user.roles:authenticated`** (or
  `user`).
- **Test with the page cache enabled**, not only while logged in. Load `/` as an
  anonymous visitor after an authenticated user has hit it, and confirm the anonymous
  visitor still gets the public homepage. This is the first failure mode to check.

## Watch for conflicts

Only one mechanism can own the front page at a time. If you also run something that
claims `/` — a login-redirect module (such as `localgov_login_redirect` or
`login_destination`) or a `<front>` route override — pick one approach, not both, or
they will fight over what appears.
