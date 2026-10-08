<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dripyard Simple Login replaces Drupal's password login with magic-link (passwordless) authentication by repurposing core's password-reset flow.

---

Dripyard Simple Login is a small Drupal 11 module that turns the standard username/password login into passwordless, magic-link authentication without introducing a new token system. It moves the login form to `/login` and shows an email-entry form (`MagicLinkLoginForm`); on submit it triggers core's `password_reset` mail through `_user_mail_notify()`, so the user receives core's ordinary one-time-login link. Clicking that link hits core's `user.reset.login` route, which the module points at its own `UserResetController` — a thin subclass of core's `UserController` that calls `parent::resetPassLogin()` and only swaps in a friendlier "You're logged in!" message. Because the whole flow rides on core's password-reset mechanism, the link is validated by core's own one-time-login HMAC token (checked with a constant-time comparison, gated on an active account and the `password_reset_timeout` window, single-use) and requests are rate-limited by core's password-reset flood settings. The module also keeps a password fallback (a "Use password" button routes to `/login-password`, which renders core's `UserLoginForm`), redirects the standard "request new password" form (`user.pass`) back to `/login`, removes the "Request new password" local task, and adds optional Gin Login theming for the password page. It depends only on core's User module and requires one manual step: rewording the "Password recovery" email template so it reads as a login link. It ships no config, no permissions, no Drush commands, and no plugins.

---

- Switch a Drupal 11 site to passwordless, magic-link login without adding a custom token/authentication system.
- Let users log in by entering only their email address and clicking a one-time link.
- Reuse Drupal core's proven password-reset/one-time-login mechanism instead of a bespoke magic-link implementation.
- Move the login form to `/login` (core `user.login` route repurposed via `RouteSubscriber`).
- Keep a traditional password login available as a fallback at `/login-password` (core `UserLoginForm`).
- Give users a one-click "Use password" escape hatch on the magic-link form.
- Deliver login links through the existing site mail system (no new mail integration to configure).
- Rate-limit login-link requests using core's existing flood control (`user.password_reset_ip` limits).
- Show the same neutral confirmation message whether or not the email matches an account.
- Redirect anyone hitting `/user/password` (`user.pass`) to the login form with a helpful message.
- Remove the "Request new password" tab so the login page presents a single, consistent path.
- Simplify the post-login message shown after a link is clicked ("You're logged in!").
- Let users optionally set a password after logging in (via core's one-time-login edit flow).
- Onboard new or infrequent users who never set a password.
- Reduce password-reset support tickets by making "reset" and "login" the same action.
- Apply consistent Gin Login theming to both `/login` and `/login-password` when the Gin Login module is active.
- Prototype a lean passwordless UX to build on, since the maintainer positions it as inspiration/reference code.
- Pair with a TLS-secured mail transport so login links are delivered securely.
- Tune link lifetime and abuse limits from core's Account settings page (`/admin/config/people/accounts`).
- Serve as a drop-in alternative to heavier magic-link/passwordless contrib modules when you only need core behavior.
