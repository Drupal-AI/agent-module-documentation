# miniOrange OAuth Login — manual setup guide

**miniOrange OAuth Login** (`oauth_login_oauth2`) turns your Drupal site into an
OAuth 2.0 / OpenID Connect **client** (a relying party), so users can sign in with
an external identity provider using the Authorization Code flow. It works with
Microsoft Entra ID / Azure AD, Azure B2C, Keycloak, Okta, Google, AWS Cognito,
Discord, Salesforce, GitHub, or any custom OAuth/OIDC server.

You configure a single OAuth application — client id, client secret, requested
scope, and the authorize / token / userinfo endpoints — on the *Configure
Application* tab. Login starts at `/moLogin`, which sends the visitor to the
provider; the provider returns them to `/mo_callback`, where the module exchanges
the code for an access token, fetches the user's profile, and matches the profile's
**email attribute** to an existing Drupal account before logging them in. A **Test
Configuration** round-trip performs a real login so you can see exactly which
attributes your provider returns and pick the one holding the email address.

Note the scope of the **free** version documented here: it logs in **existing**
Drupal users only (no account auto-creation), supports **one** provider, and gates
all its admin pages behind core's *Administer site configuration* permission.
Attribute-to-field and role mapping, auto-provisioning, multiple providers,
page/domain restrictions, and custom redirects appear in the UI but are premium-only
upsells. The client secret is stored encrypted at rest (using a key derived from the
site's private key).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register the app at your provider,
   fill in the Configure Application form, run Test Configuration, and add the
   login link.

## Where it lives in the admin menu

The main settings form is at **Configuration → People → miniOrange OAuth Login →
Configure Application** (`/admin/config/people/oauth_login_oauth2/config_clc`).
Everything under `admin/config/people/oauth_login_oauth2/…` is gated by core's
*Administer site configuration* permission. Login initiation is `/moLogin` and the
provider redirect URI is `/mo_callback`.

## How to use it

1. Register an OAuth/OIDC application at your provider and set its redirect URI to
   `https://<your-site>/mo_callback`.
2. In Drupal, fill in the client id, secret, scope, and endpoints on the Configure
   Application form.
3. Run **Test Configuration** (`/testSSO`) to see the returned attributes and pick
   the email attribute used to match Drupal accounts.
4. Enable login and add the login link to the standard `/user/login` page.

See [Configuration](configuration/index.md) for the full walkthrough.
