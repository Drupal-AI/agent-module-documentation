# Configuration

Before the subscribe block can do anything useful, you need to give the module
your APSIS API key and confirm the endpoint it should talk to.

## Open the settings form

1. Log in as a user with the **Administer apsis mail** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Apsis mail**, or navigate directly to
   `/admin/config/services/apsis_mail`.

## The settings

- **API key** — the credential that authenticates your site to APSIS. The module
  stores this in Drupal's `state` store, **not** in exported configuration, so it
  will not be written to your config files or committed to Git. It is sent to
  APSIS as an HTTP `Basic` authorization header.
- **API URL / API port** — the APSIS environment to connect to. A default
  (`se.api.anpdm.com:8443`) ships with the module; change it if your APSIS
  account uses a different host or port.
- **Use SSL (`api_ssl`)** — **keep this on.** When on, the module talks to APSIS
  over `https://`; when off it falls back to plain `http://`, which would send
  your API key over an unencrypted connection. Turn it off only for local testing
  against a non‑TLS endpoint, never in production.
- **Cache lifetime** — how long API responses may be cached (default 30 seconds).
- **Role → mailing‑list mapping (`user_roles`)** — optionally map site user roles
  to specific APSIS mailing lists so that different users are subscribed to the
  right list.

Save the form when you are done.

## Handling the API key as a secret

The key you enter here lives in Drupal's `state` store, so it stays out of your
exported configuration by design — that is already the safe place for it. If you
would rather not paste the key into a browser form on a shared environment, keep
it in an environment variable and set the state value from there instead. With
DDEV:

```bash
ddev dotenv set .ddev/.env --apsis-api-key=<your-key>
ddev restart
```

Then, inside the container, write it into state from the variable (so the secret
never appears in your shell history or in committed config):

```bash
ddev drush state:set apsis_mail.api_key "$APSIS_API_KEY" --input-format=string
```

Never commit `.ddev/.env` and never hard‑code the key into `settings.php` or a
config file.

## Place the subscribe block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the **Apsis mail subscribe** block in the region where you want the
   signup form to appear.
3. Make sure the roles that should see it have the **View apsis mail block**
   permission (**People → Permissions**).

## Verify it worked

Visit a page where the block appears, submit a test email address, and confirm
the subscriber shows up in your APSIS account. Because submissions are handed to
a queue, the sync happens on the next queue run (cron), not necessarily the
instant you submit.
