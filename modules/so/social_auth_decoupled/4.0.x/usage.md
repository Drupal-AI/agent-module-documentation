<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Decoupled is a base module for decoupled social authentication.

---

Social Auth Decoupled is a **base module for decoupled (headless) social login** — extending the Social
Auth framework so a decoupled front end can drive social authentication and receive the authenticated user's
ID and a **CSRF token** for subsequent requests. It depends on the Social Auth module and core System, in the
Social package.

Use it as the foundation for headless social login. It touches authentication; it builds on the **Social Auth
framework** (which handles the OAuth provider flow, including state/CSRF for the provider round-trip) and uses
Drupal core's **CSRF token generator** to issue a CSRF token to the decoupled client. Security notes for a
decoupled auth setup: serve everything over **HTTPS**, ensure the front end stores/uses the returned token
safely, and validate/scope which origins may drive the flow (CORS). It grants access through the Social Auth
login it wraps. Build your decoupled social login on it.

---

- Provide decoupled social login base.
- Extend the Social Auth framework.
- Return the user ID + a CSRF token.
- Depend on Social Auth and core System.
- Use core's CSRF token generator.
- Let a headless front end drive login.
- Rely on Social Auth for the provider flow/state.
- Serve over HTTPS.
- Scope origins (CORS) and store tokens safely.
- Grant access via the wrapped Social Auth login.
- Have no access role of its own.
- Build decoupled login on it.
- Handle decoupled social auth.
- Provide headless login.
- Configure the base.
- Issue CSRF tokens.
- Handle the framework.
- Support headless auth.
- Secure the flow.
- Provide decoupled social auth.
