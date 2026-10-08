# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Token** module (`drupal/token`, `^1.0`) — the share URLs use Token
  placeholders such as `[current-page:url]` and `[current-page:title]`, so Token
  is a hard dependency.
- Core's **Field** module (`field`), which the `social_media` field type builds on
  (enabled on any standard site).
- Core's **Block** module if you want to place the share links as a block (the
  usual way).

## Install with Composer

From the project root:

```bash
composer require drupal/social_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_media -y
```

This also enables Token if it is not already on. The module ships no submodules.
Once enabled, several networks (Facebook share, Facebook Messenger, LinkedIn,
Twitter/X, Pinterest, Email) are on by default, while WhatsApp and Print ship
disabled. Nothing appears on the site yet, though — you need to place the block or
add the field. See [Configuration](../configuration/index.md) for the next steps.
