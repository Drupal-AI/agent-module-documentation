<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Keycloak OpenID Connect adds a Keycloak-specific client plugin to the OpenID Connect module so a Drupal site can authenticate users against a Keycloak server, with single sign-on/out, i18n, and Keycloak group → Drupal role mapping.

---

The module is a plugin for `openid_connect`: it registers an `OpenIDConnectClient` plugin (id `keycloak`) that knows Keycloak's URL scheme, so you only enter a **base URL** and **realm** instead of five separate endpoints — the plugin derives the authorization, token, userinfo, end-session and session-iframe URLs as `{base}/realms/{realm}/protocol/openid-connect/*`. Each client is stored as an `openid_connect.client.<id>` config entity with `plugin: keycloak` and a `settings` map (`client_id`, `client_secret`, `keycloak_base`, `keycloak_realm`, plus Keycloak extras). Beyond basic login it can: replace the Drupal login form with a redirect to Keycloak (`keycloak_sso`), propagate logout so signing out of Drupal also ends the Keycloak session (`keycloak_sign_out`) and vice-versa via a periodic session check (`check_session`), forward the UI language to Keycloak (`keycloak_i18n` with a langcode mapping and `keycloak_locale_param`), pass an IdP hint (`kc_idp_hint`), and automatically grant/revoke Drupal roles from a Keycloak group/role claim using ordered rules (`keycloak_groups` with `claim_name`, `split_groups`, and per-rule pattern/operation/action). A `KeycloakService` holds this logic; a route subscriber and request subscriber wire up the SSO redirect and locale handling. It does nothing until you create and enable a Keycloak client at *People → OpenID Connect*.

---

- Let users log in to Drupal with their Keycloak (SSO) account.
- Configure a Keycloak client by entering only a base URL and realm, not every endpoint.
- Run several Keycloak clients (e.g. different realms) as separate OIDC client entities.
- Replace the Drupal login form with an automatic redirect to Keycloak (`keycloak_sso`).
- Keep a "normal" Drupal login available while still offering Keycloak sign-in.
- Sign users out of Keycloak when they log out of Drupal (single sign-out).
- Detect a Keycloak-side logout and end the Drupal session via periodic session checks.
- Synchronise the user's email from Keycloak on each login (`userinfo_update_email`).
- Map Keycloak groups or roles onto Drupal roles automatically (`keycloak_groups`).
- Grant an "editor" Drupal role to members of a Keycloak group by pattern rule.
- Revoke a Drupal role when the matching Keycloak group is absent (rule action).
- Split nested Keycloak group paths (`/a/b/c`) into separate values for matching.
- Forward the active Drupal interface language to Keycloak login screens (i18n).
- Map Drupal langcodes to Keycloak locale codes (`keycloak_i18n.mapping`).
- Pass a default identity-provider hint (`kc_idp_hint`) to pre-select a broker IdP.
- Restrict which issuer domains may initiate SSO (`iss_allowed_domains`).
- Enable debug logging of the OIDC flow for troubleshooting (`debug`).
- Provision Drupal accounts on first Keycloak login (via openid_connect + externalauth).
- Integrate an existing corporate Keycloak realm with a Drupal intranet.
- Centralise authentication for a multi-site Drupal estate on one Keycloak server.
- Use `keycloak/login` and `keycloak/logout` routes for SSO entry/exit points.
- Export the whole client configuration as config for repeatable deployments.
