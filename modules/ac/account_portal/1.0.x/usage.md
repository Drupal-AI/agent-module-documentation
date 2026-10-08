<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Account Portal prefixes Drupal's user/OAuth routes with a per-consumer path (e.g. `/account-portal/realm/<client-id>/user/login`) so multi-step account flows always know which OAuth consumer, and which origin, the visitor came from.

---

Account Portal is a routing and consumer-negotiation layer for building an "account portal" in front of Simple OAuth's `/oauth/authorize` endpoint — comparable to how accounts.google.com hosts login, registration and 2FA for Google's OAuth flows. It does not add pages, blocks, entities or permissions of its own; instead it rewrites request and generated-link paths. An inbound path processor strips a configured base path plus the embedded consumer client-id and hands the clean path to Drupal's router, while an outbound path processor re-adds that same prefix to links for a configured set of routes (login, password reset, register, logout, `oauth2_token.authorize`) so a user navigating multi-step flows stays inside the portal namespace for one consumer. A high-priority kernel REQUEST subscriber reads the client-id out of the path and sets it as the `consumerId` query parameter so the Consumers module's negotiator selects that consumer; an invalid client-id can optionally redirect to a fallback route. The `AccountPortalUtility` helper resolves where the visitor originally came from (from the `redirect_uri` query parameter or a Referer/custom header) so downstream code can send them back to the external application.

All configuration is done through Symfony service parameters in a `services.yml`/`services.yaml` file (base path, fallback destination, custom referer header, and the list of prefixed routes) — the module's admin form at `/admin/config/account-portal/settings` is intentionally a no-op notice. Requires the `consumers` contrib module. Because it sits on the OAuth path, treat the prefixed routes as authentication-adjacent: register consumers deliberately and review which routes are exposed through the portal.

---

- Front an OAuth provider (Simple OAuth) with a Google-style account portal.
- Prefix `user.login` with a per-consumer path for portal-scoped logins.
- Prefix `user.register` so registration stays inside the portal namespace.
- Prefix `user.pass` (password reset) for portal-scoped recovery flows.
- Prefix `user.logout` so logout keeps the consumer context.
- Prefix `oauth2_token.authorize` (the Simple OAuth authorize endpoint).
- Embed the consumer client-id in the URL: `/account-portal/realm/<client-id>/user/login`.
- Auto-select the right Consumers entity from the URL via the `consumerId` query param.
- Keep multi-step registration/2FA flows tied to one consumer across pages.
- Let a user abort a flow and return to the originating external application.
- Customize portal pages per consumer (e.g. different links for a native app).
- Change the portal base path with `account_portal.base_path`.
- Redirect unknown/invalid consumer ids to a fallback route via `account_portal.invalid_consumer_id_destination`.
- Preserve `redirect_uri` when redirecting on an invalid consumer id.
- Read the visitor's origin URL with `AccountPortalUtility::getRedirectUri()`.
- Read just the origin scheme+host+port with `AccountPortalUtility::getRedirectBaseUri()`.
- Support Authorization Code Grant flows that pass `redirect_uri`.
- Fall back to the Referer header (or a custom header) to determine origin.
- Add extra routes to the prefixed set via `account_portal.routes`.
- Pair with Simple OAuth Account Picker for account-switching UX.
- Build decoupled/native-app login surfaces on a shared Drupal backend.
- Distinguish requests from different consumers without an `X-Consumer-ID` header.
- Support Drupal 10.3+ and 11 on PHP 8.1+.
