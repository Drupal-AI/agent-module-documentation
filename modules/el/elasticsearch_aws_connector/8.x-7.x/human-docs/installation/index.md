# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Elasticsearch Connector** module
  (`elasticsearch_connector`) — this module signs the requests that Elasticsearch
  Connector makes, so it must be present and configured with a cluster.
- An **Amazon Elasticsearch / OpenSearch domain** to connect to, and either an IAM
  role the site can assume or a set of AWS credentials (access key + secret) scoped
  to that domain.

There are no additional Composer libraries or PHP extensions required by the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/elasticsearch_aws_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elasticsearch_aws_connector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elasticsearch_aws_connector -y
```

Enable Elasticsearch Connector too if it isn't already on:

```bash
drush en elasticsearch_connector -y
```

## Verify it worked

Once enabled, go to your Elasticsearch Connector cluster form, turn on
authentication, and confirm that **Amazon Web Services - signed requests** now
appears in the **Authentication type** list. If it does, the module is wired in;
continue to [Configuration](../configuration/index.md) to enter the region and
credentials.
