# Configuration

Getting Resend sending your site's mail is a three-step job: store your API key
securely, enter it on the Resend API settings page, and tell Mail System to use the
Resend backend.

## Step 1 — Store your Resend API key as a secret

Your Resend API key is a credential. Never paste it into code or commit it to
version control. The safe pattern is an environment variable surfaced to Drupal
through a **Key** entity.

If you are using DDEV, save the value into your local env file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --resend-api-key=<your-key>
ddev restart
```

This makes the variable `RESEND_API_KEY` available inside the container. (Keep
`.ddev/.env` out of version control.)

Then install the **Key** module if it is not already enabled and create a Key that
reads from that environment variable:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev drush key:save resend_api_key --label='Resend API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"RESEND_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Step 2 — Enter the key on the Resend API settings page

1. Go to **Configuration → System → Resend API**
   (`/admin/config/system/resend-api`).
2. Provide your Resend API key. If the form offers a Key selector, choose the
   **Resend API Key** you created above rather than pasting the raw value; where a
   plain field is the only option, be aware the value is stored in configuration and
   keep it out of exported, committed config.
3. Save the form.

## Step 3 — Select Resend as the mail backend

1. Go to **Configuration → System → Mail System**
   (`/admin/config/system/mailsystem`).
2. Set the sender (formatter/sender plugin) to **Resend API** so outgoing mail is
   handed to this module. You can set it as the site-wide default or scope it to a
   particular module's mail.
3. Save.

## Verify your sending domain

The domain of your site email address (set at **Configuration → System → Basic site
settings**, `/admin/config/system/site-information`) must be **verified in your
Resend account**, or Resend will reject the messages. For testing without a verified
domain, set your site email to an `@resend.dev` address.

## Send a test

Trigger any site email — for example request a password reset, or use a contact
form — and confirm it arrives and shows up in your Resend dashboard's activity log.
