# JSON:API User Resources — manual setup guide

**JSON:API User Resources** (`jsonapi_user_resources`) adds the user-account
endpoints that core's JSON:API deliberately leaves out — registration in
particular — so a decoupled or headless Drupal application can let people sign up,
reset their password, and update their password entirely over the API.

Core JSON:API exposes entities and follows entity access strictly, which is the
right default but leaves a specific gap: there is no way to *register*. Creating a
user is not an ordinary entity POST — it involves the registration settings, the
approval mode, the password policy, and the activation email, all of which live in
the user module rather than the entity API. This module fills that in cleanly by
building on **JSON:API Resources**, the contrib framework for adding non-entity
resources to JSON:API in a way that respects its conventions, rather than bolting a
separate REST controller alongside.

The endpoints it adds are:

- **`/jsonapi/user/register`** — register a new user.
- **`/jsonapi/user/password/reset`** — request a password reset for an email
  address.
- **`/user/{user}/password/update`** — update a user's password.

(A user's password can also be updated through core's own
`/jsonapi/user/user/{user}` endpoint.) There is no admin settings form; the
endpoints exist as soon as the module is enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its JSON:API Resources dependency.

This module has **no configuration page** — it adds API endpoints and has no
settings form.

## PII and access — check these before you rely on it

The registration endpoint is, by design, an **unauthenticated write endpoint**
that creates user accounts — so it handles personal data (names, email addresses)
and can create accounts on your site. This version is a **beta**
(`8.x-1.0-beta2`), so before you depend on it in production, verify on your own
site that it behaves the way your security posture requires. In particular:

- **Registration setting** — confirm the endpoint honours
  `user.settings.register`, so a site configured for admin-only account creation
  does not accept registrations through the API.
- **Admin approval** — confirm it respects admin approval, creating *blocked*
  accounts rather than active ones when your site requires approval.
- **Flood control / rate limiting** — an unauthenticated account-creation endpoint
  without rate limiting is an invitation to automated signups. Confirm flood
  control applies, or add rate limiting in front of it.
- **Email verification** — confirm email verification is enforced. An API that
  hands back a usable session on registration *without* verifying the address is a
  materially different security posture from Drupal's own registration form.

Because the endpoint accepts email addresses and passwords, make sure it is only
served over HTTPS and that your logging does not capture the request bodies.

## How to use it

Enable the module, then have your front end POST to `/jsonapi/user/register` with
the new user's details (name, mail, pass), and to `/jsonapi/user/password/reset`
with an email address to trigger a reset. Validate the four behaviours above first
so the API matches how your site's own forms would behave.
