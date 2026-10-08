REST Password Reset exposes three REST endpoints so a decoupled (headless) Drupal frontend can retrieve a username, request a password-reset email, and set a new password without the standard Drupal login forms.

---

The module builds on Drupal core's REST module and is aimed at decoupled sites (for example a React frontend). It registers three `@RestResource` plugins: a GET resource that emails a one-time reset link for a given email address, a GET resource that emails the account username for a given email address, and a POST resource that consumes the `uid`/`timestamp`/`hash` from that link plus a `new_password` and saves the new password. The reset link points at a configurable URL in your frontend (base URI + optional custom suffix + `uid/timestamp/hash`), and the emails are fully configurable and multilingual through an admin form. The reset link uses the same hashing (`user_pass_rehash()`) that core Drupal uses, so a link is bound to the account and expires like a normal Drupal one-time login link. You enable and grant access to the resources through the REST UI module, typically allowing anonymous cookie-authenticated access so the frontend can call them directly.

---

- Add password reset to a decoupled/headless Drupal site whose login lives in a React/Vue/Next frontend.
- Let a user request a password-reset email by submitting only their email address from the frontend.
- Send a reset email whose link targets a page in your own frontend rather than the Drupal backend UI.
- Let a user who forgot their username retrieve it by email address.
- Provide a "set a new password" flow in the frontend that POSTs `uid`, `timestamp`, `hash`, and `new_password` back to Drupal.
- Reuse Drupal's native one-time-login hashing so reset links behave like standard Drupal reset links.
- Configure the frontend base URL that reset links point to (the `fe_uri` setting).
- Configure a custom URL suffix (e.g. `/password-reset/`) for the reset page in the frontend.
- Customize the subject and body of the password-reset email, including tokens like `[site:name]` and `[user:display-name]`.
- Customize the subject and body of the username-retrieval email.
- Insert the generated one-time login link into the email with the `[rest_password_reset:login_link]` token.
- Serve translated reset and username emails on a multilingual site (langcode is prefixed into the reset URL).
- Return uniform, non-revealing responses whether or not the email belongs to a real account.
- Throttle repeated reset/username emails for the same account so a mailbox is not flooded.
- Integrate password recovery into a mobile app that talks to Drupal over REST with cookie authentication.
- Keep the Drupal backend headless while still supporting the full forgot-password journey.
- Enable/disable and set authentication/formats per endpoint through the REST UI module.
- Restrict who may edit the email/URL configuration via the module's dedicated permission.
- Localize the reset page path per language by relying on the langcode-prefixed reset URL.
- Migrate a traditional Drupal login to a decoupled frontend without losing password recovery.
- Provide a JSON API for username lookup and password reset that returns simple `message` payloads.
