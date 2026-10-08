# Configuration

To let editors pull assets from Frontify, connect Drupal to your Frontify platform.
This is a short, two-field setup, but one of the values is a credential — treat it
as a secret.

## Before you start: get a Client ID

Log in to your Frontify platform and generate a **Client ID** for the integration.
You will also need your Frontify **API URL** — the address of your Frontify
instance, for example `https://test.frontify.com`.

## Open the settings form

1. Log in as a user with the module's Frontify administration permission (an
   administrator by default).
2. Go to **Configuration → Media → Frontify Settings**.

## Fields

- **Frontify API URL** — the base URL of your Frontify instance, such as
  `https://test.frontify.com`. Use the HTTPS address.
- **Client ID** — the client identifier you generated in the Frontify platform. This
  authorises the Frontify Finder 2 browser to reach your asset library.

Click **Save configuration**. The Frontify Finder 2 browser will then be able to
authenticate and list your assets from Drupal fields and WYSIWYG editors.

## Store the credentials as secrets

The Client ID should not be hard-coded or committed to your repository. The
recommended pattern on this project:

1. Save the value into an environment variable with DDEV's dotenv helper, which
   keeps it out of version control:

   ```bash
   ddev dotenv set .ddev/.env --frontify-client-id=<value>
   ddev restart
   ```

   The flag `--frontify-client-id` becomes the environment variable
   `FRONTIFY_CLIENT_ID` inside the web container. Never commit `.ddev/.env`.

2. Confirm the variable is present in the container *without* printing its value
   (`ddev exec 'test -n "$FRONTIFY_CLIENT_ID"'` — exit status 0 means it is set),
   then reference it rather than pasting the raw value where possible. Where the
   module accepts a [Key](https://www.drupal.org/project/key) entity, store the
   credential with the Key module's environment provider.

## A note on data flow

Assets are hosted in and referenced from Frontify — an external platform — so keep
its availability and access model in mind, and ensure all API communication uses
HTTPS. This module provides asset integration only; it has no access-control role on
your Drupal site beyond its own administration permission.
