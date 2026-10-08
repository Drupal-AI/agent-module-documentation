# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`). 2.19.x is verified
  through Drupal 11.4.
- A **large set of contrib dependencies**, which Composer installs automatically.
  Among them: Context, CTools, EVA, File Replace, Filehash, Flysystem, JSON-LD, JWT,
  Migrate Plus, Migrate Source CSV, Prepopulate, Search API, Token, and the Action
  module — plus several core modules (Media, Node, Taxonomy, REST, Basic Auth, Block,
  Content Translation, Link, Options, Path, Text, Views UI).
- Three **non-Drupal PHP libraries** pulled in by Composer: `islandora/chullo` and
  `islandora/fedora-entity-mapper` (Fedora integration) and `stomp-php/stomp-php`
  (the message-broker client).
- **External infrastructure** for the full stack, running outside Drupal: a STOMP/AMQP
  message broker (ActiveMQ by default), the Islandora microservices/Alpaca, and —
  optionally — a Fedora 6 repository and a Solr server for search. These are set up
  separately; see the [Islandora documentation](https://islandora.github.io/documentation/).

Because of the breadth of this stack, most people run Islandora on the project's
prebuilt environment (ISLE / islandora-starter-site) rather than assembling it by
hand.

## Install with Composer

From the project root:

```bash
composer require drupal/islandora -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Given the size of the dependency tree, expect this to pull in
many packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/islandora -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en islandora -y
```

Drupal enables the many dependency modules automatically.

## Upgrading from 2.18.x

2.19.0 **removes the deprecated `islandora_advanced_search` submodule**. If your site
had it enabled, uninstall it before (or as part of) the update, otherwise the update
will fail to find the module:

```bash
drush pm:uninstall islandora_advanced_search -y
```

Then run the Composer update and database updates as usual:

```bash
composer update drupal/islandora -W
drush updatedb -y
drush cache:rebuild
```

There are no new configuration keys or permissions to review after the update.

## Submodules — enable the pipelines you need

Islandora Core provides the framework; the actual derivative pipelines and extras
come from submodules. Enable the ones you need with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Image** | `islandora_image` | Image derivative generation (thumbnails, service files). |
| **Audio** | `islandora_audio` | Audio derivative generation. |
| **Video** | `islandora_video` | Video derivative generation. |
| **IIIF** | `islandora_iiif` | IIIF manifests (Image API v3) and image tiles for viewers. |
| **Text Extraction** | `islandora_text_extraction` | OCR / HOCR text extraction from documents. |
| **Text Extraction Defaults** | `islandora_text_extraction_defaults` | Default config for text extraction. |
| **Breadcrumbs** | `islandora_breadcrumbs` | Breadcrumbs built from the `field_member_of` hierarchy. |
| **Core Feature** | `islandora_core_feature` | The base fields/taxonomies as a Features config package. |
| **Microservice Rewrite** | `islandora_microservice_rewrite` | URL-rewrite settings for microservice callbacks. |

> **Note:** the old **Advanced Search** submodule (`islandora_advanced_search`) shipped
> in 2.18.x and earlier is **no longer part of 2.19.x**. Enhanced/faceted search is now
> handled by the standalone
> [Islandora Advanced Search](https://www.drupal.org/project/islandora_advanced_search)
> project instead.

There are also two suggested helper modules:
[Transliterate Filenames](https://www.drupal.org/project/transliterate_filenames)
(sanitizes uploaded filenames) and
[Config Override Inspector](https://www.drupal.org/project/coi).

## Verify it worked

Go to **Configuration → Islandora → Core Settings** (`/admin/config/islandora/core`).
If the settings form loads, the module is installed. Next, see
[Configuration](../configuration/index.md).
