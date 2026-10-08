# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8** or newer.
- **Devel** (`drupal/devel`) with its **Devel Generate** submodule — that is what
  actually generates the content; this module just makes the output realistic.

## Install with Composer — as a development dependency

Because this is a developer tool that must not run in production, install it into
your **dev** dependencies with `--dev`:

```bash
composer require --dev drupal/realistic_dummy_content -W
```

If you don't already have Devel:

```bash
composer require --dev drupal/devel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/realistic_dummy_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable Devel Generate and Realistic Dummy Content (only in a development
environment):

```bash
drush en devel_generate realistic_dummy_content -y
```

### Submodule

- **Realistic Dummy Content API** (`realistic_dummy_content_api`) — the engine that
  scans modules for a `realistic_dummy_content/` directory and swaps in the content
  it finds. The main module depends on it, so it's enabled automatically. If you
  want *only* your own supplied content (not the bundled stock images), enable
  `realistic_dummy_content_api` on its own — alongside your custom module — and
  leave the main `realistic_dummy_content` module disabled.

## Verify it worked

Generate a few users and articles — for example via **Configuration → Development →
Generate**, or `drush devel:generate-content 5`. The new users should have portrait
photos and the new articles should have real stock photos and plausible text
instead of placeholder boxes. See the [main guide](../index.md#how-to-use-it) for
supplying your own content.
