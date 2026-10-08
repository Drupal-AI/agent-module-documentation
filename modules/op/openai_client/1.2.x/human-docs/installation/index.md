# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- An **OpenAI API token**. Create one in your OpenAI account at
  `https://platform.openai.com/account/api-keys`.

There are no additional contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/openai_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openai_client -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openai_client -y
```

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) and enter your
OpenAI API token. When the token is valid, the settings page lists the models your
account can use — that's your confirmation the connection works. Pick a default
model, then create an **AI conversation** node and send a message to test the
round trip.
