# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- The **Search API** module (`drupal/search_api:^1.39`) — the framework this backend
  plugs into.
- A **running OpenSearch cluster** the site can reach. Without one, you can create
  the configuration but indexing and queries won't work.
- These PHP libraries, which Composer installs automatically:
  `opensearch-project/opensearch-php` (the official client), `makinacorpus/php-lucene`,
  and `guzzlehttp/guzzle`.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_opensearch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Search API and the
required PHP libraries.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_opensearch -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_opensearch -y
```

This also enables Search API if it is not already on.

## Optional submodules

Enable these only if you need them:

| Submodule | Machine name | What it adds | Extra requirement |
|-----------|--------------|--------------|-------------------|
| **AWS Signature Connector** | `search_api_aws_signature_connector` | An `aws_signature` connector so you can reach **Amazon OpenSearch Service** with signed requests. | The `aws/aws-sdk-php` library. |
| **OpenSearch Location** | `search_api_opensearch_location` | A `location` (geo_point) Search API data type for indexing geospatial data. | The **Geofield** module (`drupal/geofield`). |

For example, to add the AWS connector:

```bash
composer require aws/aws-sdk-php -W
drush en search_api_aws_signature_connector -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and click **Add server**. In the backend list you
should now see **OpenSearch**. Continue to [Configuration](../configuration/index.md)
to set it up.
