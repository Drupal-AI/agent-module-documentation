# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) enabled — this is the only dependency,
  and it provides the URL language negotiation the module builds on.
- For the module to actually do anything, your site must have **exactly one**
  language enabled, with core's **URL** language negotiation set to **Path prefix**
  and a prefix configured for that language. See
  [How to set it up](../index.md#how-to-set-it-up) in the main guide.

There are no third-party Composer or PHP library requirements, and the module adds
no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/single_language_url_prefix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/single_language_url_prefix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en single_language_url_prefix -y
```

Enabling the module is not enough on its own — it only kicks in once core's URL
language negotiation is configured for path prefixes and a single language. Follow
[How to set it up](../index.md#how-to-set-it-up) in the main guide to complete the
configuration.
