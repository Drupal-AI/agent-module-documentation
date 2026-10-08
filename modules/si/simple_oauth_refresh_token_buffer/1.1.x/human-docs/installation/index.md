# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Simple OAuth** module (`simple_oauth`) enabled — this module extends its
  refresh-token handling and does nothing on its own.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_refresh_token_buffer -W
```

The Composer package name (`drupal/simple_oauth_refresh_token_buffer`) matches
the module's machine name (`simple_oauth_refresh_token_buffer`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_refresh_token_buffer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_refresh_token_buffer -y
```

After enabling, set the grace period on each OAuth2 consumer you want to protect
— see the [main guide](../index.md) for the steps. Keep the window short (the
default is 30 seconds; the range is 1–60).

## Verify it worked

Edit a Simple OAuth consumer and confirm you now see a **grace period** setting on
its edit form. To confirm the behaviour end to end, have a client fire two
near-simultaneous refresh requests with the same refresh token — with the buffer
active, both should succeed and return the same tokens rather than the second one
failing.
