# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — standard in Drupal.
- The contributed **[Image Effects](https://www.drupal.org/project/image_effects)**
  module (`image_effects`) — Composer pulls this in automatically with the `-W`
  flag.
- An **API key** from [remove.bg](https://www.remove.bg/) or rembg.com.
- Outbound network access from your Drupal server to the provider's API endpoint.

## Install with Composer

From the project root:

```bash
composer require drupal/removebg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Image Effects
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/removebg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en removebg -y
```

Image Effects (and core Image) are enabled as dependencies.

## Verify it worked

Grant the **administer removebg** permission to your administrator role, then visit
**Configuration → remove.bg** (`/admin/config/removebg`) and confirm the settings
form loads. After entering a valid API key, the form can show your account
status/credits by calling the provider. Then edit an image style at
**Configuration → Media → Image styles**, confirm **remove.bg** appears in the list
of effects you can add, and test it on a sample image.
