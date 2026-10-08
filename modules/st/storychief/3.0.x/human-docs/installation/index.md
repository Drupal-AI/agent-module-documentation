# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3.0 || ^10 || ^11`).
- A **StoryChief workspace** — this is where you create the Drupal destination that
  connects to your site. You can sign up for free on the StoryChief site.
- No third-party Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/storychief -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/storychief -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en storychief -y
```

## Next steps

After enabling, complete the connection:

1. In your **StoryChief workspace**, create a **Drupal destination** pointing at
   this site.
2. In Drupal, open the module's settings, save your **encryption/API key**, and
   **map the fields** — see [Configuration](../configuration/index.md).
3. Publish a story from StoryChief and confirm it appears as content on your site.

## Verify it worked

Once the key is saved and fields are mapped, publish a test story from StoryChief.
It should arrive over the webhook and be created as Drupal content. If nothing
appears, the most common cause is a key mismatch — the module rejects any request
whose HMAC signature does not match the configured key, so double-check the key is
identical on both sides.
