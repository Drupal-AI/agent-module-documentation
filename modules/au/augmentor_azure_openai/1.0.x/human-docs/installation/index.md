# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The [**Augmentor**](https://www.drupal.org/project/augmentor) framework
  (`augmentor`), which this submodule plugs into. Augmentor itself depends on the
  **Key** module.
- An **Azure OpenAI** resource — an endpoint, a deployed model, and an API key.

> The current release is a beta (**1.0.0-beta3**) — test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/augmentor_azure_openai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Augmentor and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/augmentor_azure_openai -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en augmentor_azure_openai -y
```

Drupal enables the Augmentor dependency at the same time.

## Store the Azure endpoint and key securely

Keep the API key out of committed configuration. Store it in an environment
variable and expose it through a **Key** entity:

- With DDEV: `ddev dotenv set .ddev/.env --azure-openai-api-key=<value>` (keep
  `.ddev/.env` out of version control), then `ddev restart`. Confirm it is present
  without printing it: `ddev exec 'test -n "$AZURE_OPENAI_API_KEY"'` (exit status 0
  means set).
- Create a **Key** entity that reads that environment variable (the Key module's
  built-in *env* provider), and select it when you configure the Azure OpenAI
  augmentor.

Then create an augmentor using the Azure OpenAI provider and set its endpoint and
model. See [How to use it](../index.md#how-to-use-it).
