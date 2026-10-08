# Configuration

Configuring TFA Migration comes down to one thing: giving it the **Drupal 7 private
key** so it can read and migrate the old site's TFA secrets. You can do this
through the settings form or in `settings.php`.

## Option A — the settings form

1. Go to `/admin/config/system/tfa-migration-settings`.
2. Enter the **Drupal 7 TFA private key** and save.

## Option B — set it in settings.php

Alternatively, define the key in your Drupal 9+ site's `settings.php`:

```php
$config['tfa_migration.settings']['drupal7_private_key'] = 'DRUPAL7_PRIVATE_KEY';
```

## Finding the Drupal 7 private key

The value you need is the old site's `drupal_private_key`. From the Drupal 7 site
you can retrieve it with Drush:

```bash
drush vget drupal_private_key
```

If Drush is not available, you can read it straight from the Drupal 7 database:

```sql
SELECT name, value FROM variable WHERE name = "drupal_private_key";
```

## Run the migration

With the key in place, run the migration through core's Migrate framework to move
the TFA seeds and settings into the new site's TFA module. Users who had two-factor
authentication configured on Drupal 7 will then keep working with their existing
authenticator apps rather than having to re-enrol.

## Handle the secrets with care

The data you are moving is **credential material**. A TOTP seed is the secret
behind a user's second factor, so if one leaks that user's two-factor protection is
undone. Keep the secrets flowing only through the Encrypt module (encrypted at
rest), never log or export them in plaintext, and run the whole migration as a
trusted operator over a secure channel — the same care you would give to migrating
passwords.
