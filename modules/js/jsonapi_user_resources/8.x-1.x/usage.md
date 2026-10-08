<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API User Resources adds three account endpoints that core's JSON:API deliberately does not provide — anonymous registration, password-reset request, and completing a password change from a one-time-login link — so a decoupled front end can run the full signup-and-recovery flow over JSON:API instead of Drupal's own forms.

---

Core's JSON:API exposes entities strictly through entity access, which leaves a gap for headless front ends: creating an account, kicking off a password reset, and finishing that reset are not ordinary entity writes — they involve `user.settings` (registration mode, email verification, reset-link timeout), the activation lifecycle, and the one-time-login hash, all of which live in the user module rather than the entity API. This module fills that gap on top of **`jsonapi_resources`** (the contrib framework for non-entity JSON:API resources), registering routes from `Routes::routes()` rather than a static routing file and prefixing every path with `/%jsonapi%`. It adds exactly three routes, **all requiring the caller to be NOT logged in** (`_user_is_logged_in: 'FALSE'`): `POST /jsonapi/user/register` maps the request to a new `user--user` entity via `Registration`, which mirrors core's REST registration — it rejects a client-set ID, requires an anonymous caller, honours `user.settings.register` (throwing on admin-only), and activates or blocks the account according to `register`/`verify_mail`; `POST /jsonapi/user/password/reset` looks a user up by `name` or `mail` in the `PasswordReset` resource and dispatches the standard `password_reset` notification email, returning HTTP 202; and `PATCH /jsonapi/user/{user}/password/update` validates a `timestamp` + `hash` + `pass` payload against `user_pass_rehash()` (the same check core uses for one-time-login links) and sets the new password. Each step dispatches an event (`REGISTRATION_VALIDATE`, `REGISTRATION_COMPLETE`, `PASSWORD_RESET`) so other modules can hook in; the bundled subscribers send the register-approval and password-reset emails. Version **8.x-1.0-beta2** — a **beta** — on core `^10.1 || ^11`, requiring `jsonapi` and `jsonapi_resources`. With `jsonapi_hypermedia` present it also adds an `authenticated-as` top-level link to the current user's resource. Because the password may also be changed through core's own `/jsonapi/user/user/{user}` endpoint, this module is additive: use it for the anonymous parts of the account flow a decoupled client cannot otherwise reach.

---

- Register users from a decoupled front end over JSON:API.
- Add a signup endpoint that respects `user.settings.register`.
- Support a React, Vue, or Next.js registration form.
- Register accounts from a mobile app.
- Create accounts that honour admin-approval mode (blocked until approved).
- Create accounts that honour email verification (`verify_mail`).
- Trigger a password-reset email from a headless client by username or email.
- Build a "forgot password" flow in a decoupled app.
- Complete a password reset from a one-time-login link over the API.
- Set a new password using a `timestamp` + `hash` + `pass` payload.
- Send the standard Drupal register/approval/reset notification emails from an API flow.
- React to registrations via `REGISTRATION_COMPLETE`/`REGISTRATION_VALIDATE` events.
- React to reset requests via the `PASSWORD_RESET` event.
- Avoid writing a custom registration controller.
- Follow JSON:API conventions for user creation via `jsonapi_resources`.
- Support headless account management for a membership site.
- Add an `authenticated-as` hypermedia link (with `jsonapi_hypermedia`).
- Support a progressive web app's signup and recovery.
- Onboard users into an app without exposing Drupal's login forms.
- Provide API-driven account creation to a partner system.
