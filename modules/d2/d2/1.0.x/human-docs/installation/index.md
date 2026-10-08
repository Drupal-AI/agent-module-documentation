# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **`d2` command‑line binary** installed on the server — the module renders
  diagrams by running this executable. Install it from the
  [D2 project](https://d2lang.com/) and keep it updated.
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/d2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the PHP wrapper
library and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/d2 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. Remember the `d2` **binary**
> must be present *inside* whatever environment renders the diagrams (for DDEV,
> that's the web container).

## Install the `d2` binary

The module invokes the `d2` executable, so it must be on the server's `PATH`.
Follow the D2 project's installation instructions for your operating system, then
confirm it runs (for example, `d2 --version`). Without the binary present, diagram
generation will fail.

## Enable the module

```bash
drush en d2 -y
```

To embed diagrams in content, also enable the text‑filter submodule:

```bash
drush en d2_filter -y
```

## Verify it worked

If you enabled `d2_filter`, go to **Configuration → Content authoring → Text
formats and editors**, edit a text format, enable the **D2** filter, and save.
Then create content in that format containing a small D2 snippet and confirm a
rendered SVG diagram appears. If nothing renders, check that the `d2` binary is
installed and reachable on the server.
