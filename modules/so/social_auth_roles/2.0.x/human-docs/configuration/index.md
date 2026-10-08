# Configuration

## Open the settings form

1. Log in as a user with the **Administer social api authentication** permission
   (an administrator by default).
2. Go to **Configuration → Social API → Social Auth → Roles**, or navigate directly
   to `/admin/config/social-api/social-auth/roles`.

## Choose the roles

The form lists every role that exists on your Drupal site. Tick the roles you want
**automatically assigned to new accounts when they are created via Social Auth**,
then save. From that point on, anyone who registers through a social provider gets
those roles on top of the standard `authenticated` role; people who register the
normal way are unaffected.

### A worked example

All employees of a company use Google accounts, and you have limited Google login
to just the company's domain. You want anyone who signs in with Google to be given
an **Employee** role automatically — but accounts created the traditional way in
Drupal should not get it. Tick **Employee** on this form, and that is exactly what
happens.

## Important safety notes

- **Only offer low-privilege roles here.** A role assigned automatically at
  registration is effectively granted to anyone who can complete the social login
  flow. Do not select any role carrying a permission that matters — no content
  editing beyond a user's own, no configuration access, nothing that can grant
  further permissions.
- **Social identity is weaker than email verification, not stronger.** A provider
  account can be new, disposable or automated, and the provider verified the email
  for its own purposes, not yours.
- **The assignment sticks.** An account keeps the roles it was given at creation.
  If you later remove a role from this form, users who already registered keep it —
  you would have to adjust those accounts manually.
