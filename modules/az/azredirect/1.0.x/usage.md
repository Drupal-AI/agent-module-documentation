<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AZRedirect force-redirects anonymous visitors into the Azure AD (Entra ID) OpenID Connect login flow on every route except the core login and OIDC callback routes.

---

AZRedirect is a thin glue module for sites that want mandatory single sign-on against Microsoft Azure Active Directory (Entra ID). With one checkbox enabled, a kernel `REQUEST` event subscriber (`AzredirectSubscriber`) intercepts each anonymous request and — unless the route is one of a small whitelist of login/password-reset/OIDC-callback routes — saves the intended destination and immediately starts the OpenID Connect authorize redirect against the hard-coded `windows_aad` client. All actual authentication, token exchange and user provisioning are performed by the `openid_connect` and `openid_connect_windows_aad` modules; AZRedirect only decides *when* to bounce an anonymous user into that flow. It ships a single settings form at `/admin/config/system/az-settings` (permission `administer site configuration`), stores one config value `azredirect.settings:user_route`, and defines no entities, permissions, plugins, services beyond the subscriber, or Drush commands. Supports Drupal 9, 10 and 11.

---

- Make an entire Drupal site private behind Azure AD / Entra ID single sign-on.
- Force anonymous visitors to authenticate before seeing any content.
- Turn mandatory Azure login on or off with one checkbox without touching code.
- Redirect users to the Microsoft login portal automatically on first visit.
- Reuse an existing `openid_connect_windows_aad` client (`windows_aad`) for the redirect.
- Send staff/intranet users straight to the corporate Entra ID login.
- Preserve the originally requested path so users land back on it after login (via OpenID Connect's saved destination).
- Keep the core `/user/login`, `/user/password` reset and OIDC callback routes reachable so login can complete.
- Provide a company-wide SSO gate for a Drupal-based internal portal.
- Avoid exposing a Drupal login form publicly by bouncing to Azure instead.
- Enforce federated authentication for all non-login pages.
- Delegate credential storage and token validation entirely to OpenID Connect.
- Roll out mandatory SSO to an existing OpenID Connect Windows AAD deployment with minimal configuration.
- Temporarily disable the forced redirect (uncheck the setting) during maintenance or debugging.
- Test the redirect behaviour in a private/incognito window or after logging out.
- Combine with Azure AD group/role mapping configured in openid_connect_windows_aad.
- Gate a staging environment behind organisational Azure accounts.
- Give editors a one-click Azure login instead of a separate Drupal password.
- Provide a starting point/example for building custom force-login subscribers.
- Support Drupal 9, 10 and 11 sites running OpenID Connect 3.x.
