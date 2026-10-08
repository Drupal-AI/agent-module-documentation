# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — enabled in standard Drupal installs.
- The **AI** module (`ai`) — the `drupal/ai` project — enabled and configured with
  a provider whose model can look at an image and describe it. AI Image Filename
  does not talk to any AI service directly; it reuses whatever provider the AI
  module is set up with.

You will also need an account and API key with your chosen AI provider (for
example OpenAI). Store that key as an environment-backed secret and reference it
through a **Key** entity in the AI module — do not commit it or paste it into
plain configuration. On DDEV you can set it once with
`ddev dotenv set .ddev/.env --openai-api-key=<value>` and `ddev restart`, then
point a Key entity at the `OPENAI_API_KEY` variable.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_image_filename -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_image_filename -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_image_filename -y
```

There is no submodule to choose and no settings form to fill in. Once the AI
module has a working image-capable provider, uploaded images are renamed
automatically — see [How to use it](../index.md#how-to-use-it).
