# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Media** module (`media`) enabled — this is where generated images are
  saved.
- An **OpenAI account** with an API key and Organisation ID, and available credit
  or quota, since every generation is a paid DALL·E API call.

Note that this module does **not** use the shared `ai` provider module — it calls
OpenAI directly and keeps its own credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_image_generation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_image_generation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_image_generation -y
```

There are no submodules. After enabling, go to
`/admin/content/ai_image_generation_settings` to enter your OpenAI credentials —
the **Generate Image** button stays disabled until an API key is saved. See
[Configuration](../configuration/index.md).

> **A note on the API key:** this module stores the OpenAI key in plain
> configuration (`ai_images_api.settings`) and shows it in a normal text field. It
> does not use a Key entity or environment variable, so exclude that config object
> from any shared or committed config export and treat it as a secret.
