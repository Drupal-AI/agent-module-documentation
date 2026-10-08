# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — enabled automatically as a dependency.
- Two JavaScript libraries you install by hand (below): **D3** and **D3 Cloud**.

## Install with Composer

From the project root:

```bash
composer require drupal/md_wordscloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/md_wordscloud -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the D3 libraries

MD Wordscloud draws the cloud with D3, so you must add two libraries to your site's
`libraries` directory. The module will not render a cloud until these files are present at
exactly these paths:

1. **D3** — download the D3 library, extract it, and rename the folder to `d3` so the file
   sits at:

   ```
   /libraries/d3/d3.min.js
   ```

2. **D3 Cloud** — download the D3 Cloud library, extract it, and rename the folder to
   `d3-cloud` so the file sits at:

   ```
   /libraries/d3-cloud/build/d3.layout.cloud.js
   ```

## Enable the module

```bash
drush en md_wordscloud -y
```

## Verify it worked

Go to **Structure → Block layout** and click a **Place block** button — an **MD
WordsCloud** block should be available to place. After you place and configure one (see
"How to use it" in the [overview](../index.md)) and have taxonomy terms attached to
content, the cloud should render in its region. If the block area is empty, double‑check
that the two D3 library files are at the exact paths listed above.
