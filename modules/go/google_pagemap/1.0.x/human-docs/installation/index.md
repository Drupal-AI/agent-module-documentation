# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Preprocessor Plugins** module (`drupal/preprocessors`) — its HTML
  preprocessor plugin adds the PageMap markup to the page head. Composer installs it
  with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/google_pagemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer also install the required
`preprocessors` module alongside this one.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_pagemap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_pagemap -y
```

Enabling Google PageMap Embed pulls in the Preprocessor Plugins module as a
dependency if it isn't already on.

## Verify it worked

Go to **Configuration → Search and metadata → PageMap**
(`/admin/config/search/pagemap`) — the configuration page should load, listing your
content types. Continue to [Configuration](../configuration/index.md).
