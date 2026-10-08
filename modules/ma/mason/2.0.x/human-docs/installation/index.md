# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`).
- Core's **Views** module (`views`), enabled on most sites by default.
- **Blazy** 3.x or newer (`blazy:blazy (>= 3.x)`) — installed with Composer below.
- The **Mason** JavaScript library (see "Add the Mason library").

## Install with Composer

From the project root:

```bash
composer require drupal/mason -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Blazy and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mason -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the Mason library

Mason needs the third‑party Mason JavaScript library, which is not distributed via
Composer:

1. Download the Mason archive from <https://github.com/DrewDahlman/Mason>.
2. Extract it and rename the extracted `Mason-master` folder to `mason`.
3. Place it under your site's `libraries` directory so the built asset is at:

   ```
   /libraries/mason/dist/mason.min.js
   ```

Without this file the grid will not render.

## Enable the module

```bash
drush en mason -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mason UI** | `mason_ui` | An admin builder at **Structure → Mason** for creating and tuning Mason grid optionsets. Enable this if you want to configure grids through the UI. |
| **Mason Example** | `mason_example` | Sample grids and a README to learn from. Handy while setting up; you can disable it afterwards. |

For example:

```bash
drush en mason_ui -y
```

## Verify it worked

Go to **Structure → Mason** (if you enabled Mason UI) and confirm the grid builder
loads, or add the **Mason** style to a test View. Once the Mason library is in
place, the grid should render as a gapless, tightly packed layout.
