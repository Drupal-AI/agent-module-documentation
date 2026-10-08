# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- An **OpenAI API access token**. Create one by signing up at the OpenAI platform
  and generating a key at `https://platform.openai.com/account/api-keys`.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/open_ai_metadata -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/open_ai_metadata -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en open_ai_metadata -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to enter your
OpenAI token and choose which content types get the generation buttons. Once
that's done, edit a node of a selected type — you should see a **Generate
Metadata** button and a **Generate Content** link on the form.

> **Heads up:** the module's admin routes reference custom permissions it doesn't
> define, so the settings pages may only be reachable as user 1 (the superuser)
> until those permissions are supplied. If you can't reach the settings, log in as
> user 1.
