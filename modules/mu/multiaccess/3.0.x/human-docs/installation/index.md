# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.x** with the **OpenSSL** functions available (the module uses RSA
  encryption for its server‑to‑server messages).
- **Drush** — configuration and testing are driven by Drush helper functions.
- At least **two paired Drupal sites** (a source and a destination) that can reach
  each other over the network.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root, on **each** site that will take part:

```bash
composer require drupal/multiaccess -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multiaccess -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiaccess -y
```

To add the optional account tab and redirect route for users, also enable the
submodule:

```bash
drush en multiaccess_uli_ui -y
```

## Configure integrations (settings files + Drush)

Multiaccess has **no admin UI**. You configure it in **unversioned local settings
files** (site UUIDs, URLs, RSA key pairs, and role mappings) and drive it with
Drush:

1. On each site, add the integration configuration to a local settings file that is
   **not** committed to version control.
2. Register a destination integration with `multiaccess_new_integration()`.
3. Run `multiaccess_selftest()` to verify the pairing works end to end.
4. Use `multiaccess_list()` to review configured destinations and their UUIDs.

To issue a one‑time login link from code:

```php
\Drupal::service('multiaccess.integration_destination_factory')
  ->fromDestinationUuid($uuid)
  ->uli('/some/destination/path');
```

## Keep keys and settings out of version control

This is the most important rule for Multiaccess. The RSA key pairs and settings
files are the entire basis of the trust between paired sites, so:

- Never commit the key pairs or the integration settings files to Git.
- Keep them readable only by the site's own processes.
- Treat each source site as able to log users into its paired destinations, and
  review that trust relationship before deploying.

## Verify it worked

Run `drush multiaccess_selftest()` (via `drush php:eval` or the provided command
path) on a configured site. A successful self‑test confirms the key pairs and
integration settings are wired correctly. If you enabled `multiaccess_uli_ui`, load
`/user/{user}/multiaccess` and confirm the **Remote sites** tab appears.
