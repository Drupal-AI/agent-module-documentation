# Configuration

Configuration happens in two worlds: your Keycloak server, where you set up a
client for Drupal, and Drupal, where you create an OpenID Connect client that
uses the Keycloak plugin.

## On the Keycloak side

In your Keycloak admin console, within the realm you want to use:

1. Create (or reuse) a **client** for Drupal — typically a confidential client
   with a client id such as `drupal`.
2. Set its valid redirect URIs to your Drupal site so Keycloak can return users
   after login.
3. Note the **client id**, the **client secret**, your server's **base URL**
   (for example `https://id.example.com`, with no trailing slash), and the
   **realm** name (for example `master`).

## Create the Drupal client

1. Go to **Configuration → People → OpenID Connect**
   (`/admin/config/people/openid-connect`).
2. Add a client and choose the **Keycloak** plugin.
3. Fill in the core settings:
   - **Client ID** — the Keycloak client id.
   - **Client secret** — the Keycloak client secret (prefer a Key entity in
     production).
   - **Keycloak base URL** — your server base URL, no trailing slash.
   - **Keycloak realm** — the realm name.

You never enter the individual endpoints — the plugin derives the authorization,
token, userinfo, logout, and session‑iframe URLs from the base URL and realm as
`{base}/realms/{realm}/protocol/openid-connect/…`.

A few more core options:

- **Update email from Keycloak on login** (`userinfo_update_email`) — keep the
  Drupal account's email in sync with Keycloak at each login.
- **Identity‑provider hint** (`kc_idp_hint`) — a default hint forwarded to
  Keycloak to pre‑select a brokered identity provider.
- **Allowed ISS domains** (`iss_allowed_domains`) — restrict which issuer domains
  may initiate SSO.
- **Debug** (`debug`) — log the OpenID Connect flow for troubleshooting.

## Single sign‑on and sign‑out

- **SSO redirect** (`keycloak_sso`) — replace the Drupal login form with an
  automatic redirect to Keycloak. Leave this off if you want to keep a normal
  Drupal login available alongside Keycloak.
- **Single sign‑out** (`keycloak_sign_out`) — when a user logs out of Drupal,
  also end their Keycloak session.
- **Session check** (`check_session`) — periodically check whether the user has
  logged out on the Keycloak side and, if so, end the Drupal session. You can set
  the **interval** in seconds.

## Interface language (i18n)

- **Forward language** (`keycloak_i18n`) — send the active Drupal interface
  language to Keycloak so its login screens appear in the same language.
- **Language mapping** — map Drupal language codes to the locale codes Keycloak
  expects, when they differ.
- **Locale parameter** (`keycloak_locale_param`) — the query‑parameter name
  Keycloak reads the locale from (default `kc_locale`).

## Map Keycloak groups to Drupal roles

The **group mapping** feature (`keycloak_groups`) automatically grants and
revokes Drupal roles based on a Keycloak token claim:

- **Enable** it to turn on automatic role assignment.
- **Claim name** — the token claim that holds the user's groups or roles (often
  `groups`).
- **Split groups** — break nested group paths like `/a/b/c` into individual
  values so each level can be matched (with an optional depth limit).
- **Rules** — an ordered list, evaluated by weight. Each rule targets a Drupal
  **role** and specifies an **action** (add or remove the role), an **operation**
  (how to compare — for example equals, starts with, or regex), a **pattern** to
  match against the claim, whether matching is **case sensitive**, its **weight**
  (evaluation order), and whether it is **enabled**.

For example, a rule that adds the `editor` role to anyone whose `groups` claim
equals `/editors`, and a companion rule that removes it when that group is
absent, keeps Drupal roles in step with Keycloak group membership on every login.

## Verify it worked

With the client saved and (optionally) SSO enabled, visit the Drupal login page
or the `keycloak/login` route. You should be taken to Keycloak, and after
authenticating you should be returned to Drupal logged in, with any mapped roles
applied. Turn on **Debug** temporarily if a login does not behave as expected.
