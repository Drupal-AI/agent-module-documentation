# Configuration

Enabling the module does nothing on its own — you choose the new path prefixes here.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (or the
   permission this module provides for its settings), typically an administrator.
2. Go to **Configuration → System → Secure Admin Path**, or navigate directly to
   `/admin/config/system/secure-admin-path`.

## The settings

The form lets you supply a replacement term for each of Drupal's two well-known
prefixes:

- **Secure the "admin" path** — enter the word you want to use in place of `admin`.
  For example, entering `manage` makes the administration area answer at
  `/manage/…` instead of `/admin/…`.
- **Secure the "user" path** — enter the word you want to use in place of `user`, so
  the account and login pages move away from the standard `/user/login`.

Pick terms that are not obvious guesses (avoid `backend`, `login`, `cms`, and the
like) and that do not collide with existing content paths on your site.

## Save

Click **Save configuration**. The rename takes effect immediately: from now on the
admin and account pages — including this very settings form — respond at the new
prefixes, not the old `/admin` and `/user` ones. Make a note of the new address before
you save, so you do not lock yourself out of the admin menu.

## After saving

- Test the site thoroughly. If a module or link stops working, it is almost certainly
  because it hard-codes the old paths (see Installation) rather than a fault in this
  module.
- Keep relying on Drupal's real protections — strong passwords, flood/rate limiting,
  and 2FA. This rename reduces bot noise but is **not** an access-control boundary;
  anyone who learns the new prefix reaches the same pages.
