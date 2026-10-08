# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Media** module (`media`).
- The **Entity Browser** module (`drupal/entity_browser`, `~2.8`) — required, and
  used for the search/upload widgets.
- The **Bynder PHP SDK** (`bynder/bynder-php-sdk`, `~2.1`), installed automatically
  by Composer.
- A **Bynder account** with API access, so you can create a permanent token (and,
  for uploads, an OAuth2 app).
- **Optional extras**, depending on which features you want:
  - [DropzoneJS](https://www.drupal.org/project/dropzonejs) — enables the "Upload to
    Bynder" widget.
  - [Entity Usage](https://www.drupal.org/project/entity_usage) — required by the
    `bynder_usage` submodule for usage tracking.
  - [Remote Stream Wrapper](https://www.drupal.org/project/remote_stream_wrapper) —
    lets you serve remote Bynder thumbnails without downloading them locally.

## Install with Composer

From the project root:

```bash
composer require drupal/bynder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will pull in the Bynder PHP SDK and Entity Browser.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bynder -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bynder -y
```

## Handling your Bynder credentials

Your permanent token and OAuth client secret are credentials — don't commit them to
version control. Enter them on the settings form for local work, but for real
environments the recommended pattern is to keep the values in environment variables
and override the config per environment in `settings.php`, for example:

```php
$config['bynder.settings']['permanent_token'] = getenv('BYNDER_TOKEN');
```

## Submodules — enable only what you need

Bynder ships several optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Select2 widgets** | `bynder_select2` | Nicer multi-select Select2 widgets for tags and metaproperties in the upload form. |
| **SNS integration** | `bynder_sns` | Receives near-real-time asset-change notifications from Bynder via Amazon SNS. |
| **Usage tracking** | `bynder_usage` | Tracks where each Bynder asset is used on the site (via Entity Usage) and reports it back to Bynder. Requires the Entity Usage module. |
| **Demo** | `bynder_demo` | Demo content and configuration. Requires DropzoneJS. |
| **Lightning** | `bynder_lightning` | Configuration for the Lightning distribution. |

For example:

```bash
drush en bynder_usage -y
```

## Verify it worked

Go to **Configuration → Media → Bynder** (`/admin/config/services/bynder`). If the
settings form loads, the module is installed. Enter and test your credentials next —
see [Configuration](../configuration/index.md).
