# Configuration

Acquia CMS DAM does nothing until it is connected to your **Acquia DAM** account.
Configuration is essentially one task: supply the Acquia DAM credentials so Drupal
can pull assets from the platform.

## Before you start

- You need an active **Acquia DAM** subscription and the credentials for it
  (obtained from your Acquia DAM account — the exact form depends on your
  subscription).
- Decide where those credentials will live. **Never hard-code or commit a
  secret.** Store the value in an environment variable, and where the integration
  supports it, reference it through a **Key** entity rather than pasting it into a
  form that saves it in plain config.

## Store the credentials securely

The recommended pattern on this project is:

1. Save the secret into the environment with DDEV's dotenv command, for example:

   ```bash
   ddev dotenv set .ddev/.env --acquia-dam-token=<value>
   ddev restart
   ```

   (`.ddev/.env` must stay out of version control.)
2. Install the **Key** module if it isn't already enabled
   (`ddev composer require drupal/key && ddev drush en key -y`).
3. Create a **Key** entity backed by the environment provider so the value is read
   from the environment variable at runtime and never stored in exported config.

Then point the Acquia DAM integration at that Key rather than typing the secret
into a settings field.

## Connect the module

With the credentials available, open the Acquia DAM settings for the site (under
**Configuration**, in the media/DAM area) and enter or select the credential/Key
so Drupal can authenticate to Acquia DAM. Save the form.

Once connected, DAM-hosted assets become selectable from the **Media library**,
and you can reference them from media fields like any other media. If assets do
not appear, re-check that the credentials are valid and that the environment
variable is actually present in the container.
