# Configuration

There are two parts to configuring this module: setting up the **clients** (in the
OpenID Connect UI) and, optionally, customizing the **login UI** (in this module's
own settings form).

## 1. Configure the CILogon / Globus clients

1. Log in as an administrator and go to **Configuration → People → OpenID Connect**
   (`/admin/config/people/openid-connect`).
2. Enable and configure the client plugin you need:
   - **CILogon (OSP)** — plugin id `ospclscigw`.
   - **Globus Auth (OSP)** — plugin id `ospgascigw`.
3. Enter the **Client ID** and **Client Secret** for that provider. If you've
   installed the **Key** module, select the Key that holds the secret instead of
   typing it in (strongly recommended — see
   [Installation](../installation/index.md)).
4. Note the **redirect URI** the form shows you (it looks like
   `/openid-connect/{plugin_id}/callback`) and **register that exact URI** with the
   provider (in your CILogon or Globus app settings). Login will fail until the
   provider recognizes the redirect URI.

### Scopes

The plugins come with sensible default scopes already filled in:

- **CILogon:** `email`, `openid`, `profile`, `org.cilogon.userinfo`.
- **Globus:** `openid email`.

Adjust these only if your provider app requires something different.

## 2. Customize the login UI (optional)

The module adds its own small settings form for the "Log in with …" buttons:

1. Go to **Configuration → People → CILogon/Globus Auth**
   (`/admin/config/people/cilogon-globus-auth`).
2. **Default button text template** — the text used for the login buttons. Use the
   `@client_title` placeholder to insert the client's title (for example
   `Log in with @client_title`).
3. **Per-client button / help text** — optionally override the button text for an
   individual client, and add help text shown on the login page. HTML is allowed in
   these fields.
4. **Save.**

## Connected Accounts

With the clients configured, users can link their CILogon/Globus identity from
their account's **Connected Accounts** area. This module improves that screen so it
shows *which* provider an account is connected to, using the provider's own claims
(CILogon's `idp_name`, Globus's `identity_provider_display_name`).

## Logout behavior

By default this module adjusts `/user/logout` so it ends only the **local Drupal
session** rather than also signing the user out of the upstream identity provider.
Keep this in mind if your users expect a single sign-out to log them out
everywhere.

## Verify it worked

Log out, go to the login page, and confirm the "Log in with CILogon / Globus"
button(s) appear with your chosen text. Clicking one should send you to the
provider, and after you approve, bring you back logged into Drupal. If you get a
redirect-URI error at the provider, re-check step 4 above. Run `drush cr` after any
config change.
