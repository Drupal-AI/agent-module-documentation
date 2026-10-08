# Configuration

Getting Hivo Connector working is a short sequence: connect your Hivo account,
optionally add the embed button to a text format, and — importantly — handle the
connection credentials the secure way.

## 1. Connect your Hivo account

1. Log in as an administrator and go to **Administration → Hivo Connector**
   (`/admin/hivo-connector`).
2. Log in with your **Hivo account** credentials. This establishes the connection
   Drupal uses to browse, download, and upload assets.

Once connected, editors with the module's permission can pull Hivo assets into the
Drupal media library and push Drupal media up to Hivo.

## 2. Add the Hivo button to a text format (for CDN embedding)

To let editors embed Hivo media inside rich‑text fields, delivered from Hivo's
CDN:

1. First confirm **CDN embedding is enabled in your Hivo account** — without it,
   CDN embeds will not work.
2. In Drupal, go to **Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
3. Edit a format that **uses CKEditor 5** and **drag the "Hivo" button** into the
   active toolbar.
4. Save the format. Editors using that format can now insert Hivo media via its
   CDN URL.

## 3. Store credentials securely (important)

Hivo Connector authenticates against an external service, so treat any API key,
token, or secret it needs as a **secret** — never hard‑code it in `settings.php`
or commit it to version control.

If you are running under **DDEV**, the recommended pattern is:

1. Save the secret into DDEV's dotenv file (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --hivo-api-key=<value>
   ddev restart
   ```

   The flag `--hivo-api-key` becomes the environment variable `HIVO_API_KEY`
   inside the web container.

2. Where the value should live as a **Key** entity, install the Key module if it
   isn't already enabled and create an env‑backed key:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save hivo_api_key --label='Hivo API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"HIVO_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

This keeps the secret out of the database and out of Git while still making it
available to Drupal.

## 4. Make sure the site can reach Hivo (egress)

Because the module calls Hivo's API and (for CDN embeds) serves media from Hivo's
CDN, the server must be allowed to make **outbound HTTPS requests** to Hivo. If
your environment restricts outbound traffic, allow egress to Hivo's endpoints;
otherwise downloads, uploads, and CDN embeds will fail or time out.

## Permissions

Hivo Connector provides its own permissions. Review them at **People →
Permissions** and grant the connector and embedding permissions only to the
editor and administrator roles that should manage Hivo assets.
