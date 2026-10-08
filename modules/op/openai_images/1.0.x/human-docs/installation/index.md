# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Media** module (`media`) — Drupal enables it automatically as a
  dependency.
- An **OpenAI API key**. Create one in your OpenAI account at
  `platform.openai.com/account/api-keys`.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/openai_images -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openai_images -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openai_images -y
```

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) and enter your
OpenAI API key. Then use the create‑image form to generate a test image from a
short prompt, and confirm it appears as a media entity in your media library at
**Content → Media**.
