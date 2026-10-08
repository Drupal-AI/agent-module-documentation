# Configuration

All configuration happens on one page: **Configuration → Quickbooks API**
(`/admin/config/quickbooks_api/adminsettings`). You need the **Administer site
configuration** permission (or the module's own administration permission) to reach
it. Connecting the site is a two‑part job: first create an app on Intuit's side,
then paste its credentials here and complete the OAuth handshake.

## Before you start — create an Intuit app

1. Sign in to the **Intuit Developer** portal with your developer account.
2. Create an app that targets the **QuickBooks Online Accounting API**.
3. Note the app's **Client ID** and **Client Secret** (Intuit provides separate
   development and production keys — pick the pair that matches how you are testing).
4. In the app's settings, add the **redirect/callback URI** that points back at
   your Drupal site's settings form. The Quickbooks API settings page tells you the
   exact redirect URL to register — copy it from there so the two sides match.

## Enter the credentials

On the Quickbooks API settings form you supply the OAuth 2.0 connection details for
the app you just created:

- **Client ID** — the public identifier of your Intuit app.
- **Client Secret** — the app's private secret. Treat this like a password.
- **Redirect URI** — must exactly match the URI you registered in the Intuit
  developer portal, or the OAuth handshake will fail.
- **Environment** — whether you are connecting to Intuit's sandbox
  (development/testing) or production company data.

## Connect (the OAuth handshake)

Once the credentials are saved, use the **Connect to QuickBooks** action on the
form. You'll be redirected to Intuit, asked to authorize the app against a
QuickBooks Online company, and sent back to Drupal. The module stores the resulting
**access token** and **refresh token** so it can make API calls on your behalf and
renew access automatically as tokens expire.

## Keep the credentials and tokens as secrets

The client secret and the OAuth access/refresh tokens grant read/write access to
sensitive financial and personal data, so handle them accordingly:

- Never hard‑code the client secret or commit it to version control. Store it in an
  environment variable and, where possible, reference it through a **Key** entity
  rather than typing it into a plain config field.
- On DDEV you can keep the secret out of the repo with the built‑in dotenv helper,
  for example:

  ```bash
  ddev dotenv set .ddev/.env --quickbooks-client-secret='your-secret'
  ddev restart
  ```

  (`.ddev/.env` must stay out of version control.)
- Make sure every request runs over **HTTPS** — OAuth tokens must never travel over
  plain HTTP.
- In the Intuit developer portal, grant the connected app only the **minimum
  scopes** it needs. QuickBooks accounting data is financial PII; the fewer
  permissions the app holds, the smaller the blast radius if a token leaks.

## Save

Save the form, complete the connection, and the QuickBooks service is ready for
other modules to use (see "How to use it" on the [overview page](../index.md)).
