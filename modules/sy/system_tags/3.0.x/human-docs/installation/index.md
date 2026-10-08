# Installation

## Requirements

System Tags needs:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer**.
- Core's **Field** and **Path alias** modules — enabled automatically as
  dependencies. (Field lets you attach the tag reference field; Path alias is used
  by the tokens to return aliased paths.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/system_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/system_tags -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en system_tags -y
```

On enable, three default tags are created: `homepage`, `access_denied`, and
`page_not_found`.

## Optional submodule — System Tags: Theme

The **System Tags: Theme** submodule (`system_tags_theme`) adds
`node--system-tag--<tag>` template suggestions and body classes for the current
node's tags, so you can style or template pages differently based on their tag
(for example a dedicated `node--system-tag--homepage.html.twig`). Enable it only
if you want that theming layer:

```bash
drush en system_tags_theme -y
```

It requires the base System Tags module, which is already present once you've
installed it above.

## After enabling

1. Grant the System Tags permissions at **People → Permissions** — see
   [Configuration](../configuration/index.md).
2. Add a **System Tag** reference field to the content types you want to tag, then
   start tagging content.
