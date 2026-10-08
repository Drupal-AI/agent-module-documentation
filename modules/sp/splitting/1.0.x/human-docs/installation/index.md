# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Splitting.js** JavaScript library. Download the latest version from its
  GitHub project and place it where Drupal can load it (see the project's
  `README.txt` for the exact library path). The module loads this library on every
  page.
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/splitting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/splitting -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en splitting -y
```

## Optional: enable the Splitting UI submodule

If you want to configure Splitting from the admin interface instead of writing
JavaScript, also enable the bundled submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Splitting UI** | `splitting_ui` | A settings form at **Configuration → User interface → Splitting** where you list CSS selectors to split and manage a few global options — no coding required. |

```bash
drush en splitting_ui -y
```

## Verify it worked

With the base module enabled, the Splitting.js library loads on your pages; call
`Splitting()` from your theme JS to see elements split into words and characters.
If you enabled Splitting UI, visit its settings page (see
[Configuration](../configuration/index.md)), add a selector, and check that the
targeted text is wrapped per word/character on the front end.
