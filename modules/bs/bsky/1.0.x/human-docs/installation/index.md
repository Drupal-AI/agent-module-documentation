# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Key** module (`drupal/key`) — BlueSky Integration depends on it to store
  your Bluesky credentials securely.
- A Bluesky account, and an **app password** generated for that account (create
  it in Bluesky under Settings → App Passwords).

## Install with Composer

From the project root:

```bash
composer require drupal/bsky -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Key module dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bsky -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bsky -y
```

Drupal enables the Key module automatically as a dependency.

## Store your Bluesky credentials securely

Do not paste your Bluesky app password into a normal settings field where it
would end up in exported configuration. Instead:

1. Keep the secret in an environment variable. With DDEV:
   ```bash
   ddev dotenv set .ddev/.env --bsky-app-password=<value>
   ddev restart
   ```
   Never commit `.ddev/.env`.
2. Create a **Key** entity that reads from that variable using Key's environment
   provider, then point BlueSky Integration at that Key.

This keeps the credential out of the database export and out of version control.
