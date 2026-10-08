# Configuration

Configuring Stackla Widget is a two-step job: fill in the settings form with your
Stackla account details, then run the OAuth2 authorise flow so Drupal obtains an
access token. After that you add the widget field to your content.

## Open the settings form

1. Log in as a user with the **Administer stackla** (`administer stackla`)
   permission.
2. Go to **Configuration → Web services → Stackla Widget → Settings**, or navigate
   directly to `/admin/config/services/stackla_widget/settings`.

## Settings

- **Stack shortname** — your Stackla stack's shortname (required).
- **Client ID** and **Client secret** — your OAuth2 credentials from Stackla, both
  required. The secret is shown in a plain text field and stored in module
  configuration, so treat access to this form as sensitive.
- **Refresh interval** — how often (in seconds) widget data is refreshed. A value
  of `-1` means it refreshes on every cron run.
- **Proxy status / Proxy URL** — an optional outbound proxy for the Stackla API
  calls. **See the security note below before enabling this** — turning the proxy
  on disables TLS certificate verification in the module's HTTP client.
- **Debug mode** — verbose request logging for development. **Leave this off in
  production** (see the security note below).

## Run the OAuth2 authorise flow

1. On the settings form, copy the read-only **Callback URL** and paste it into your
   Stackla plugin configuration on the Stackla side.
2. Paste the **Client ID** and **Client secret** that Stackla gives you back into
   the form and save.
3. Click **Authorize**. You are redirected to Stackla to approve the connection,
   and Stackla then calls back to Drupal with an authorization code.
4. Drupal exchanges that code for an access token and stores it. You can later use
   the **Reauthorize** and **Revoke** buttons to refresh or clear the stored token.

## Add the widget field

With the site authorised, go to **Structure → Content types**, open **Manage
fields** for the content type you want, and add the **Stackla widget** field. When
editing content of that type, an author can then select a Stackla widget by id, and
the published page renders the embedded widget.

## Security notes worth acting on

These come from the module's own behaviour and are worth taking seriously:

- **Think twice before enabling the proxy.** When the proxy option is on, the
  module's HTTP client disables TLS certificate verification. That means the OAuth
  token exchange — which carries your client secret — and the returned access token
  travel without the certificate being checked, exposing them to a
  man-in-the-middle on that path. Leave the proxy off unless you completely trust
  the network route.
- **Keep debug mode off in production.** With debug mode on, the OAuth callback
  writes the full client id, client secret, authorization code, and callback to the
  log in cleartext. Anyone who can read your logs would then see your Stackla
  secret.
- **Protect and, if needed, rotate the client secret.** It is stored in module
  configuration and displayed in a plain text field. If debug logging may ever have
  captured it, rotate the secret in Stackla and re-enter it here.
