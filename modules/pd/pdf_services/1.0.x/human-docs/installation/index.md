# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — enabled on standard installs.
- The **Key** module (`key`) — used to store the Adobe API credentials securely.
  Composer installs it as a dependency.
- **Adobe PDF Services API credentials** — a Client ID and Client Secret. Sign up
  for these on Adobe's developer site; there is no way to use the module without
  them.
- Optional: an HTML email module such as *Symfony Mailer Lite* if you want richly
  formatted editor notifications.

> **Data handling:** this module sends uploaded PDFs to Adobe's cloud API for
> processing. Confirm that outbound transfer of your documents to a third party is
> acceptable, disclose it in your privacy policy, and serve the site over HTTPS.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_services -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed, and it brings in the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_services -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf_services key -y
```

## Store the Adobe credentials as a secret (recommended)

Rather than pasting the Adobe Client Secret into a configuration field, keep it in
an environment variable and reference it from a **Key** entity. With DDEV, set the
variable and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --adobe-pdf-client-secret=<your-secret>
ddev restart
```

Then create a Key that reads from the environment (adjust the label and variable
name to suit your setup):

```bash
ddev drush key:save adobe_pdf_client_secret \
  --label='Adobe PDF Client Secret' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"ADOBE_PDF_CLIENT_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Never commit `.ddev/.env` or hard‑code the secret. You will select this Key on the
module's settings form — see [Configuration](../configuration/index.md).

## Verify it worked

Open **Configuration → Content authoring → PDF Services**
(`/admin/config/content/pdf-services`). If the settings form loads and offers
fields for your Adobe credentials, the module is installed. Complete the setup in
[Configuration](../configuration/index.md), then upload a PDF and check the queue
dashboard for processing activity.
