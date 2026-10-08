# Configuration

Cloudinary needs your account credentials before it can store or transform any
media. Settings live at **Configuration → Media → Cloudinary**.

## Enter your credentials

1. Log in as a user with permission to administer the site configuration.
2. Go to **Configuration → Media → Cloudinary**.
3. Enter the three values from your Cloudinary dashboard:
   - **Cloud Name** — your Cloudinary cloud/account name.
   - **API Key** — the public API key.
   - **API Secret** — the secret key. Treat this like a password.

## Keep the secret out of plain configuration (recommended)

The API key and secret are credentials that grant access to your Cloudinary
account, so it is best practice **not** to store them in exported configuration.
Instead, read them from environment variables. In `settings.php` (or
`settings.local.php`):

```php
$config['cloudinary.settings']['cloud_name'] = getenv('CLOUDINARY_CLOUD_NAME');
$config['cloudinary.settings']['api_key'] = getenv('CLOUDINARY_API_KEY');
$config['cloudinary.settings']['api_secret'] = getenv('CLOUDINARY_API_SECRET');
```

> **Using DDEV?** Store the values as environment variables without committing them:
> `ddev dotenv set .ddev/.env --cloudinary-api-secret=<value>` (the flag
> `--cloudinary-api-secret` becomes `CLOUDINARY_API_SECRET`), then `ddev restart` so
> DDEV loads it into the web container. Keep `.ddev/.env` out of version control.

With the overrides in place, the values in `settings.php` win over anything stored
in the form, so the secret never lives in your database or config export.

## How image styles map to transformations

Once credentials are set, the module converts Drupal's standard image‑style effects
(crop, desaturate, resize, rotate, scale, scale‑and‑crop) into Cloudinary
transformations automatically — you configure image styles the usual way at
**Configuration → Media → Image styles**, and Cloudinary generates the derivatives
on demand.

## A note on data location

Remember that media handled by Cloudinary lives on Cloudinary's infrastructure, not
your server. Before going live, confirm that any non‑public or sensitive media is
handled appropriately given that the files reside remotely and are delivered through
Cloudinary's (potentially public) transformation URLs.
