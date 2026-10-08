# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) — the core AI framework this provider plugs into.
- The **Key** module (`key`) — used to store your Zhipu credential securely.
  Drupal pulls both in as dependencies.
- A **Zhipu AI account** and an API key.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_zhipuai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_zhipuai -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_zhipuai -y
```

This also enables the AI and Key modules if they are not already on.

## Store your Zhipu credential as a Key

Never paste the Zhipu API key into a plain settings field or commit it to code.
Store it as an environment variable and reference it through a **Key** entity:

1. Put the credential in an environment variable. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --zhipuai-api-key='<your-key>'
   ddev restart
   ```

   (Keep `.ddev/.env` out of version control.)

2. Create a Key that reads that variable. Either use the UI at **Configuration →
   System → Keys → Add key** and choose the *Environment* provider, or run:

   ```bash
   ddev drush key:save zhipuai_api_key --label='Zhipu API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"ZHIPUAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

3. Select this Key when you configure the Zhipu provider in the AI module's
   provider administration.

## Verify it worked

Go to the AI module's provider settings (under **Configuration →** the **AI**
section). **Zhipu** should appear as an available provider. After you attach the
Key, its models become selectable anywhere a feature lets you choose a provider
for chat or text generation.
