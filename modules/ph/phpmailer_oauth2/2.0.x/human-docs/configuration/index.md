# Configuration

Getting mail flowing has three parts: register an app in Azure, fill in the
settings form, and run the token‑exchange flow so Drupal obtains a refresh token.

## Before you start — register the Azure app

In the Azure portal, create (or reuse) an **app registration** for your tenant:

1. Add a **redirect URI** pointing at this site's callback. The exact URL is shown
   on the settings form (below); it takes the form
   `https://your-site.example/phpmailer_oauth2/aad-callback`.
2. Grant the **`SMTP.Send`** delegated permission (under Office 365 Exchange
   Online / Outlook).
3. Create a **client secret** and copy its value.
4. Note the app's **Application (client) ID** and the **Directory (tenant) ID**.

You will also want PHPMailer SMTP configured to use OAuth2 with the **azure**
provider (in that module's own configuration), so it authenticates through this
module when sending.

## Open the settings form

1. Log in as a user with the **Administer phpmailer oauth2 settings** permission
   (a restricted‑access permission — grant it only to trusted administrators).
2. Go to **Configuration → System → PHPMailer OAuth2**
   (`/admin/config/system/phpmailer-oauth2`).

## Fill in the fields

- **Email address** — the mailbox / user name used to authenticate and send (the
  account whose mailbox the mail goes out from).
- **Client ID** — the Azure app registration's Application (client) ID.
- **Client secret** — the client secret you created in Azure. The field is a
  password field; leaving it blank when you re‑save keeps the previously stored
  secret, so you do not have to retype it every time.
- **Tenant ID** — the Azure directory (tenant) ID.

The form also prints the exact **redirect URI** you must register in Azure — copy
it from here if you have not added it yet. Save the form.

> **Keeping the secret out of the database:** the client secret is stored in
> configuration. To avoid committing it, set it from an environment variable in
> `settings.php`, e.g.
> `$config['phpmailer_oauth2.settings']['ms_client_secret'] = getenv('MS_CLIENT_SECRET');`.
> With DDEV, save it with `ddev dotenv set .ddev/.env --ms-client-secret=<value>`
> and restart.

## Run the token‑exchange flow

1. On the settings form, click **Get auth token**. Drupal redirects you to
   Microsoft's consent screen, requesting the `SMTP.Send` scope plus
   `offline_access` (which is what yields a long‑lived refresh token).
2. Consent as the mailbox account. Microsoft redirects back to the callback URL.
3. Drupal exchanges the returned authorization code for an access token and a
   refresh token and stores them, then returns you to the settings page. You
   should see confirmation that the tokens were retrieved.

The stored **refresh token** is what PHPMailer uses from then on to mint fresh
access tokens for each send — no password is ever stored. If the refresh token is
later revoked or expires, just click **Get auth token** again to re‑authorize.

## Troubleshooting

- Authorization or callback failures are logged to the **phpmailer_oauth2** logger
  channel (check **Reports → Recent log messages**) and shown as an error message.
- If Microsoft rejects the redirect, confirm the redirect URI registered in Azure
  exactly matches the one printed on the settings form.
- If mail still does not send after tokens are stored, confirm PHPMailer SMTP is
  set to use OAuth2 with the **azure** provider.
