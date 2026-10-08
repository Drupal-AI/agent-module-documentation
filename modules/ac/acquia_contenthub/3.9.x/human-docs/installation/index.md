# Installation

## Requirements

- **Drupal 9.4.15+, 10, or 11** (`core_version_requirement: ^9.4.15 || ^10 || ^11`).
- An **Acquia Content Hub subscription** and its credentials (API key, secret key,
  and service hostname). Without a Content Hub service to connect to, the module
  has nothing to talk to.
- Several Composer libraries, pulled in automatically by `composer require`:
  - `acquia/content-hub-php` (`^3.9.0`) — the Content Hub client library.
  - `drupal/depcalc` (`^1.23`) — the dependency‑calculation module the pipeline
    relies on (also a module dependency, enabled with the base module).
  - `spatie/ssl-certificate` — certificate handling.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_contenthub -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_contenthub -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en acquia_contenthub -y
```

Drupal enables the **depcalc** module at the same time as a dependency.

## Enable the role submodules you need

The base module only provides the connection. Enable the submodules for the role
each site plays:

| Submodule | Machine name | Role |
|-----------|--------------|------|
| **Publisher** | `acquia_contenthub_publisher` | Exports content; manages the export queue and exclusion settings. |
| **Subscriber** | `acquia_contenthub_subscriber` | Imports content; tracks imported entities; runs the import queue. |
| **Curation** | `acquia_contenthub_curation` | Curate/discover syndicated content in the admin UI. |
| **Dashboard** | `acquia_contenthub_dashboard` | Monitor syndication health from a dashboard. |
| **Metatag** | `acquia_contenthub_metatag` | Metatag / canonical handling. |
| **Moderation** | `acquia_contenthub_moderation` | Import into a chosen workflow moderation state. |
| **Translations** | `acquia_contenthub_translations` | Selectively import only chosen languages. |
| **Site Health** | `acquia_contenthub_site_health` | Drupal/Content Hub compatibility audits. |
| **Unsubscribe** | `acquia_contenthub_unsubscribe` | Disconnect individual entities from further updates. |
| **S3** | `acquia_contenthub_s3` | S3‑hosted file support (deprecated). |

For example, an authoring site typically enables the publisher:

```bash
drush en acquia_contenthub_publisher -y
```

and a delivery site enables the subscriber:

```bash
drush en acquia_contenthub_subscriber -y
```

## Next steps

Once the modules are enabled, connect the site to Content Hub and supply its
credentials — see [Configuration](../configuration/index.md).
