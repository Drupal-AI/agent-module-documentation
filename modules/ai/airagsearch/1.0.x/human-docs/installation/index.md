# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Search API](https://www.drupal.org/project/search_api)** module
  (`search_api`) — provides the retrieval side that grounds the answers.
- A configured **AI chat provider/model** (through the AI provider layer) for the
  generation side.

## Install with Composer

From the project root:

```bash
composer require drupal/airagsearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/airagsearch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en airagsearch -y
```

This ensures `search_api` is enabled too. Then build a Search API index over your
content and grant the two permissions (`administer ai search settings`,
`access ai search api`) to the appropriate roles.

> **Note:** this release is a beta (1.0.0‑beta1). Test before relying on it in
> production.
