Makes a Drupal site act as a CAS (Central Authentication System) **server / identity provider**: other applications ("services") delegate login to Drupal, and Drupal issues and validates CAS tickets that carry the authenticated username plus optional user-field attributes.

---

CAS Server implements the CAS 1.0/2.0/3.0 protocol on top of the Drupal users table. It exposes the standard endpoints — `/cas/login`, `/cas/logout`, `/cas/validate`, `/cas/serviceValidate`, `/cas/proxyValidate`, `/cas/p3/serviceValidate`, `/cas/p3/proxyValidate`, and `/cas/proxy` — via `UserActionController`, `TicketValidationController`, and `ProxyController`. Sites register one or more **Service definitions** (`cas_server_service` config entities): each has a wildcard URL pattern that incoming `service=` URLs are matched against, an SSO flag, an optional list of user fields to release as attributes, and optional per-service role restrictions. A user logging in at `/cas/login?service=<url>` is authenticated by `UserLogin` (validating a single-use login ticket), then redirected back to the service with a single-use **service ticket** (`ST-…`); the service calls a `…Validate` endpoint to exchange that ticket for the username (and attributes) as XML or JSON. Tickets — login, service, proxy, proxy-granting, ticket-granting — are 256-bit values from `Crypt::randomBytesBase64(32)`, stored in the `cas_server_ticket_store` table with per-type timeouts (configurable) and purged by `hook_cron`. Optional single sign-on uses a ticket-granting cookie (`cas_tgc`) so a returning user is not re-prompted. Two events let other modules alter issued tickets (`CasServerTicketAlterEvent`) or the released attributes (`CASAttributesAlterEvent`) — the latter powering the `cass_attributes` submodule. The module must run over HTTPS and must **not** be enabled alongside the CAS *client* module.

---

- Turn a Drupal site into a central login server for a suite of related apps.
- Provide single sign-on so users authenticate once for many services.
- Let a non-Drupal app authenticate its users against Drupal accounts via CAS.
- Register an allowed service by URL pattern (wildcards with `*`).
- Release selected user profile fields (name, mail, custom fields) as CAS attributes.
- Restrict which Drupal roles may log in to a given service.
- Grant a role blanket access to every service (`cas server login to any service`).
- Issue short-lived, single-use service tickets validated server-side.
- Support CAS protocol versions 1, 2, and 3 (XML and JSON responses).
- Support proxy authentication (proxy-granting and proxy tickets) for tiered back-ends.
- Keep users signed in across services with a ticket-granting cookie (SSO session).
- Force credential re-entry for sensitive services with the `renew` parameter.
- Do a silent `gateway` check that only redirects already-authenticated users.
- Log a user out of the CAS SSO session and destroy their tickets at `/cas/logout`.
- Customize the invalid-service, not-permitted, logout, and logged-in messages.
- Authenticate by username, email address, or either (`login.username_attribute`).
- Choose which attribute is sent as the CAS username (name / mail / uid).
- Show or hide a "reset password" link on the CAS login form.
- Tune ticket lifetimes (login/service/proxy/PGT/TGT) per deployment.
- Alter issued tickets in code via `CasServerTicketAlterEvent`.
- Add or transform released attributes in code via `CASAttributesAlterEvent`.
- Auto-purge expired/unvalidated tickets on cron.
- Enable debug logging of ticket validation flow for troubleshooting.
- Map an SSO estate where some services share a session and others require fresh login.
