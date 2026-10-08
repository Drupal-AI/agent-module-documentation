# Configuration

Setting this up has three parts: register an application in Microsoft Entra ID,
give Drupal its details (with the client secret stored safely via the Key module),
and authorise the connection — then point PHPMailer SMTP at it.

## 1. Register an application in Microsoft Entra ID

In the [Microsoft Entra admin center](https://entra.microsoft.com/), register an
application for Drupal to use and note:

- the **Application (Client) ID**,
- the **Directory (Tenant) ID**, and
- a **client secret** you generate for the app.

Grant the app the mail‑sending permission for your mailbox, and add the module's
authorisation callback URL as a redirect URI (the module's settings page shows the
callback it uses).

## 2. Store the client secret (via Key + an environment variable)

The client secret is a credential and must never be written into Drupal's exported
configuration. This module reads it from the **Key** module, which is best backed by
an environment variable.

The module ships a ready‑made Key entity (`phpmailer_azure_oauth2_client_secret`)
that reads the secret from the `PHPMAILER_OAUTH2_CLIENT_SECRET` environment variable
automatically. So the simplest path is to set that variable.

With DDEV, save the value into the project's dotenv file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --phpmailer-oauth2-client-secret=<your-client-secret>
ddev restart
```

The variable name is `PHPMAILER_OAUTH2_CLIENT_SECRET`, which is what the included Key
entity expects. Never commit `.ddev/.env` or the raw secret. (If you prefer, you can
create your own Key entity instead and select it in step 3.)

## 3. Configure the module

1. Log in as a user with the **administer phpmailer azure oauth2 settings**
   permission.
2. Go to **Configuration → System → PHPMailer Azure OAuth2**
   (`/admin/config/system/phpmailer-azure-oauth2`) and enter:
   - **Mailbox email address** — the address the site sends from.
   - **Application (Client) ID** — from your Entra ID app registration.
   - **Directory (Tenant) ID** — from your Entra ID app registration.
   - **Client secret Key** — leave this on the default
     (`phpmailer_azure_oauth2_client_secret`) unless you created your own Key entity,
     in which case choose it here.
3. Save.

## 4. Authorise with Microsoft Entra ID

Click **Authorize with Microsoft Entra ID**, sign in to the Microsoft account for
the mailbox, and grant the application permission. The module stores the resulting
access and refresh tokens in Drupal's **State API** (kept out of configuration
export). From then on it refreshes the tokens automatically on cron, and will warn
administrators if a refresh token has not renewed after about 75 days.

## 5. Point PHPMailer SMTP at it

Finally, on the **PHPMailer SMTP** settings page, choose **Azure OAuth2 (Key module +
State API)** as the SMTP authentication type. Drupal now sends mail through Microsoft
365 SMTP using OAuth2. Send a test email to confirm delivery.

## Migrating from `phpmailer_oauth2`

If you were already using the older `phpmailer_oauth2` module, this module includes a
two‑step migration wizard that imports your existing configuration and OAuth2
tokens — so you do not need to re‑register the app or re‑authorise from scratch.
