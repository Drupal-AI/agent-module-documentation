# Configuration

Before editors can browse Frontify assets, you connect Drupal to your Frontify
account. The connection uses credentials and API access from Frontify, which are
**secrets** — treat them with the same care as any API key.

## Open the settings form

1. Log in as a user with the module's Frontify administration permission (an
   administrator by default).
2. Go to the Frontify settings page under **Configuration → Media** (config route
   `frontify.admin_config_frontify`).

## Connect to Frontify

On the settings form you provide the details that let the Frontify Finder
authenticate against your Frontify domain and load your asset library. These come
from your Frontify account/API configuration — generate them in Frontify first,
then paste them here. Save the form, and the Finder will be able to reach your
Frontify library.

You can also link Frontify to specific image fields so the Finder appears where you
want it, and the Finder will respect each field's configuration (allowed file types
and extensions, minimum/maximum resolution, required selections, and so on).

## Store the credentials as secrets

Frontify credentials should never be hard-coded or committed to your repository.
The recommended pattern on this project:

1. Save the value into an environment variable with DDEV's dotenv helper (this keeps
   it out of version control):

   ```bash
   ddev dotenv set .ddev/.env --frontify-api-token=<value>
   ddev restart
   ```

   The flag `--frontify-api-token` becomes the environment variable
   `FRONTIFY_API_TOKEN` inside the web container. Never commit `.ddev/.env`.

2. Where the module supports a **Key** entity for its credentials, store the secret
   with the [Key](https://www.drupal.org/project/key) module using its environment
   provider, rather than typing the raw value into the settings form. Install Key if
   it is not already enabled (`ddev composer require drupal/key && ddev drush en key
   -y`), confirm the variable is present in the container *without* printing its
   value (`ddev exec 'test -n "$FRONTIFY_API_TOKEN"'` — exit status 0 means it is
   set), then create the Key from that variable and reference the Key from the
   Frontify settings.

## A note on data flow

Assets are served from and referenced in Frontify — an external platform — so keep
its availability and access model in mind. All communication with the Frontify API
should go over HTTPS. This module governs asset sourcing and display; it does not
change who can access your Drupal content.
