# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Image** module (always available).
- The **`tinify/tinify`** PHP library (`^1`) — the official TinyPNG client.
  Because it's a Composer requirement of the module, installing with Composer
  (below) pulls it in automatically.
- A **TinyPNG / Tinify API key** — sign up at
  [tinypng.com/developers](https://tinypng.com/developers). The free tier
  includes 500 compressions per month.

## Install with Composer

From the project root:

```bash
composer require drupal/tinypng -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer also downloads the required `tinify/tinify`
library as part of this step — no separate download needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tinypng -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tinypng -y
```

Nothing is compressed until you enter a valid API key. Continue to
[Configuration](../configuration/index.md).

## Keep your API key out of version control

Your TinyPNG API key is a secret. While the module stores it in the
`tinypng.settings` configuration, avoid committing the real key in a plain
config export. Follow your project's convention for secrets — for example keep
the value in an environment variable and set the config from it during
deployment, rather than hard-coding it into committed configuration.

## Permission

TinyPNG adds one permission that controls access to its settings form:
**`administer tynipng`**. (Note the spelling — the permission id is misspelled in
the module itself, but that is the literal id you'll see at **People →
Permissions**.) Grant it to trusted administrators.

This module ships no submodules.
