# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — a standard core module, enabled automatically.
- **A module that provides tags.** The base Shortcode module ships no shortcodes of its
  own, so you also need a tag provider — the bundled **Shortcode basic tags** submodule is
  the usual choice (see below).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/shortcode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shortcode -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shortcode -y
```

On its own, the base module gives you the framework but no usable tags. Enable a tag
provider next.

## Submodules — where the actual tags come from

Shortcode ships two submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Shortcode basic tags** | `shortcode_basic_tags` | A ready‑made set of editor tags — highlight, dropcap, button, quote, image, link, block, and more. This is what most sites enable to get usable shortcodes immediately. |
| **Shortcode example** | `shortcode_example` | A worked tutorial module (a Bootstrap "column" tag) that demonstrates how to write your own shortcode plugin. Enable it if you're learning the API; you don't need it in production. |

For a typical site, enable the basic tags:

```bash
drush en shortcode_basic_tags -y
```

You can also add your own tags from a custom module by implementing a `@Shortcode` plugin —
see the sibling [`agent/`](../agent/start.md) docs for the plugin API.

## Verify it worked

After enabling, edit a text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`): the **Enabled filters** list should now include
**Shortcodes** (and **Shortcodes — HTML corrector**). Turning it on and choosing tags is
covered in [Configuration](../configuration/index.md).
