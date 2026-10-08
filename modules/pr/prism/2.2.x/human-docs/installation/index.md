# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Prism.js library files** (`prism.js` and `prism.css`), which are **not**
  bundled with the module and must be downloaded and installed separately (see
  below).

## Install with Composer

From the project root:

```bash
composer require drupal/prism -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prism -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the Prism.js library

The module needs the Prism.js library placed in your site's libraries directory:

1. Go to <https://prismjs.com/download.html> and use the download tool to build a
   `prism.js` and `prism.css`. **Select only the languages, theme, and plugins your
   site actually needs** — the full grammar set is large, and a lean build keeps the
   payload small. This is also where you choose a theme and enable plugins like line
   numbers and copy‑to‑clipboard.
2. Place the resulting files at **`/libraries/prism/`** (Drupal 8+). Both
   `prism.js` and `prism.css` should live under that folder.

## Enable the module

```bash
drush en prism -y
```

## Verify it worked

Confirm the library files are present under `/libraries/prism/`, then enable the
**"Highlight code using prism.js"** filter on a text format (or add a **Prism.js**
field) — see [How to use it](../index.md#how-to-use-it). Create some content with a
code block and check that it renders with syntax colouring in the language you chose.
