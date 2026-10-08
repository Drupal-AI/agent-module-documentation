# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), configured with
  a working **vision‑capable** AI provider.
- The **[Key](https://www.drupal.org/project/key)** module (`key`) — used to
  store the AI provider's API key as a secret, backed by an environment variable.

## Install with Composer

From the project root:

```bash
composer require drupal/aidmi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aidmi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aidmi -y
```

This ensures `ai` and `key` are enabled too. Then grant
`generate aidmi accessibility` to the editors who should generate alt text.

## Storing the API key

The AI provider's API key should be kept out of plain configuration. Store it in
an environment variable and reference it through the **Key** module (env
provider), as the AI module supports — never paste it directly into a settings
form.
