# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — the core AI framework this provider plugs into.
- The **Key** module (`key`) — used to store your Yandex credential securely.
  Drupal will pull both in as dependencies.
- A **Yandex Cloud account** with access to YandexGPT and an API key (or IAM
  credential) you can supply.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_yandex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_yandex -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_yandex -y
```

This also enables the AI and Key modules if they are not already on.

## Store your Yandex credential as a Key

Never paste the Yandex API key into a plain settings field or commit it to code.
Store it as an environment variable and reference it through a **Key** entity:

1. Put the credential in an environment variable. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --yandex-api-key='<your-key>'
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.)

2. Create a Key that reads that variable. Either use the UI at **Configuration →
   System → Keys → Add key** and choose the *Environment* provider, or run:

   ```bash
   ddev drush key:save yandex_api_key --label='Yandex API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"YANDEX_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. Select this Key when you configure the Yandex provider in the AI module's
   provider administration.

## Verify it worked

Go to the AI module's provider settings (under **Configuration →** the **AI**
section). **Yandex / YandexGPT** should appear as an available provider. After
you attach the Key, YandexGPT models become selectable anywhere a feature lets
you choose a provider for chat or text generation.
