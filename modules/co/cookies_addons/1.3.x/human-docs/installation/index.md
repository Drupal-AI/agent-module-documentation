# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **COOKiES** consent‑management module (`cookies`) — Cookies Addons depends on
  it, and Composer/Drupal will bring it in as a dependency. (The 2.0.x branch of
  Cookies Addons requires COOKiES 2.0.)

There are no additional third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cookies_addons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in COOKiES and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookies_addons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookies_addons -y
```

## Submodules — enable only what you need

Cookies Addons is a toolkit of submodules; each gates a different kind of content.
Enable the ones you need with `drush en`:

| Submodule | Machine name | What it gates |
|-----------|--------------|----------------|
| **Blocks** | `cookies_addons_blocks` | Drupal blocks (by block ID), loaded on consent — useful for blocks that embed maps or social feeds. |
| **Embed Iframe** | `cookies_addons_embed_iframe` | Iframes in formatted text, via a text‑format plugin. |
| **Embed Video** | `cookies_addons_embed_video` | Video iframes such as YouTube and Vimeo, via a text‑format plugin. |
| **Fields** | `cookies_addons_fields` | Individual fields of any entity (for example a map field), configured per field in the entity's display settings. |
| **Paragraphs** | `cookies_addons_paragraphs` | Drupal paragraphs (by paragraph ID), loaded on consent. |
| **Views** | `cookies_addons_views` | Views (by view ID and display ID), loaded on consent. |

For example, to gate embedded videos:

```bash
drush en cookies_addons_embed_video -y
```

Each submodule requires the base Cookies Addons module (and COOKiES), which are
already present once you have installed the above.

## Verify it worked

Enable one submodule and set up a piece of gated content (see
[Configuration](../configuration/index.md)). Then view the page as a visitor who has
not consented to the matching service — in place of the content you should see a
placeholder with a consent overlay, and the real content should load once consent is
given.
