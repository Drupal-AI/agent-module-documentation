# Configuration

Configuring OpenID Connect has two parts: creating a **client** for each identity
provider you want to support, and setting the **global** login behavior. Both live at
**Configuration → People → OpenID Connect clients**
(`/admin/config/people/openid-connect`) and require the **Administer OpenID Connect
clients** permission.

## Before you start: register your site with the provider

Whichever provider you use (Google, Okta, an Azure AD app registration, and so on),
you first create an OAuth/OIDC application in *their* console and obtain a **client
ID** and **client secret**. You will also need to tell the provider your **redirect
URI**, which for this module is:

```
https://your-site.example.com/openid-connect/<client-machine-name>
```

That is the callback the provider returns users to after they authenticate. Keep the
provider's console open — you will paste the client ID and secret into Drupal, and
the redirect URI into the provider.

## Add a provider client

1. Go to **Configuration → People → OpenID Connect clients** and choose to **add a
   client** for the provider plugin you want — `Generic`, `Google`, `Okta`,
   `GitHub`, `Facebook`, or `LinkedIn`.
2. Give the client a **label** and machine name (the machine name becomes part of the
   redirect URI above).
3. Fill in the plugin's settings. Common fields on every client are:
   - **Client ID** and **Client secret** — from the provider's console.
   - **Allowed domains** (`iss` allowed domains) — optionally restrict which issuer
     domains may initiate SSO.
   - **Prompt** — the OAuth `prompt` parameter: `none`, `login`, `consent`, or
     `select_account`.
   - Provider-specific fields, for example:
     - **Generic** adds an **Issuer URL** (which enables `.well-known` endpoint
       auto-discovery) plus explicit authorization, token, userinfo, and end-session
       endpoints and a **scopes** list.
     - **Okta** adds an Okta domain and scopes.
     - **Facebook** adds an API version.
4. Save the client. Back on the list you can **enable/disable** each client.

Register the redirect URI (`/openid-connect/<client-machine-name>`, as an absolute
URL) with the provider if you have not already, and make sure the client is enabled.

## Global settings

Open the **Settings** tab (`/admin/config/people/openid-connect/settings`) to control
site-wide behavior. The main options, with their defaults, are:

- **Save user claims on every login** (`always_save_userinfo`, default *on*) — re-map
  and save the provider's profile data to the account on every login, rather than
  only when the account is first created.
- **Automatically connect existing users** (`connect_existing_users`, default *off*)
  — link a provider identity to an existing local account that has the same email.
  Enable this with care, since it trusts the provider's email.
- **Override registration settings** (`override_registration_settings`, default
  *off*) — allow external logins to create accounts even when your site's
  registration is set to administrators-only.
- **Automatically propagate logout to the provider** (`end_session_enabled`, default
  *on*) — when a user logs out of Drupal, also end their session at the identity
  provider (single logout).
- **OpenID buttons display in user login form** (`user_login_display`, default
  *hidden*) — whether and where the provider buttons appear on the core login form:
  `hidden`, `above`, `below`, or `replace`.
- **Redirect after login / after logout** (`redirect_login` / `redirect_logout`) —
  the paths users land on after logging in (default the user page) or out.
- **User claims mapping** (`userinfo_mappings`) — the map of Drupal user properties to
  OIDC claims. The install default maps the account timezone to the `zoneinfo` claim;
  add rows to map name, email, picture, phone, address, and other standard claims onto
  user fields.
- **Role mappings** (`role_mappings`) — grant Drupal roles based on provider-supplied
  data.
- **Automatically redirect the user to the provider** (`autostart_login`, default
  *off*) — immediately start the login redirect, useful when a single provider is your
  only login method.

Save the settings when done. Both the client entities and these settings are
configuration, so they export and deploy with `drush config:export` / `config:import`.

## Surface the login option for users

Two more pieces make the feature visible to visitors and account holders:

- The **"Sign in with"** block shows a button per enabled provider. Place it (for
  example on the login page) at **Structure → Block layout**. Alternatively, use the
  *OpenID buttons display in user login form* setting above to add the buttons
  directly to the core login form.
- Signed-in users link and unlink providers on their **Connected Accounts** form at
  `/user/{user}/connected-accounts`, provided you granted the relevant per-user
  permissions during [installation](../installation/index.md).

## Test the flow

Log out, then use a provider button (or the autostart redirect) to sign in. You
should be sent to the provider, prompted to authorize, and returned to your site
logged in — with a Drupal account matched, connected, or freshly created and its
fields populated from the claims you mapped. If the return fails, double-check that
the redirect URI registered with the provider exactly matches
`/openid-connect/<client-machine-name>` on your site and that the client is enabled.
