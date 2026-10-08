# Configuration

Media Orange Logic needs to know where your DAM's API lives and how to
authenticate to it. That's all set on one admin form — but because it involves
credentials, treat the values as secrets.

## Open the settings form

1. Log in as a user with the **Administer Orange Logic** permission (and access to
   administration pages).
2. Go to **Configuration → Media → Media Orange Logic**, or navigate directly to
   `/admin/config/media/media-orange-logic`.

## Fields on the form

- **API / search endpoint** — the base URL of your Orange Logic (Cortex) DAM's
  search API. The module builds its criteria queries against this endpoint.
- **Token endpoint** — the URL used to obtain an API token. The module requests a
  token here and caches it (in a private tempstore) so it doesn't re‑authenticate
  on every request.
- **Authentication / credentials** — the login (username and password, or the
  credentials your DAM issues) the module uses to obtain that token.

After filling these in, save the form. Once valid credentials are stored, the
entity‑browser widget can search the DAM (by keyword, artist, media type, system
identifier, and so on) and editors can reference the returned assets as Drupal
media.

## Store the credentials securely

The DAM credentials are secrets, so keep them out of code and out of version
control:

1. **Save the value into an environment variable via DDEV's dotenv** (never commit
   `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --orange-logic-password=<value>
   ddev restart
   ```

   The flag `--orange-logic-password` becomes the environment variable
   `ORANGE_LOGIC_PASSWORD` inside the web container.

2. **Confirm it's present without printing it:**

   ```bash
   ddev exec 'test -n "$ORANGE_LOGIC_PASSWORD"'
   ```

   An exit status of `0` means it's set.

3. **Reference it from Drupal.** Where the module (or a Key‑aware field) supports a
   **Key** entity, install the Key module (`ddev composer require drupal/key &&
   ddev drush en key -y`) and create a Key backed by the environment provider so
   the secret is never stored in exported configuration. Where a Key entity does
   not apply, reference the variable from `settings.php` via
   `getenv('ORANGE_LOGIC_PASSWORD')` and feed it into the module's configuration.

## Egress and network access

The module reaches your DAM over the network from the server side. Make sure your
hosting environment permits **outbound HTTPS** to the DAM's API and token
endpoints, or searches and token requests will fail.

## Security reminder

As noted in the [overview](../index.md), the entity‑browser AJAX endpoint
(`/media-orange-logic/eb/ajax/selected-assets`) is gated only by the "access
content" permission and uses the site's stored DAM token. Review that exposure
against your DAM's access model — the credentials you enter here are what that
endpoint uses on behalf of any such user.
