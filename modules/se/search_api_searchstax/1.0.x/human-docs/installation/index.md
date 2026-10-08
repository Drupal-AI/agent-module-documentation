# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API** module (`search_api`) — enabled by Drupal as a dependency.
- A **SearchStax account** with a provisioned Solr deployment, and its connection
  credentials.

There are no third-party Composer packages or PHP library requirements declared
by the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_searchstax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_searchstax -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Store your SearchStax credentials safely

Do not paste the connection secret into exported configuration. Save it as an
environment variable — with DDEV, for example:

```bash
ddev dotenv set .ddev/.env --searchstax-key=<value>
ddev restart
```

Then reference it from a Key entity (install the Key module if needed) or from
`settings.php`, so the secret stays out of version control.

## Enable the module

```bash
drush en search_api_searchstax -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) and add a server. The SearchStax connector
should appear as an available backend. Enter your connection details, save, and
the server status should report a successful connection to your SearchStax
deployment.
