# Configuration

Phaxio needs your account's API credentials before it can send faxes or make sense
of status callbacks. You enter them on the module's settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Open the module's **Phaxio settings** form from the **Configuration** area of
   the admin menu.

## What you need from Phaxio

Sign in to your [Phaxio account](https://www.phaxio.com/) and copy:

- **API key** — the public identifier for your Phaxio API credentials.
- **API secret** — the matching secret. Treat this as a **secret** — anyone with it
  can send faxes billed to your account.

Enter both on the settings form and save.

## Keep the API secret out of version control

The API secret is a credential and should not be committed to your repository in
exported configuration. Store it in an environment variable and reference it at
runtime rather than hard‑coding it.

With DDEV, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --phaxio-api-secret=<your-secret>
ddev restart
```

Then reference the variable from your settings (for example a configuration
override in `settings.php` using `getenv('PHAXIO_API_SECRET')`) so the live secret
stays in the environment. Never commit `.ddev/.env` or the raw secret.
