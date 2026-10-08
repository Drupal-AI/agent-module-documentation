# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- The **Elasticsearch Helper** module (`elasticsearch_helper`) — the base layer that
  holds the Elasticsearch connection.
- A running **Elasticsearch cluster**, with Elasticsearch Helper's connection
  already configured. (In practice you'll also have content indices defined — often
  via
  [Elasticsearch Helper Content](https://www.drupal.org/project/elasticsearch_helper_content) —
  since preview is enabled per content index.)
- A **decoupled front-end application** able to render a preview from a temporary
  Elasticsearch document at the preview path you configure.

There are no additional Composer libraries or PHP extensions required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_helper_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Elasticsearch Helper — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_helper_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_helper -y
drush en elasticsearch_helper_preview -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Elasticsearch Helper → Preview**
(`/admin/config/search/elasticsearch_helper/preview`) and confirm the settings form
loads. Then enable preview on a content index and open a node of that type — you
should see a preview button on the edit form. See
[Configuration](../configuration/index.md) for the full setup.
