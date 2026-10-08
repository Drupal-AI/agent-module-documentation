# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`), configured with a
  provider that offers **embeddings** (hosted, such as OpenAI/Mistral, or local,
  such as Ollama).
- The **[Search API module](https://www.drupal.org/project/search_api)**
  (`search_api`, `>=8.x-1.40`).
- A **vector database** the embeddings can be written to and queried from
  (configured through the AI ecosystem's vector-DB provider for your chosen
  store).

> **Status:** the info file declares `lifecycle: experimental` and the release is
> `2.0.0-alpha2`. Treat it as pre-production and test thoroughly before relying on
> it.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the AI
and Search API modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_search -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_search -y
```

Enabling it also enables the AI and Search API modules if they are not on yet. The
module ships no submodules.

Continue to [Configuration](../configuration/index.md) to create a server and
index.
