# Configuration

Configuring Slack login is a two‑part job: register an OAuth app at Slack, then
enter its details in the League OAuth Login configuration for the Slack provider.

## 1. Register a Slack OAuth app

1. Create an app at the [Slack API dashboard](https://api.slack.com/apps).
2. Under the app's OAuth settings, add a **redirect URL** pointing at your site's
   League OAuth Login callback (the redirect URI).
3. Grant the identity scopes Slack requires for sign‑in (so the app can read the
   user's identity and email).
4. Note the app's **Client ID** and **Client Secret**.

## 2. Enter the details in Drupal

In the League OAuth Login configuration for the Slack provider, set:

- **Client ID** — the Slack app's client ID.
- **Client secret** — the Slack app's client secret.
- **Redirect URI** — the callback URL you registered above; it must match exactly.

Save, and the Slack login option appears on the login form.

## Store the client secret safely

The Slack client secret is a real credential. Rather than committing it to
exported configuration:

- Store it in an environment variable with DDEV's dotenv command — for example
  `ddev dotenv set .ddev/.env --slack-client-secret=<value>` — then
  `ddev restart`. Never commit `.ddev/.env`.
- Reference it through a **Key** entity backed by the environment provider where
  the workflow allows.

## The OAuth flow lives in the base module

This module is only the Slack provider plugin; the authorize redirect, callback,
and OAuth **state** handling all live in the base **League OAuth Login**
module. See the
[base module's configuration guide](../../../league_oauth_login/2.0.x/human-docs/configuration/index.md).
Always serve the site over **HTTPS**.

## Save

Click **Save configuration**, then test the full round trip over HTTPS: click the
Slack login button, approve at Slack, and confirm you return logged in to the
correct Drupal account.
