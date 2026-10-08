# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Document Loader** (`document_loader`) module — the framework this plugin
  extends.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/document_loader_plugin_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Document Loader and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/document_loader_plugin_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en document_loader_plugin_api -y
```

This also enables **Document Loader** if it is not already on.

## Store any API credentials securely

If the endpoint you fetch from requires an API key or token, keep that secret in an
environment variable rather than in committed configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --my-api-token=YOUR_TOKEN
ddev restart
```

(`.ddev/.env` must stay out of version control.) On other hosts, set the environment
variable through your hosting platform, and reference it from settings rather than
hard-coding the value.

## Verify it worked

Visit **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`) — the **API** loader should now appear as an
available plugin. Point it at an endpoint, choose an output format, and use the test
tool to confirm the response is fetched and converted.
