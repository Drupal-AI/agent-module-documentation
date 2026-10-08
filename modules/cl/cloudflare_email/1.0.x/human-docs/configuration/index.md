# Configuration

Getting Cloudflare Email working is a four‑part process: store the API token in a
Key, fill in the settings form, make Cloudflare Email your default mail backend,
and send a test message.

## Step 1 — Store the API token in a Key

The module never keeps your token in its own config — it references a **Key**
entity instead. Create one first:

1. Go to **Configuration → System → Keys → Add key**
   (`/admin/config/system/keys/add`).
2. Set the **Key type** to **Authentication**.
3. Paste (or, better, reference) a Cloudflare API token that has the *Email
   Sending: Send* permission. For production, the **environment variable** or
   **file** key provider is recommended over storing the value in the database.

> **Keep the token out of version control.** With DDEV you can store it as an
> environment variable — `ddev dotenv set .ddev/.env --cloudflare-email-token=<value>`
> then `ddev restart` — and point the Key's environment‑variable provider at
> `CLOUDFLARE_EMAIL_TOKEN`. That way the secret never lives in the database or in
> exported config.

## Step 2 — Fill in the settings form

Go to **Configuration → System → Cloudflare Email**
(`/admin/config/system/cloudflare-email`); it requires the **Administer Cloudflare
email** permission. Set:

- **Account ID** — your Cloudflare account ID.
- **API token key** — select the Key entity you created in step 1. This is how the
  module resolves the secret at send time, via the Key repository.
- **Default from‑address and name** — the address messages are sent from. It
  **must be on a sending domain you have verified in the Cloudflare dashboard**,
  otherwise Cloudflare will reject the mail.
- **Sandbox mode** — when enabled, the module *logs* messages instead of actually
  sending them. Handy for staging and local development; turn it off in
  production.

## Step 3 — Make it the default mail backend

Enabling the module does not automatically capture Drupal's mail. Point Drupal's
mail system at it in one of two ways:

- In `settings.php`:

  ```php
  $config['system.mail']['interface']['default'] = 'cloudflare_email';
  ```

- Or install the **Mail System** module and select **Cloudflare Email** as the
  mail backend through its UI (useful if you only want certain mail routed through
  Cloudflare). The `cloudflare_email_symfony_mailer_lite` submodule offers a third
  route via Symfony Mailer Lite.

## Step 4 — Send a test message

Confirm everything is wired up with the bundled Drush command:

```bash
drush cloudflare-email:test you@example.com
```

Then check **Reports → Status report**, where the module's health check should now
report it as configured and active. Delivery is a straight HTTPS POST to
Cloudflare's send endpoint with a bearer token and a short timeout; errors are
raised with the HTTP status so transient and permanent failures can be told apart.
