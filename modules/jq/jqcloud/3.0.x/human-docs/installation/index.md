# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Block** module (`block`) — needed for the word‑cloud blocks; Drupal
  enables it as a dependency.
- The third‑party **jQCloud JavaScript library** (installed into `/libraries`, see
  below).

## Install the module with Composer

From the project root:

```bash
composer require drupal/jqcloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jqcloud -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the jQCloud library

The module needs the jQCloud plugin's JavaScript, which is not bundled:

1. Download the latest release of the **jQCloud (Danrod96)** library.
2. Extract the files into the **`/libraries/jqcloud/dist`** directory of your site.
3. **Rename** `jqcloud-1.0.5.js` and `jqcloud-1.0.5.min.js` to **`jqcloud.js`** and
   **`jqcloud.min.js`** respectively, so the module finds them by the expected
   names.

## Enable the module

```bash
drush en jqcloud -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`). You should see a
block named **"jQCloud with [VOCABULARY_NAME] vocabulary"** for each of your
vocabularies. Place one in a region and view a page in that region — the terms
should render as a word cloud. If nothing renders, re‑check that the library files
are at `/libraries/jqcloud/dist/jqcloud.js` (and `.min.js`) with exactly those
names. See the "How to use it" section of the [guide index](../index.md) for block
placement details.
