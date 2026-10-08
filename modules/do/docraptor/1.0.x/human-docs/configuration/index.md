# Configuration

DocRaptor's configuration is essentially one thing done well: giving the module
your **DocRaptor API key** without ever writing the secret into configuration or
version control. The module uses the **Key** module for exactly this, so the steps
below create a Key entity that reads the secret from an environment variable.

## Store the API key securely (recommended)

The safest pattern is to keep the API key in an environment variable and let a Key
entity read it. With **DDEV**, that looks like this:

1. **Save the secret into DDEV's env file** (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --docraptor-api-key=YOUR_DOCRAPTOR_KEY
   ddev restart
   ```

   The flag `--docraptor-api-key` becomes the environment variable
   `DOCRAPTOR_API_KEY` inside the web container.

2. **Confirm the variable is present** without printing its value:

   ```bash
   ddev exec 'test -n "$DOCRAPTOR_API_KEY" && echo set'
   ```

3. **Create the Key entity** that reads that variable. Either use the UI at
   **Configuration → System → Keys → Add key** (`/admin/config/system/keys/add`),
   choosing the **Environment** key provider and pointing it at `DOCRAPTOR_API_KEY`,
   or run:

   ```bash
   ddev drush key:save docraptor_api_key \
     --label='DocRaptor API Key' \
     --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"DOCRAPTOR_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

On a non-DDEV server, set the `DOCRAPTOR_API_KEY` environment variable through your
hosting platform (or your web server / process manager) and create the same
environment-provider Key entity.

> **Prefer not to use an environment variable?** The Key module also offers a
> "Configuration" provider that stores the value in Drupal's key-value store. It is
> simpler but keeps the secret inside the database, so the environment-variable
> approach above is preferred for anything beyond quick local testing.

## Point DocRaptor at the key

Once the Key entity exists, select it as DocRaptor's API key in the module's
settings (the module reads the DocRaptor API key from the Key you designate). If you
created the key via the UI, you will see it listed at **Configuration → System →
Keys** (`/admin/config/system/keys`).

## Data-egress caveat — read before generating PDFs

DocRaptor is a **cloud service**. When the module generates a PDF, it **sends your
HTML content to DocRaptor's API over the internet**, where Prince renders it and
returns the PDF. Keep this in mind:

- **Sensitive content leaves your server.** If the HTML you convert can contain
  personal, confidential, or regulated data, confirm that transmitting it to a
  third-party service is acceptable under your privacy and compliance obligations.
- **Always use HTTPS**, both for your own site and for the DocRaptor endpoint, so
  the content and API key are protected in transit.
- **The key controls billable usage.** Anyone who can trigger PDF generation is
  spending against your DocRaptor account, so grant the module's permission only to
  trusted roles.

## Permission

DocRaptor provides its own permission; grant it (at **People → Permissions**) only
to the roles that should be able to generate PDFs. The module has no other
access-control role beyond this permission.
