# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Language** module (`language`) and the **Search API** module
  (`search_api`) — Drupal enables Language as a dependency, and you will need Search
  API installed.
- An **Azure AI Search** service (formerly Azure Cognitive Search) with the endpoint
  and API keys to connect to it.
- The **Key** module is recommended so you can store the Azure keys as managed
  secrets (the module ships a key submodule for this).

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_aais -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_aais -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_aais -y
```

## Optional submodules

Enable these only if you need them:

- **Autocomplete** — an autocomplete suggester for the Search API Autocomplete
  module.
- **Logging** — a scoring widget (upvote/downvote) on the semantic answer, tracking
  of semantic answers, and logging of semantic searches to the Drupal database.
- **Key** — store the Azure credentials as managed secrets.

## Next steps

The connection to Azure and the server/index setup happen in Search API — see
[Configuration](../configuration/index.md), and refer to the module's own README for
Azure-specific details.
