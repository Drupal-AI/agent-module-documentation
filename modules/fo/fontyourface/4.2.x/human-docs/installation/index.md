# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11.0`).
- Core's **Taxonomy** and **Views** modules, which Drupal enables automatically as
  dependencies. Taxonomy powers the font tags (foundry, designer, classification,
  language) and Views powers the font manager listing.

There are no third-party Composer libraries for the core module. Individual
providers may need an API key or account (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/fontyourface -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This one Composer package includes the core module and all
of the provider submodules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fontyourface -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The core module on its own ships no fonts, so enable it together with at least one
provider submodule:

```bash
drush en fontyourface google_fonts_api -y
```

## Provider submodules — enable the sources you want

Each font source is a submodule. Enable only the ones you need:

| Submodule | Machine name | What it provides |
|-----------|--------------|------------------|
| **Google Fonts** | `google_fonts_api` | The free Google Fonts catalog (may require a Google API key on the settings form). |
| **Local Fonts** | `local_fonts` | Self-host your own font files instead of calling a third-party CDN. |
| **Typekit** | `typekit_api` | Adobe Fonts / Typekit kits (needs a token). |
| **Adobe Edge Fonts** | `adobe_edge_fonts` | Adobe Edge Fonts — no account or API key needed. |
| **Fonts.com** | `fontscom_api` | Monotype / Fonts.com subscription fonts (needs a token/project). |
| **Font Squirrel** | `fontsquirrel_api` | Font Squirrel's free-for-commercial-use catalog. |

For example, to add self-hosted fonts:

```bash
drush en local_fonts -y
```

Each provider requires the core @font-your-face module, which is already present
once you have installed the package above.

Next, head to [Configuration](../configuration/index.md) to import and apply fonts.
