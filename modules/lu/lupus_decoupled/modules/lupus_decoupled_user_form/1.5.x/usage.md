<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled User Form exposes Drupal's login and password-reset forms to the front end, so authentication happens against Drupal rather than being reimplemented.

---

Authentication is the part of a decoupled build where reimplementation is most expensive to get wrong. Drupal's login form carries flood control, the password reset flow carries one-time tokens with expiry, and both have had years of scrutiny. A front end that posts credentials to a bespoke endpoint inherits none of that unless it is rebuilt deliberately.

This submodule renders those two forms through the custom-elements form API, so the front end presents them and Drupal handles them. Flood control still applies, reset tokens are still core's, and the session established is a normal Drupal session.

Two things to settle at deployment. **Session handling across origins** — a decoupled front end on a different origin needs cookies to work across it, which is a CORS-credentials and cookie-attribute question, not something the module decides. And **what the front end does with a logged-in session** — which requests carry credentials, and what is cached where, because caching a personalised response in a shared cache is the classic decoupled leak.

---

- Log in to Drupal from a decoupled front end.
- Reset a password from the front end.
- Keep core's flood control on login.
- Use core's one-time reset tokens.
- Avoid reimplementing authentication endpoints.
- Establish a normal Drupal session.
- Style the login form in the front end.
- Handle login errors returned by Drupal.
- Configure cookies across origins.
- Decide which requests carry credentials.
- Avoid caching personalised responses publicly.
- Support a members area on a headless site.
- Debug a login that succeeds but loses session.
- Keep authentication logic in Drupal.
- Plan session strategy for a decoupled build.