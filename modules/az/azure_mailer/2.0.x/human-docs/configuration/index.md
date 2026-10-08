# Configuration

Azure Mailer has just two settings — an **endpoint** and a **secret** — plus one
wiring step in Mailsystem. The endpoint goes on the admin form; the secret is set
out‑of‑band and never through the UI.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Azure Communication Service mailer**, or
   navigate directly to `/admin/config/config/azure_mailer`.

## Endpoint

- **Endpoint** — the ACS host **only**, with no scheme. For example
  `yoursite.communication.azure.com`. The module prepends `https://` and appends
  the ACS send path (`/emails:send?api-version=2023-03-31`) for you, so do not
  include those parts yourself.

Enter the endpoint and click **Save**.

## Secret (set this out‑of‑band)

The **secret** is the ACS access key used to sign every request. The field for it
on the settings form is intentionally **disabled and blank** — it is never
editable or shown in the UI, so the key stays out of the database and out of
exported configuration. Set it one of two ways instead:

**Recommended — in `settings.php`, from an environment variable:**

```php
$config['azure_mailer.settings']['secret']   = getenv('AZURE_COMM_SECRET');
$config['azure_mailer.settings']['endpoint'] = getenv('AZURE_COMM_ENDPOINT');
```

This lets you keep the key in your hosting environment's secret store and use a
different endpoint per environment (dev / stage / prod). With DDEV, save the value
with `ddev dotenv set .ddev/.env --azure-comm-secret=<value>` and restart so it is
available as `AZURE_COMM_SECRET` in the container.

**Or set it once with Drush:**

```bash
drush config:set azure_mailer.settings secret '<acs-access-key>' -y
```

## Make Azure Mailer the active backend (Mailsystem)

Azure Mailer only sends when Drupal's mail system routes messages to it. Go to
**Configuration → System → Mailsystem** (`/admin/config/system/mailsystem`) and set
the **Formatter** and/or **Sender** to *Azure Communication Service* — either as
the site‑wide default, or for a specific module/mail key. Until you do this,
nothing is sent through ACS.

## Verify it worked

Check that the endpoint is stored (the secret comes from `settings.php`, so it may
not show here):

```bash
drush config:get azure_mailer.settings
```

Then trigger a test email — for example request a password reset. If ACS accepts
the message, the send succeeds silently. If the request fails, the module surfaces
a Drupal error message beginning *"Azure Communication Services error: …"* and the
send returns as failed, so watch for that.
