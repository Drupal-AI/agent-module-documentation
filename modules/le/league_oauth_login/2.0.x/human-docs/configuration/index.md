# Configuration

League OAuth Login is configured **per provider**. The base module supplies the
shared login flow (redirect out, callback, token exchange, account
provisioning); each provider submodule (GitHub, GitLab, Bitbucket, Slack, …)
carries the settings for that particular login source. So the pattern is the same
whichever provider you use: register an OAuth application at the provider, then
enter its credentials in Drupal.

## The OAuth login model, briefly

When a visitor chooses "log in with *provider*", Drupal redirects them to the
provider to approve access. The provider sends them back to your **redirect URI**
(the callback) with an authorization `code`. The module exchanges that code for a
token, reads the identity (username and email) from the provider, and uses
**External Authentication** to match or create the corresponding Drupal account.
No provider password ever touches your site.

## Register an OAuth application at the provider

For each provider you enable:

1. Create an **OAuth application / client** in the provider's developer settings.
2. Set its **callback / redirect URL** to your site's League OAuth Login callback.
3. Note the **client ID** and **client secret** it issues.

## Enter the credentials in Drupal

In the provider's configuration you will set:

- **Client ID** — the public identifier the provider issued for your application.
- **Client secret** — the confidential secret the provider issued. Treat this as
  a real secret (see below).
- **Redirect URI** — the callback URL you registered with the provider; it must
  match exactly.

Save, and the provider's login option becomes available on the login form.

## Store the client secret safely

The client secret is a genuine credential — anyone holding it can impersonate
your application to the provider. Do not commit it to exported configuration in
the clear:

- Store the value in an environment variable with DDEV's dotenv command — for
  example `ddev dotenv set .ddev/.env --github-client-secret=<value>` — and then
  `ddev restart` so the container loads it. Never commit `.ddev/.env`.
- Reference it through a **Key** entity backed by the environment provider where
  the workflow allows, so the raw secret stays out of config and version control.

## Save

Click **Save configuration** for each provider, then test the full round trip
over HTTPS: click the provider's login button, approve at the provider, and
confirm you return logged in to the correct Drupal account.
