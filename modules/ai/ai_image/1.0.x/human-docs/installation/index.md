# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **AI** module (`ai`) with a configured **text-to-image** provider (for
  example OpenAI DALL·E or a Stable Diffusion provider).
- The **Key** module (`key`) — used to store the provider's API key.
- Core **CKEditor 5** with a text format you can add the button to.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ai_image -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_image -y
```

## Configure the provider and its key

1. Save your provider's API key into an environment variable, for example
   `ddev dotenv set .ddev/.env --openai-api-key=<value>`, then `ddev restart`.
2. Create a **Key** entity that reads from that variable (Key → env provider) at
   `/admin/config/system/keys`.
3. Configure a text-to-image provider in the AI module and point it at that Key.

## Add the button to the editor

Edit a CKEditor 5 text format at **Configuration → Content authoring → Text
formats and editors** and drag both the core **Image** button and the module's
**AI Image** button into the active toolbar, then save. You can select the
provider and model per editor in the plugin's settings.
