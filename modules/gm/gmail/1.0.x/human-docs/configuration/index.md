# Configuration

Configuring Gmail API means creating an OAuth client in Google Cloud, telling
Drupal about it, and completing a one-time consent so Google issues the tokens the
module needs to send mail.

## Step 1 — Create the OAuth client in Google Cloud

1. Open the [Google Cloud console](https://console.cloud.google.com/) and create a
   new project (or select an existing one).
2. Under **APIs & Services → Library**, find and **enable the Gmail API**.
3. Under **APIs & Services → Credentials**, choose **Create credentials → OAuth
   client ID**, and pick **Web application** as the application type.
4. Give it a name, and under **Authorized redirect URIs** add your site's callback
   URL exactly:

   ```
   https://<your-site>/gmail-api/callback
   ```

5. Click **Create**. Google shows you a **client ID** and **client secret** — copy
   both; you need them in the next step.

## Step 2 — Enter the credentials in Drupal

1. Log in as a user with the **Administer Gmail module** permission.
2. Go to **Configuration → System → Gmail API** (`/admin/config/system/gmail`).
3. Enter the **client ID** and **client secret** from Google and save.

These values are stored in the module's `gmail.settings` configuration.

## Step 3 — Complete the Google consent flow

From the settings form, launch the Google consent flow. Google will ask you to
sign in and approve the *send mail* scope, then redirect back to
`/gmail-api/callback`. The module exchanges the returned authorization code for an
**access token and a refresh token** (requested with offline access, so the
refresh token can renew sending without you re-approving each time) and stores them
in configuration.

If sending later stops working because a token has expired or been revoked, simply
re-run the consent flow to obtain fresh tokens.

## Step 4 — Route your mail through Gmail

Enabling the module does not by itself redirect every email. Select the
`GmailSystem` plugin as the mailer for the mail keys you want to send through
Gmail — typically via the **Mail System** or **Symfony Mailer** module, which let
you choose a mail backend per module/key. Then send a test email (for example a
password-reset request) and confirm it arrives.

## Keeping the credentials safe

The client secret and the OAuth tokens are sensitive. A few precautions:

- Keep the **Administer Gmail module** permission restricted to trusted
  administrators — it controls the credentials and the connection.
- Prefer supplying secrets through the environment rather than committing them in
  exported configuration. With DDEV you can store a value out of Git:

  ```bash
  ddev dotenv set .ddev/.env --gmail-client-secret=<value>
  ddev restart
  ```

  (The flag `--gmail-client-secret` becomes the variable `GMAIL_CLIENT_SECRET`;
  keep `.ddev/.env` out of version control.)
- The module reaches Google's servers to send mail, so your host must allow
  **outbound HTTPS** to the Gmail API.
