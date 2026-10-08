# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) with a **configured AI provider** — this module uses
  the AI framework to generate embeddings, so you need at least one provider (for
  example OpenAI or Ollama) installed and set up with its credentials.
- **Search API Solr 4.x** and a **Solr 9.6 or higher** server. Dense-vector fields
  are a Solr 9.6+ capability; an older Solr cannot do this.

There are no third-party PHP library requirements declared by the module itself,
but the AI provider you choose may have its own.

> **Note:** this 1.0.x release is an **alpha** (1.0.0-alpha9). Treat it as
> experimental.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_solr_dense_vector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr_dense_vector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Store any AI provider credentials safely

Your AI provider's API key is a live secret. Keep it in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and surface it to Drupal through a Key entity — never commit it to
the repository.

## Enable the module

```bash
drush en search_api_solr_dense_vector -y
```

## Verify it worked

On your Search API index's **Processors** page, the **Dense Vector** processor
should now be available to enable. Once configured (see
[Configuration](../configuration/index.md)), you should be able to run
vector-based searches against Solr.
