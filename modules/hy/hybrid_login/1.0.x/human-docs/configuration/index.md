# Configuration

Hybrid Login is configured from one form. Everything it does is presentation and
access control on the login page — it never authenticates a user itself.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → People → Login settings**, or navigate directly to
   `/admin/config/people/hybrid_login`.

Changes are saved to the `hybrid_login.settings` configuration.

## The settings, field by field

- **Hide Drupal login** — hides the Drupal name/password/submit fields on
  `/user/login`. This does not touch the Hybrid Login block itself, so users can
  still use your external login button; it just removes the built‑in form. Use
  this when you want *external login only*.
- **Show create account** — when switched **off**, the create‑account link is
  removed *and* access to the core `user.register` route is denied, so
  self‑registration is fully closed off (not just hidden).
- **Show password reset** — when switched **off** (or whenever the Drupal login is
  hidden), the password‑reset link is removed and access to the core `user.pass`
  route is denied. Turn this off when passwords are managed by your external
  service rather than Drupal.
- **Login title** — the heading shown in the Hybrid Login block.
- **Login description** — descriptive text in the block, typically explaining how
  users can access their account via the external login service.
- **Login logo** — an uploaded image (png/jpg/jpeg) for the external login
  service. It is rendered at the *medium* image style and marked permanent when
  you save.
- **Login button text** — the label on the external‑login button (defaults to
  "Login").
- **Login URL path** — the relative path the button links to, typically
  `/saml/login`. This must match a path served by the external auth module you
  installed separately; Hybrid Login does not create it.
- **Password reset description** — markup shown on the `/user/password` page
  (useful for telling users to reset their password via the external service
  instead).

## Save and clear cache

Click **Save**, then clear the cache — the README recommends this after changing
any Hybrid Login settings so the login page reflects your changes.

## Remember: this module does not log anyone in

Hybrid Login contains no authentication logic. To actually authenticate users via
an external service you must install and configure that service (for example SAML
Authentication) and point the **Login URL path** at it. Hybrid Login only renders
the entry point and adjusts which core login UI is shown.
